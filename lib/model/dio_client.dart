import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import '../ConstantData/Constant_data.dart';

class ApiClients {
  final Dio _dio = Dio();
  final box = GetStorage();

  Future<Map<String, dynamic>> registerDio(String firstName,
      String lastName,
      String phoneNumber,
      String email,
      String password,
      String cpassword,
      File? profilePicture,
      File? frontImages,
      File? backImages,
      String permanentAddress,) async
  {
    String url = ApiConstant().BaseUrl + ApiConstant().registerss;

    String? sessionToken =
    GetStorage().read<String>(ConstantData.UserRegisterToken);
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
            filename: profilePicture.path
                .split('/')
                .last,
          ),
        if (frontImages != null)
          'frontImages': await MultipartFile.fromFile(
            frontImages.path,
            filename: frontImages.path
                .split('/')
                .last,
          ),
        if (backImages != null)
          'backImages': await MultipartFile.fromFile(
            backImages.path,
            filename: backImages.path
                .split('/')
                .last,
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

  /*Future<bool> sendMobileOtp(String phoneNumber) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneRegister;

    var data = {
      'phoneNumber': phoneNumber,
    };

    try {
      Response response = await _dio.post(url, data: data);

      print("OTP Send Response: ${response.data}"); // Debugging Print

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error in sendOtp: $e");
      return false;
    }
  }
*/


  Future<bool> sendMobileOtp(String phoneNumber) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneRegister;

    var data = {
      'phoneNumber': phoneNumber,
    };

    print("📡 API को OTP भेजा जा रहा है: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data);

      print("📩 API Response: ${response
          .data}"); // API का पूरा रिस्पॉन्स प्रिंट करें
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String apiMessage = response
            .data['message']; // API से 'message' चेक करें
        print("✅ API Message: $apiMessage");

        if (apiMessage.contains("OTP sent successfully")) {
          return true;
        } else {
          print("❌ API Error Message: $apiMessage");
          return false;
        }
      } else {
        print("❌ HTTP Error Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Exception: $e");

      if (e is DioError) {
        if (e.response != null) {
          print("❌ Server Response: ${e.response?.data}");
        } else {
          print("❌ Request Error: ${e.message}");
        }
      }

      return false;
    }
  }


  Future<bool> verifyMobileOtp(String phoneNumber, String otp) async {
    String url = ApiConstant().BaseUrl + ApiConstant().PhoneOTP;

    var data = {
      'phoneNumber': phoneNumber,
      'otp': otp,
    };

    try {
      Response response = await _dio.post(url, data: data);

      print("OTP Verify Response: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['message'] ==
              "Phone number verified successfully!, please verify your email") {
        return true;
      } else {
        print("OTP verification failed: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("Error in verifyOtp: $e");

      if (e is DioError) {
        if (e.response != null) {
          print("Error Response: ${e.response?.data}");
        } else {
          print("Error occurred while making the request: ${e.message}");
        }
      } else {
        print("Unknown error: $e");
      }

      return false;
    }
  }

  Future<Map<String, dynamic>?> sendEmailOtp(String phoneNumber,
      String email) async
  {
    String url = ApiConstant().BaseUrl + ApiConstant().emailRegister;

    var data = {
      'phoneNumber': phoneNumber,
      'email': email,
    };

    print("📡 Sending OTP to API: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data);

      print("📩 API Response: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("❌ HTTP Error Code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🔥 Exception: $e");
      return null;
    }
  }

  Future<bool> verifyEmailOtp(String email, String phoneNumber,
      String otp) async {
    String url = ApiConstant().BaseUrl + ApiConstant().emailOtp;

    var data = {
      'email': email,
      'phoneNumber': phoneNumber,
      'otp': otp,
    };

    print("🔍 Verifying OTP at: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data);

      print("📩 API Response: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String apiMessage = response.data['message'];
        print("✅ API Message: $apiMessage");

        if (apiMessage.contains("verified successfully")) {
          // Extracting userId and token correctly
          String userId = response.data['user']['id'];
          String token = response.data['user']['token'];

          // Storing userId and token in GetStorage
          GetStorage().write('userId', userId);
          GetStorage().write('token', token);

          print("✅ User ID & Token stored successfully!");
          return true;
        } else {
          print("❌ API Error Message: $apiMessage");
          return false;
        }
      } else {
        print("❌ HTTP Error Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Exception: $e");

      if (e is DioError) {
        if (e.response != null) {
          print("❌ Server Response: ${e.response?.data}");
        } else {
          print("❌ Request Error: ${e.message}");
        }
      }

      return false;
    }
  }


  Future<Map<String, dynamic>> ReferralCode(String referralCodes) async {
    String url = ApiConstant().AdminBaseUrl + ApiConstant().ReferralCode;

    String? sessionToken = GetStorage().read<String>('token'); // Token पढ़ना
    String? id = GetStorage().read<String>('userId'); // User ID पढ़ना

    var datas = jsonEncode({
      'id': id,
      'referralCodes': referralCodes,
    });

    print("data....>>>> $id");

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
      print("data --> ${response.data}");

      // Extract and store userId from the response
      if (response.data != null) {
        String? userId = response.data['id']?.toString(); // Ensure it's a string
        String? userReferralCode = response.data['referralCodes']?.toString(); // Assuming 'id' is in the response

        // Store user ID in GetStorage
        GetStorage().write('UserId', userId);

        // Also, store referral code if needed
        GetStorage().write('UserReferralCode', response.data['referralCodes']);
      }
      return response.data ?? {}; // Return empty map if no data is found
    } on DioError catch (e) {
      print("DioError: ${e.message}");
      return e.response?.data ?? {}; // Ensure we don't get null response data
    }
  }





  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String permanentAddress,
    required String password,
    required String gender,
  }) async {
    String? sessionToken = GetStorage().read<String>('token'); // Token पढ़ना
    String? userId = GetStorage().read<String>('userId'); // User ID पढ़ना

    print("📌 Stored User ID: $userId");
    print("📌 Stored Session Token: $sessionToken");

    if (userId == null || userId.isEmpty) {
      print("❌ Error: User ID is missing.");
      return {'success': false, 'message': 'User ID is missing'};
    }

    String url = ApiConstant().BaseUrl + ApiConstant().userRegister(userId);

    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "permanentAddress": permanentAddress,
      "password": password,
      "gender": gender,
    };

    print("📡 API Request URL: $url");
    print("🔍 Sending Data to API: $data");

    try {
      Response response = await _dio.post(url, data: data, options: Options(
        headers: {
          'Authorization': 'Bearer $sessionToken',
        },
      ));

      print("📩 Response Data: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("✅ API Response: ${response.data}");

        if (response.data.containsKey('user')) {
          String userId = response.data['user']['id'];  // API से User ID लेना
          String token = response.data['user']['token'];  // API से Token लेना

          print("✅ Extracted User ID: $userId");
          print("✅ Extracted Token: $token");

          return {
            'success': true,
            'user': {
              'id': userId,
              'token': token,
            },
            'message': 'User registered successfully',
          };
        } else {
          print("❌ Error: API Response does not contain 'user' key.");
          return {
            'success': false,
            'message': 'User registration failed: No user data received',
          };
        }
      } else {
        print("❌ HTTP Error Code: ${response.statusCode}");
        return {
          'success': false,
          'message': 'Registration failed with status code: ${response.statusCode}',
        };
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          print("❌ Server Response: ${e.response?.data}");
        } else {
          print("❌ Request Error: ${e.message}");
        }
      }
      return {
        'success': false,
        'message': 'Something went wrong. Please try again.',
      };
    }
  }


  Future<bool> loginWithPhoneOrEmail(String identifier, String password) async {
    String baseUrl = "https://rental-api-5vfa.onrender.com/";
    String url;

    if (identifier.contains('@')) {
      // Email login
      url = "${baseUrl}login";
    } else {
      // Phone login
      url = "${baseUrl}loginWithPhone";
    }

    var data = {
      identifier.contains('@') ? 'email' : 'phoneNumber': identifier,
      'password': password,
    };

    print("📡 API Call: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data);

      print("📩 API Response: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("✅ Login Successful: ${response.data['message']}");
        return true;
      } else {
        print("❌ Login Failed: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("🔥 Exception: $e");

      if (e is DioError) {
        if (e.response != null) {
          print("❌ Server Response: ${e.response?.data}");
        } else {
          print("❌ Request Error: ${e.message}");
        }
      }

      return false;
    }
  }



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
  ) async {
    String url =
        "${ApiConstant().BaseUrlGetAllCats}${ApiConstant().editUser(userId)}";
    print("Constructed URL: $url");

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
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
    String url = ApiConstant().AdminBaseUrl + ApiConstant().AdminGetCatFAQ;

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

  Future<Map<String, dynamic>> getBigViewTicket(
      String userId, String ticketNumber) async {
    String baseUrl = ApiConstant().AdminBaseUrl.endsWith("/")
        ? ApiConstant()
            .AdminBaseUrl
            .substring(0, ApiConstant().AdminBaseUrl.length - 1)
        : ApiConstant().AdminBaseUrl;

    // Correctly construct the full URL
    String url = "$baseUrl/app-support$userId/$ticketNumber";

    print("Final API URL: $url");

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
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

    String url =
        "${ApiConstant().AdminBaseUrl}${ApiConstant().getAllTicketsSupport(userId)}";
    print("Constructed URL: $url");

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
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

      if (response.headers
              .value('content-type')
              ?.contains('application/json') ??
          false) {
        return response.data;
      } else {
        throw Exception("Unexpected response format: ${response.data}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio Error Response: ${e.response?.data}");
        throw Exception(
            "Error fetching data: ${e.response?.statusCode ?? 'Unknown Status Code'} - ${e.response?.data}");
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

    String url =
        "${ApiConstant().AdminBaseUrl}${ApiConstant().getAllTicketsSupport(userId)}";
    print("Constructed URL: $url");

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
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
        throw Exception(
            "Error fetching data: ${e.response?.statusCode ?? 'Unknown Status Code'} - ${e.response?.data}");
      } else {
        print("Dio Error Message: ${e.message}");
        throw Exception("Dio Error: ${e.message}");
      }
    }
  }

  Future<Map<String, dynamic>> getAllSubCat(String categoryId) async {
    String url =
        "${ApiConstant().BaseUrlGetAllCats}${ApiConstant().getAllSubCatagries(categoryId)}";
    print("Constructed URL: $url");

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
    print("Authorization Token: $sessionToken");

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization':
                'Bearer $sessionToken', // Send the authorization token
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
  ) async {
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

  Future<Map<String, dynamic>> getLogoutUser(
      String email, String password) async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().logout}";
    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);

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
    String url = ApiConstant().BaseUrl + ApiConstant().getDisplayProductList;

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

/*
  Future<Map<String, dynamic>> getBusinessAdss() async {
    String url = ApiConstant().AdminBaseUrl + ApiConstant().getBusinessAds;
    print("fffffffffff: $url");
    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
          },
        ),
      );

      // Debugging: print the status code and response data
      print("getBusinessAdss Status Code --> ${response.statusCode}");
      print("Response Data --> ${response.data}");

      // Check if the response is a successful one (statusCode 200)
      if (response.statusCode == 200) {
        // Assuming the server returns JSON that can be mapped to a Map<String, dynamic>
        return response.data is Map<String, dynamic> ? response.data : {};
      } else {
        // Handle non-200 responses (for example, 404, 500, etc.)
        print("Error: Received status code ${response.statusCode}");
        return {}; // Returning an empty map or a fallback value
      }
    } on DioError catch (e) {
      // Handle errors from Dio (e.g., network errors, etc.)
      print("Dio Error: ${e.response}");
      // Check if Dio returned a valid response
      return e.response?.data is Map<String, dynamic> ? e.response!.data : {};
    } catch (e) {
      // Handle any other type of error
      print("Error fetching business ads: $e");
      return {}; // Return an empty map as fallback
    }
  }
*/

  Future<Map<String, dynamic>> fetchBusinessAdssss() async {
    String url = ApiConstant().AdminBaseUrl + ApiConstant().getBusinessAds;
    print("urlllllllll ${url}");

    try {
      // Sending GET request to fetch business ads data
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${GetStorage().read<String>(ConstantData.UserAccessToken)}',
          },
        ),
      );

      // Check if the response status is 200 (success)
      if (response.statusCode == 200) {
        // Extracting the entire response data and returning it as Map<String, dynamic>
        return response.data
            as Map<String, dynamic>; // Return the response data
      } else {
        print("Error fetching business ads: ${response.statusCode}");
        return {}; // Return an empty map if there is an error
      }
    } catch (e) {
      print("Error fetching business ads: $e");
      return {}; // Return empty map on error
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    String url =
        "${ApiConstant().BaseUrl}${ApiConstant().deleteProducts(productId)}";

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);

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
      return e.response?.data ??
          {'success': false, 'message': 'Something went wrong'};
    }
  }

  Future<Map<String, dynamic>> PostfeedbackUser(
    String suggest,
  ) async {
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

  Future<Map<String, dynamic>> CreateTicket(
      String categoryId, String description) async {
    String url =
        ApiConstant().AdminBaseUrl + ApiConstant().AdminContactUsMessage;

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
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
    String url = ApiConstant().BaseUrlCity + ApiConstant().getCityUrl;

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
