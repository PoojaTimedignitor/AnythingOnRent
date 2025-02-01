import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import '../ConstantData/Constant_data.dart';

class ApiClients {
  final Dio _dio = Dio();
  final box = GetStorage();
  Future<Map<String, dynamic>> registerDio(
      String firstName,
      String lastName,
      String phoneNumber,
      String email,
      String password,
      String cpassword,
      File? profilePicture,
      File? frontImages,
      File? backImages,
      String permanentAddress,
      ) async
  {
    String url = ApiConstant().BaseUrl + ApiConstant().registerss;

    String? sessionToken = GetStorage().read<String>(ConstantData.UserRegisterToken);
    print("Session Token: $sessionToken");

    try {
      FormData formData = FormData.fromMap({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'cpassword': cpassword,
        'permanentAddress': permanentAddress,
        if (profilePicture != null)
          'profilePicture': await MultipartFile.fromFile(
            profilePicture.path,
            filename: profilePicture.path.split('/').last,
          ),
        if (frontImages != null)
          'frontImages': await MultipartFile.fromFile(
            frontImages.path,
            filename: frontImages.path.split('/').last,
          ),
        if (backImages != null)
          'backImages': await MultipartFile.fromFile(
            backImages.path,
            filename: backImages.path.split('/').last,
          ),
      });


   print("URL: $url");
      print("FormData: $formData");

      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $sessionToken'},
        ),
      );

      print("Response: ${response.data}");
      return response.data ?? {'error': 'No response data'};
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio Error Response: ${e.response!.statusCode}");
        print("Dio Error Data: ${e.response!.data}");
        print("Dio Error Headers: ${e.response!.headers}");
      } else {
        print("Dio Error Message: ${e.message}");
      }
      return {'error': e.message};
    }
  }


  Future<Map<String, dynamic>> registerPhoneNumber(String phoneNumber) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneRegister;
    String? sessionToken = GetStorage().read<String>(ConstantData.UserRegisterToken);

    var data = {
      'phoneNumber': phoneNumber,
    };

    try {
      Response response = await _dio.post(url, data: data,options:Options(headers: {'Authorization': 'Bearer $sessionToken'}) );
      return response.data;
    } catch (e) {
      return {'success': false, 'message': 'Kuch galat ho gaya hai'};
    }
  }


  Future<bool> PhoneNumber(String phoneNumber) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneRegister;
    String? sessionToken = GetStorage().read<String>(ConstantData.UserRegisterToken);

    try {
      Response response = await _dio.post(
        url, // ✅ Use the constructed URL here
        data: {'phoneNumber': phoneNumber},
        options: Options(
          headers: {
            "Authorization": "Bearer $sessionToken", // 🛑 Add token if needed
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.data['success']) {
        // ✅ Store userId & otp in GetStorage
        box.write('userId', response.data['phoneData']['userId']);
        box.write('otp', response.data['phoneData']['otp']);
        box.write('phoneNumber', phoneNumber);
        return true;
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
    return false;
  }




/*
  Future<Map<String, dynamic>> registerPhoneNumber(String phoneNumber) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneRegister;
    String? sessionToken = GetStorage().read<String>(ConstantData.UserRegisterToken);
    try {
      FormData formData = FormData.fromMap({'phoneNumber': phoneNumber});

      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $sessionToken'}),
      );


      return response.data ?? {'error': 'No response data received'};
    } on DioException catch (e) {


      String errorMessage = e.response?.data?['message'] ??
          e.message ??
          'Something went wrong. Please try again.';



      return {'error': errorMessage};
    }
  }
*/

  Future<bool> verifyOtp(String otp) async {
    try {
      String? userId = box.read('userId'); // 🛑 Ensure userId is stored
      if (userId == null) return false;

      String url = ApiConstant().BaseUrl + ApiConstant().PhoneOTP;
      String? sessionToken = GetStorage().read<String>(ConstantData.UserRegisterToken);

      Response response = await _dio.post(
        url, // ✅ Use constructed URL
        data: {'userId': userId, 'phoneOtp': otp},
        options: Options(
          headers: {
            "Authorization": "Bearer $sessionToken", // 🛑 Add token if required
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.data['success']) {
        // ✅ Mark phone as verified
        box.write('phoneVerified', true);
        return true;
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    }
    return false;
  }

/*
  Future<Map<String, dynamic>> sendOTP(String Otp) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneOTP;
    String? sessionToken = GetStorage().read<String>(ConstantData.UserRegisterToken);

    if (sessionToken == null || sessionToken.isEmpty) {
      return {'error': 'Unauthorized. Session token is missing or invalid.'};
    }

    try {
      FormData formData = FormData.fromMap({'phoneOtp': Otp});

      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $sessionToken'}),
      );

      print("Server Response Code: ${response.statusCode}");
      print("Full Response: ${response.data}"); // ✅ Full response print karo

      if (response.statusCode == 200 && response.data != null) {
        if (response.data.containsKey('success') && response.data['success'] == true) {
          var phoneData = response.data['phoneData'];
          String userId = phoneData['userId'];  // Extract userId
          String phoneNumber = phoneData['phoneNumber'];

          // Pass the userId and phone number to the OTP screen


          return {
            'phoneNumber': phoneNumber,
            'userId': userId,
            'phoneVerified': phoneData['phoneVerified'],
          };
        } else {
          print("❌ API Response does not contain success=true");
          return {'error': 'Invalid response from server. Please try again.'};
        }
      } else {
        print("Unexpected Response Code: ${response.statusCode}");
        return {'error': 'Server error: ${response.statusCode}'};
      }
    } on DioException catch (e) {
      String errorMessage = e.response?.data?['message'] ?? e.message ?? 'कुछ गड़बड़ है। कृपया फिर से प्रयास करें।';
      print("❌ DioException: $errorMessage");
      return {'error': errorMessage};
    } catch (e) {
      print("❌ Unexpected Error: $e");
      return {'error': 'Something went wrong. Please try again.'};
    }
  }
*/


  Future<Map<String, dynamic>> loginDio(
    String email,
    String password,
  ) async
  {

    String url = ApiConstant().BaseUrl + ApiConstant().login;

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);



    print("Session Token: $sessionToken");

    var dataa = jsonEncode({
      'email': email,
      'password': password,
    });
    print("data....> $dataa");
    try {
      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: dataa,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("statusCode --> ${response.statusCode}");
      print("dateeeee --> ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Map<String, dynamic>> getAllCat() async {
    String url =
        ApiConstant().BaseUrlGetAllCats + ApiConstant().getAllCatagries;

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getCatList Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return e.response!.data;
    }
  }

  Future<Map<String, dynamic>> editUserProfile(
      String userId,
      String firstName,
      String phoneNumber,
      String email,
      File? profilePicture,
      ) async
  {
    String url = "${ApiConstant().BaseUrlGetAllCats}${ApiConstant().editUser(userId)}";
    print("Constructed URL: $url");

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    if (sessionToken == null) {
      print("Error: Authorization token is null.");
      return {"message": "Authorization token missing"};
    }
    print("Authorization Token: $sessionToken");

    try {
      FormData formData = FormData.fromMap({
        "firstName": firstName,
        "phoneNumber": phoneNumber,
        "email": email,
        if (profilePicture != null)
          "profilePicture": await MultipartFile.fromFile(
            profilePicture.path,
            filename: profilePicture.path.split('/').last,
          ),
      });

      Response response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
        data: formData,
      );

      print("editUserProfileDataSC --> ${response.statusCode}");
      print("editUserProfileData --> ${response.data}");
      return response.data;
    } on DioError catch (e) {
      print("DioError: ${e.response}");
      return e.response?.data ?? {"message": "An error occurred"};
    }
  }


  Future<Map<String, dynamic>> getUserProfileData() async {
    String url = ApiConstant().BaseUrl + ApiConstant().userProfile;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getUserProfileDataSC --> ${response.statusCode}");
      print("getUserProfileData --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Map<String, dynamic>> getCatFAQ() async {
    String url =
        ApiConstant().AdminBaseUrl + ApiConstant().AdminGetCatFAQ;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getCatList Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return e.response!.data;
    }
  }



  Future<Map<String, dynamic>> getContactUsQuations() async {
    String url =
        ApiConstant().AdminBaseUrl + ApiConstant().AdminContactUsQuations;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getCatList Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return e.response!.data;
    }
  }




  Future<Map<String, dynamic>> getBigViewTicket(String userId, String ticketNumber) async {
    String baseUrl = ApiConstant().AdminBaseUrl.endsWith("/")
        ? ApiConstant().AdminBaseUrl.substring(0, ApiConstant().AdminBaseUrl.length - 1)
        : ApiConstant().AdminBaseUrl;

    // Correctly construct the full URL
    String url = "$baseUrl/app-support$userId/$ticketNumber";

    print("Final API URL: $url");

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    if (sessionToken == null || sessionToken.isEmpty) {
      throw Exception("Session token is missing or invalid.");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } on DioError catch (e) {
      print("DioError: ${e.response?.data ?? e.message}");
      throw Exception("Error fetching ticket: ${e.message}");
    }
  }




  Future<Map<String, dynamic>> getAllTicket(String userIds) async {
    String? userId = GetStorage().read<String>(ConstantData.UserId);

    if (userId == null || userId.isEmpty) {
      throw Exception("User ID is missing or invalid.");
    }

    print("User ID: $userId");

    String url = "${ApiConstant().AdminBaseUrl}${ApiConstant().getAllTicketsSupport(userId)}";
    print("Constructed URL: $url");

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    if (sessionToken == null || sessionToken.isEmpty) {
      throw Exception("Session token is missing or invalid.");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getAllTicket Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      if (response.headers.value('content-type')?.contains('application/json') ?? false) {
        return response.data;
      } else {
        throw Exception("Unexpected response format: ${response.data}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio Error Response: ${e.response?.data}");
        throw Exception("Error fetching data: ${e.response?.statusCode ?? 'Unknown Status Code'} - ${e.response?.data}");
      } else {
        print("Dio Error Message: ${e.message}");
        throw Exception("Dio Error: ${e.message}");
      }
    }
  }


  /*Future<Map<String, dynamic>> getBigViewTicket(String userIds,ticketNumbers) async {
    String? userId = GetStorage().read<String>(ConstantData.UserId);

    if (userId == null || userId.isEmpty) {
      throw Exception("User ID is missing or invalid.");
    }

    print("User ID: $userId");

    String url = "${ApiConstant().AdminBaseUrl}${ApiConstant().getBigSupportTicket(userId,ticketNumbers)}";
    print("Constructed URL: $url");

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    if (sessionToken == null || sessionToken.isEmpty) {
      throw Exception("Session token is missing or invalid.");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getAllTicket Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      if (response.headers.value('content-type')?.contains('application/json') ?? false) {
        return response.data;
      } else {
        throw Exception("Unexpected response format: ${response.data}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio Error Response: ${e.response?.data}");
        throw Exception("Error fetching data: ${e.response?.statusCode ?? 'Unknown Status Code'} - ${e.response?.data}");
      } else {
        print("Dio Error Message: ${e.message}");
        throw Exception("Dio Error: ${e.message}");
      }
    }
  }*/


  Future<Map<String, dynamic>> getAllTicketBig(String userIds) async {
    String? userId = GetStorage().read<String>(ConstantData.UserId);

    if (userId == null || userId.isEmpty) {
      throw Exception("User ID is missing or invalid.");
    }

    print("User ID: $userId");

    String url = "${ApiConstant().AdminBaseUrl}${ApiConstant().getAllTicketsSupport(userId)}";
    print("Constructed URL: $url");

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    if (sessionToken == null || sessionToken.isEmpty) {
      throw Exception("Session token is missing or invalid.");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getAllTicket Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      if (response.statusCode == 200) {
        // Return the simulated JSON response
        return {
          "success": true,
          "message": "Support ticket fetched successfully",
          "data": {
            "_id": "6791c792ecadc37dadd15217",
            "userId": "6747fbe4e025303ba353c08f",
            "category": {
              "_id": "67482295bf9ae0fe0e5a8683",
              "name": "sample title"
            },
            "description": "app hang out out",
            "status": "open",
            "callRequested": false,
            "callRequestedAt": null,
            "callResponseAt": null,
            "createdAt": "2025-01-23T04:37:38.782Z",
            "updatedAt": "2025-01-23T04:37:38.782Z",
            "ticketNumber": "ST1737607058782-48",
            "__v": 0
          }
        };
      } else {
        throw Exception("Unexpected response status: ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio Error Response: ${e.response?.data}");
        throw Exception("Error fetching data: ${e.response?.statusCode ?? 'Unknown Status Code'} - ${e.response?.data}");
      } else {
        print("Dio Error Message: ${e.message}");
        throw Exception("Dio Error: ${e.message}");
      }
    }
  }


  Future<Map<String, dynamic>> getAllSubCat(String categoryId) async {
    String url = "${ApiConstant().BaseUrlGetAllCats}${ApiConstant().getAllSubCatagries(categoryId)}";
    print("Constructed URL: $url");

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    print("Authorization Token: $sessionToken");

    try {

      Response response = await _dio.get(
        url,

        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken', // Send the authorization token
          },
        ),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");


      return response.data;
    } on DioError catch (e) {

      if (e.response != null) {
        print("Dio Error Response: ${e.response?.data}");
        return e.response?.data ?? {'error': 'Unknown error'};
      } else {
        print("Dio Error: No response from server.");
        return {'error': 'No response from server'};
      }
    }
  }

  Future<Map<String, dynamic>> PostCreateProductApi(
    String name,
    String description,
    String categoryName,
    int quantity,
    List<File> images, // List of selected images
    double rating,
    String productCurrentAddress,
    String price,
  ) async
  {
    String url =
        ApiConstant().BaseUrlCreateProdcut + ApiConstant().createProduct;

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
    print("Session Token: $sessionToken");

    try {
      // Preparing FormData for sending product data
      FormData formData = FormData.fromMap({
        'name': name,
        'description': description,
        'categoryName': categoryName,
        'quantity': quantity,
        'productCurrentAddress': productCurrentAddress,
        'price': price,
        'rating': rating,
        'rent': {
          'perHour': 0,
          'perDay': 0,
          'perWeek': 0,
          'perMonth': 0,
        },
        'type': 'Product',

        'images': images.map((file) {
          return MultipartFile.fromFileSync(
            file.path,
            filename: file.path.split('/').last, // Extract filename
          );
        }).toList(),
      });

      print("URL: $url");
      print("FormData: $formData");

      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $sessionToken'},
        ),
      );

      print("Responsesss: ${response.data}");
      String? type = response.data?['data']['type'];
      print("Received type: $type");
      return response.data!;
    } on DioError catch (e) {
      // Handle Dio errors and log details
      if (e.response != null) {
        print("DioError Response: ${e.response!.data}");
      } else {
        print("DioError Message: ${e.message}");
      }

      // Return error response if available
      return e.response?.data ?? {'error': 'Unknown error'};
    } catch (e) {
      // Catch any other errors
      print("Error: $e");
      return {'error': e.toString()};
    }
  }

/*  Future<Map<String, dynamic>> getLogoutUser(String email, String password) async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().logout}";
    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);

    print("Final API URL: $url");
    print("Session Token: $sessionToken");

    try {
      Response response = await _dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data is Map && response.data['success'] == true) {
          return response.data;
        } else {
          return {"error": response.data['message'] ?? "Logout failed"};
        }
      } else {
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("DioError Response: ${e.response?.data}");
        print("Error Status Code: ${e.response?.statusCode}");
      } else {
        print("DioError Message: ${e.message}");
      }
      return {"error": "Exception: ${e.message}"};
    }
  }*/

  Future<Map<String, dynamic>> getLogoutUser(String email, String password) async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().logout}";
    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);

    if (sessionToken == null || sessionToken.isEmpty) {
      return {"error": "Session token is missing. Please log in again."};
    }

    print("Final API URL: $url");
    print("Session Token: $sessionToken");

    try {
      Response response = await _dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("DioError Response: ${e.response?.data}");
        print("Error Status Code: ${e.response?.statusCode}");
      } else {
        print("DioError Message: ${e.message}");
      }
      return {"error": "Exception: ${e.message}"};
    }
  }

  Future<Map<String, dynamic>> getAllProductList() async {
    String url =
        ApiConstant().BaseUrl + ApiConstant().getDisplayProductList;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getCatList Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return e.response!.data;
    }
  }




  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().deleteProducts(productId)}";


    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("Delete Product Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return e.response?.data ?? {'success': false, 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> PostfeedbackUser(
      String suggest,

      ) async

  {
    String url = ApiConstant().AdminBaseUrl + ApiConstant().UserFeedback;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserAccessToken);

    String? userId = GetStorage().read<String>(ConstantData.UserId);


    var datas = jsonEncode({
      'user': userId,
      'suggest': suggest,
    });
    print("data....>>>> $userId");
    try {
      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: datas,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );
      print("statusCode --> ${response.statusCode}");
      print("dateeeee --> ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }


  Future<Map<String, dynamic>> CreateTicket(String categoryId, String description) async {
    String url = ApiConstant().AdminBaseUrl + ApiConstant().AdminContactUsMessage;

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
    String? userId = GetStorage().read<String>(ConstantData.UserId);

    var datas = jsonEncode({
      'userId': userId,
      'category': categoryId,
      'description': description,
    });

    print("datass....>>>> $datas");

    try {
      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: datas,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );
      print("statusCode --> ${response.statusCode}");
      print("dateeeee --> ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Map<String, dynamic>> getAllCity() async {
    String url =
        ApiConstant().BaseUrlCity + ApiConstant().getCityUrl;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      print("getCatList Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");


      return response.data;
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return e.response!.data;
    }
  }


}



