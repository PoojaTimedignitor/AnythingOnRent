
import 'dart:convert';
import 'dart:io';

import 'package:anything/api_constants.dart';
import 'package:anything/newGetStorage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import 'Authentication/login_screen.dart';



class NewDioClient {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final Dio dio = Dio(BaseOptions(
    baseUrl: "http://backend.anythingonrent.com/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  )

  );

  static void setupInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await NewAuthStorage.getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        } else {
          print(" No token found, request may fail!");
        }
        return handler.next(options);
      },
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          print("Access Token Expired, Refreshing...");

          bool refreshed = await _refreshToken();
          if (refreshed) {
            String? newAccessToken = await NewAuthStorage.getAccessToken();
            e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

            print("Retrying Request...");
            return handler.resolve(await dio.fetch(e.requestOptions));
          } else {
            print(" Refresh Token Expired Logging out...");
            await NewAuthStorage.clearStorage();

            // Navigate to the login screen after session expiry
            navigatorKey.currentState?.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
            );
          }
        }
        return handler.next(e);
      },
    ));
  }

  static Future<bool> _refreshToken() async {
    try {
      String? refreshToken = await NewAuthStorage.getRefreshToken();
      if (refreshToken == null) {
        print(" Refresh Token Found");
        return false;
      }

      Response response = await dio.post(
        "https://rental-api-5vfa.onrender.com/refresh-token",
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 && response.data['accessToken'] != null) {
        String newAccessToken = response.data['accessToken'];
        await NewAuthStorage.setAccessToken(newAccessToken);
        print(" Access Token Refreshed $newAccessToken");
        return true;
      } else {
        print(" Refresh Token Expired or Invalid!");
        return false;
      }
    } catch (e) {
      print("Refresh Token Error: $e");
      return false;
    }
  }
}

class NewApiClients {
  static final NewApiClients _instance = NewApiClients
      ._internal();
  final Dio _dio = Dio();
  final box = GetStorage();

  factory NewApiClients() {
    return _instance;
  }

  NewApiClients._internal() {
    _dio.options.baseUrl = "https://example.com";
    print("ApiClients initialized");
  }


  Future<bool> sendNewMobileOtp(String phoneNumber) async {
    String url = ApiConstants.baseUrl + ApiConstants.phoneRegister;

    var data = {'phoneNumber': phoneNumber};

    try {
      Response response = await _dio.post(url, data: data);

      print("Api URl res   :$url");
      print("Response: ${response.data}");
      print("OTP Send Response: ${response.data}");

      if (response.statusCode == 200) {
        NewAuthStorage.setPhoneNumber(phoneNumber);
        print("Phone Number Stored in AuthStorage: $phoneNumber");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error in sendOtp: $e");
      return false;
    }
  }


  Future<bool> phoneOtpVerify(String phoneNumber, String otp) async {
    String url = ApiConstants.baseUrl + ApiConstants.phoneOTP;
    var data = {
      'phoneNumber': phoneNumber,
      'otp': otp,
    };

    try {
      Response response = await _dio.post(url, data: data);
      print("OTP Verify Response: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['message']
              .toString()
              .contains("Phone number verified successfully")) {
        return true;
      } else {
        print("OTP verification failed: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("Error in verifyNewMobileOtp: $e");
      return false;
    }
  }


  Future<bool> sendNewEmailOtp(String phoneNumber, String email) async {
    // String url = "https://rental-api-5vfa.onrender.com/sendEmailOtp"; // API Endpoint
    String url = ApiConstants.baseUrl + ApiConstants.sendEmailOtp;

    var data = {
      'phoneNumber': phoneNumber,
      'email': email,
    };

    try {
      Response response = await _dio.post(url, data: data);

      print(" URL: $url");
      print("Sent Data: $data");
      print("Full API Response: ${response.data}");

      if (response.statusCode == 200 &&
          response.data['message'].contains("OTP sent successfully")) {
        NewAuthStorage.setPhoneNumber(phoneNumber);
        NewAuthStorage.setEmail(email);

        print("Phone Number Stored: $phoneNumber");
        print("Email Stored: $email");

        return true;
      } else {
        print("send Email OTP: ${response.data}");
        return false;
      }
    } catch (e) {
      if (e is DioException) {
        print(" DioException: ${e.response
            ?.data}");
      }
      print("Error EmailOtp: $e");
      return false;
    }
  }


  Future<bool> verifyNewEmailOtp(String email, String otp) async {
    String url = ApiConstants.baseUrl + ApiConstants.verifyEmailOtp;

    String? phoneNumber = NewAuthStorage.getPhoneNumber();
    if (phoneNumber == null) {
      print(" Error");
      return false;
    }

    var data = {
      'phoneNumber': phoneNumber,
      'email': email,
      'otp': otp,
    };

    try {
      Response response = await _dio.post(url, data: data);
      print("Email OTP Verify Response ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        String userId = response.data['user']['id'];
        String accessToken = response.data['user']['accessToken'];
        String refreshToken = response.data['user']['refreshToken'];

        // Store credentials in local storage
        await NewAuthStorage.setUserId(userId);
        await NewAuthStorage.setAccessToken(accessToken);
        await NewAuthStorage.setRefreshToken(refreshToken);

        print(" Email OTP Verified and Data Stored!");
        print(" Stored Access Token: ${await NewAuthStorage.getAccessToken()}");
        print(" Stored Access Token: ${await NewAuthStorage.getUserId()}");
        print(
            " Stored Refresh Token: ${await NewAuthStorage.getRefreshToken()}");

        return true;
      } else {
        print(" OTP verification failed: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("Error in verifyEmailOtp: $e");
      return false;
    }
  }


  Future<Map<String, dynamic>> fetchAndStoreUserDetails({
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String gender,
    required String permanentAddresss,
    required String password,
  }) async
  {
    String? userId = await NewAuthStorage.getUserId();
    if (userId == null || userId.isEmpty) {
      print(" Error: User ID is missing from storage.");
      return {"success": false, "message": "User ID not found"};
    }
    NewAuthStorage.getUserId();
    print("AuthStorage userId: ${NewAuthStorage.getUserId()}");

    //String url = ApiConstants.baseUrl + ApiConstants.verifyEmailOtp;


    String url = ApiConstants.baseUrl + ApiConstants.userRegisterrrr(userId);
    // String url = "https://rental-api-5vfa.onrender.com/update-details/$userId";
    print("api URL: $url");

    try {
      Response response = await _dio.post(
        url,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "gender": gender,
          "permanentAddress": permanentAddresss,
          "password": password,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer ${await NewAuthStorage.getAccessToken()}",
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status! < 500,
        ),);

      print("Fetch User API Response: ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        print(" User Details Updated Successfully!");
        return response.data;
      } else {
        print(" Failed to Update User Details. Response: ${response.data}");
        return {
          "success": false,
          "message": response.data['message'] ?? "Failed to update details"
        };
      }
    } catch (e) {
      print(" Error: $e");
      return {"success": false, "message": "Error: ${e.toString()}"};
    }
  }


  Future<Map<String, dynamic>?> newloginWithPhoneOrEmail(String identifier,
      String password) async
  {
    String baseUrl = "https://backend.anythingonrent.com/";
    String url;

    String? accessToken = NewAuthStorage.getAccessToken();
    print("Access Token: $accessToken");

    if (identifier.contains('@')) {
      url = "${baseUrl}login";
    } else {
      url = "${baseUrl}loginWithPhone";
    }

    var data = {
      identifier.contains('@') ? 'email' : 'phoneNumber': identifier,
      'password': password,
    };

    print(" API Call: $url");
    print("Request Data: $data");

    try {
      Response response = await NewDioClient.dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print(" api Response: ${response.data}");
      print(" Status Code: ${response.statusCode}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        print(" Login Successful: ${response.data['message']}");
        return response.data;
      } else {
        print(" Login Failed: ${response.data['message']}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");

      if (e is DioError) {
        if (e.response != null) {
          print(" Server Response: ${e.response?.data}");
        } else {
          print(" Request Error: ${e.message}");
        }
      }
      return null;
    }
  }


  Future<Map<String, dynamic>> getNewProfileData() async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().getEditProfile}";
    print("api Request: GET $url");

    String? accessToken = NewAuthStorage.getAccessToken();
    print(" Stored Access Token: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      print(" Access Token Missing!");
      return {"error": "Session expired, please log in again"};
    }

    try {
      Response response = await NewDioClient.dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
            "Accept": "application/json",
          },
        ),
      );

      print("api Response Received!");
      print(" Status Code: ${response.statusCode}");
      print(" Headers: ${response.headers}");
      print("Data: ${response.data}");

      if (response.statusCode == 200) {
        print(" Profile Data Fetched Successfully!");
        return response.data;
      } else {
        print("Unexpected Response Code: ${response.statusCode}");
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioException catch (e) {
      print(" Profile API Error Encountered!");
      print(" Status Code: ${e.response?.statusCode}");
      print(" Headers: ${e.response?.headers}");
      print("Error Data: ${e.response?.data}");
      print("Error Message: ${e.message}");

      return {"error": "Exception: ${e.message}"};
    }
  }


  Future<Map<String, dynamic>> getCurrentLocation() async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().getCurrentLocation}";
    print("API Request: GET $url");

    String? accessToken = NewAuthStorage.getAccessToken();
    print(" Stored Access Token: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      print(" Access Token Missing!");
      return {"error": "Session expired, please log in again"};
    }

    try {
      Response response = await NewDioClient.dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
            "Accept": "application/json",
          },
        ),
      );

      print(" API Response Received!");
      print(" Status Code: ${response.statusCode}");
      print(" Data: ${response.data}");

      if (response.statusCode == 200) {
        print("Location Data Fetched Successfully!");
        return response.data;
      } else {
        print(" Unexpected Response Code: ${response.statusCode}");
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioException catch (e) {
      print("Location API Error Encountered!");
      print(" Status Code: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}");
      print("Error Message: ${e.message}");

      return {"error": "Exception: ${e.message}"};
    }
  }


  Future<Map<String, dynamic>> getNewLogoutUser() async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().logout}";

    String? accessToken = await NewAuthStorage.getAccessToken();
    print("Stored Access Token Before Logout: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      print("No token found, forcing logout...");
      await NewAuthStorage.clearStorage();
      return {"error": "Session expired. Please log in again."};
    }

    try {
      Response response = await _dio.post(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(" Logout Successful: ${response.data}");
        return response.data;
      } else {
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioException catch (e) {
      print(" Logout API Error: ${e.response?.data}");

      if (e.response?.statusCode == 401) {
        print("Token Expired! Clearing Storage...");
        await NewAuthStorage.clearStorage();
      }

      return {"error": "Exception: ${e.message}"};
    }
  }


 /* Future<Map<String, dynamic>> NewGetAllCat() async {
    String url =
        ApiConstant().BaseUrl + ApiConstant().getAllCatagries;


    String? accessToken = NewAuthStorage.getAccessToken();
    print(" Stored Access Token: $accessToken");


    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
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
  }*/


  Future<Map<String, dynamic>> NewGetAllCat() async {
    String url = "https://rental-api-5vfa.onrender.com/categories";

    String? accessToken = NewAuthStorage.getAccessToken();
    print("🔑 Stored Access Token: $accessToken");

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      print("✅ getCatList Status Code --> ${response.statusCode}");
      print("📢 Response Data --> ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print("❌ Dio Error: ${e.response}");
      return e.response?.data ?? {};
    }
  }



  Future<Map<String, dynamic>> NewGetAllSubCat(String categoryId) async {
    if (!RegExp(r"^[0-9a-fA-F]{24}$").hasMatch(categoryId)) {
      print("📌 Category ID is a name, fetching ObjectId...");
      categoryId = await getCategoryIdByName(categoryId) ?? categoryId;
    }

    String url = "https://rental-api-5vfa.onrender.com/category/$categoryId/subcategories";
    print("🌐 API URL: $url");

    String? accessToken = NewAuthStorage.getAccessToken();
    print("🔑 Access Token: $accessToken");

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      print(" Response Status Code: ${response.statusCode}");
      print(" Raw Response Data: ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print(" Dio Error: ${e.response}");
      return e.response?.data ?? {};
    }
  }

  Future<String?> getCategoryIdByName(String categoryName) async {
    String url = "https://backend.anythingonrent.com/categories";

    try {
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List categories = response.data['data'];

        for (var category in categories) {
          if (category['name'] == categoryName) {
            return category['_id']; // सही ObjectId लौटाएगा
          }
        }
      }
    } catch (e) {
      print("❌ Error fetching category ID: $e");
    }
    return null;
  }





  //
  // Future<Map<String, dynamic>> NewGetSubCatDynamicFeilds(String categoryId) async {
  //   String baseeUrl = "https://backend.anythingonrent.com";
  //   String url = "$baseeUrl/category/${categoryId}/dynamicfields";
  //   print("API URL: $url");
  //
  //   String? accessToken = NewAuthStorage.getAccessToken();
  //   print(" Access Token: $accessToken");
  //
  //   try {
  //     Response response = await _dio.get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $accessToken',
  //           'Accept': 'application/json',
  //         },
  //       ),
  //     );
  //
  //     print("Response Status Code: ${response.statusCode}");
  //     print("Raw Response Data: ${response.data}");
  //
  //     if (response.statusCode == 200) {
  //       return response.data;
  //     } else {
  //       throw Exception("API Error: ${response.statusCode}");
  //     }
  //   } on DioException catch (e) {
  //     print("Dio Error: ${e.response?.data}");
  //     return {};
  //   } catch (e) {
  //     print("Unexpected Error: $e");
  //     return {};
  //   }
  // }


  Future<Map<String, dynamic>> NewGetSubCatDynamicFeilds(
      String categoryIdsss) async {
    String baseeUrl = "https://backend.anythingonrent.com";
    String url = "$baseeUrl/category/$categoryIdsss/dynamicfields";
    print("API URL: $url");
    print("Final API URL: $url");
    print("Category ID: $categoryIdsss");

    String? accessToken = NewAuthStorage.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      print("Error: Access token is null or empty.");
      return {};
    }

    print("Access Token: $accessToken");

    Dio _dio = Dio();

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Accept': 'application/json',
          },
        ),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Raw Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        print("API Error: ${response.statusCode} - ${response.statusMessage}");
        return {};
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Error Response Code: ${e.response?.statusCode}");
        print("Error Response Data: ${e.response?.data}");
      }
      return {};
    } catch (e) {
      print("Unexpected Error: $e");
      return {};
    }
  }


  String getBigSupportTicket(String userId, String ticketNumber) {
    return "/app-support/$userId/$ticketNumber";
  }

  Future<Map<String, dynamic>> getBigViewTicket(String? userId,
      String? ticketNumber) async {
    if (userId == null || userId.isEmpty || ticketNumber == null ||
        ticketNumber.isEmpty) {
      throw Exception(" userId or ticketNumber is missing!");
    }

    String baseUrl = "https://admin-fyu1.onrender.com/api/app";
    NewApiClients apiClient = NewApiClients();
    String endpoint = apiClient.getBigSupportTicket(userId, ticketNumber);
    String url = "$baseUrl$endpoint";

    print(" Fixed API Request URL: $url");

    String? sessionToken = await NewAuthStorage.getAccessToken();
    if (sessionToken == null || sessionToken.isEmpty) {
      throw Exception(" Session token missing");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $sessionToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("Response Status Code: ${response.statusCode}");
      print(" API Response: ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(" Failed to fetch data: ${response.statusCode}");
      }
    } on DioError catch (e) {
      print(" DioError Message: ${e.message}");
      throw Exception("Error fetching ticket: ${e.message}");
    }
  }


  // Future<Map<String, dynamic>> NewGetAllSubCat(String categoryId) async {
  //   String url = "https://rental-api-5vfa.onrender.com/category/$categoryId/subcategories";
  //   print("🚀 API URL: $url");
  //
  //   String? accessToken = NewAuthStorage.getAccessToken();
  //   print("🔑 Access Token: $accessToken");
  //
  //   try {
  //     Response response = await _dio.get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $accessToken',
  //         },
  //       ),
  //     );
  //
  //     print("✅ Response Status Code: ${response.statusCode}");
  //     print("📜 Raw Response Data: ${response.data}");
  //
  //     if (response.statusCode == 200) {
  //       if (response.data is String) {
  //         print("📌 Decoding String Response...");
  //         return jsonDecode(response.data);
  //       } else if (response.data is Map<String, dynamic>) {
  //         print("📌 Response is already a Map.");
  //         return response.data;
  //       } else {
  //         throw Exception("❌ Unexpected response format");
  //       }
  //     } else {
  //       print("⚠️ Server returned status code: ${response.statusCode}");
  //       throw Exception("Server error");
  //     }
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       print("🛑 Dio Error Response: ${e.response?.data}");
  //       return e.response?.data is Map<String, dynamic> ? e.response?.data : {'error': 'Unknown error'};
  //     } else {
  //       print("🛑 Dio Error: No response from server.");
  //       return {'error': 'No response from server'};
  //     }
  //   }
  // }


  Future<Map<String, dynamic>> NewPostfeedbackUser(String suggest,) async
  {
    String url = ApiConstant().AdminBaseUrl + ApiConstant().UserFeedback;

    String? accessToken = await NewAuthStorage.getAccessToken();

    // String? userId = GetStorage().read<String>(ConstantData.UserId);


    String? userId = await NewAuthStorage.getUserIdd();

    print(" UserId: $userId");

    var datas = jsonEncode({
      'user': userId,
      'suggest': suggest,
    });

    try {
      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: datas,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
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


  Future<Map<String, dynamic>> NewCreateTicket(String categoryId,
      String description) async
  {
    print("Creating Ticket...");

    String url = ApiConstant().AdminBaseUrl +
        ApiConstant().AdminContactUsMessage;
    String? sessionToken = await NewAuthStorage.getAccessToken();
    String? userId = await NewAuthStorage.getUserIdd();

    var datas = jsonEncode({
      'userId': userId,
      'category': categoryId,
      'description': description,
    });

    print("Sending Data: $datas");

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

      print(" Status Code: ${response.statusCode}");
      print(" API Response Data: ${response.data}");

      return response.data;
    } on DioError catch (e) {
      print(" API Error: ${e.response!.data}");
      return e.response!.data;
    }
  }


  Future<Map<String, dynamic>> getAllTicket() async {
    String? userId = await NewAuthStorage.getUserIdd();

    if (userId == null || userId.isEmpty) {
      throw Exception("⚠"
          " UserId is missing!");
    }

    print(" User ID: $userId");

    String url = "${ApiConstant().AdminBaseUrl}${ApiConstant()
        .getAllTicketsSupport(userId)}";
    print("📡"
        " API URL: $url");

    String? sessionToken = await NewAuthStorage.getAccessToken();
    if (sessionToken == null || sessionToken.isEmpty) {
      throw Exception(" Session token is missing or invalid.");
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $sessionToken'},
        ),
      );

      print(" Status Code: ${response.statusCode}");
      print(" Response Data: ${response.data}");

      if (response.headers.value('content-type')?.contains(
          'application/json') ?? false) {
        return response.data;
      } else {
        throw Exception(" Unexpected response format: ${response.data}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(" Dio Error Response: ${e.response?.data}");
        throw Exception(
            "Error fetching data: ${e.response?.statusCode ?? 'Unknown'} - ${e
                .response?.data}");
      } else {
        print(" Dio Error Message: ${e.message}");
        throw Exception("Dio Error: ${e.message}");
      }
    }
  }


/*
  Future<Map<String, dynamic>> NewCreateProductApi(
      String name,
      String description,
      String categoryName,
      int quantity,
      List<File> images,
      double rating,
      String productCurrentAddress,
      String price,
      ) async
  {
    String url =
        ApiConstant().BaseUrl + ApiConstant().createProduct;

    String? accessToken = NewAuthStorage.getAccessToken();
    print("Access Token: $accessToken");

    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'description': description,
        'categoryName': categoryName,
        'quantity': quantity,
        'productCurrentAddress': productCurrentAddress,
        'price': price,
        'rating': rating,
        'rent': {
          'perHour': 200,
          'perDay': 600,
          'perWeek': 500,
          'toSell': 500,
        },
        'type': 'Product',
        'images': images.map((file) {
          return MultipartFile.fromFileSync(
            file.path,
            filename: file.path.split('/').last,
          );
        }).toList(),
      });

      print("URL: $url");
      print("FormData: $formData");

      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      print("Responsesss: ${response.data}");

      if (response.data != null && response.statusCode == 200) {

        Map<String, dynamic> formattedResponse = {
          "success": true,
          "message": "Product created successfully!",
          "data": {
            "name": name,
            "description": description,
            "rent": [
              "per-hour",
              "200",
              "per-day",
              "600",
              "per-week",
              "500",
              "to-sell",
              "500"
            ],
            "sell": ["21"],
            "productionYear": [""],
            "specialtyofProductUses": "",
            "quantity": quantity,
            "images": images.map((file) {
              return {
                "url": "http://localhost:3910/uploads/${file.path.split('/').last}",
                "_id": "67d27c5090e53e64beee469e"
              };
            }).toList(),
            "dynamicFields": {
              "Pet Item Types": [200],
              "Do you provide any pet consultation?": ["yes"],
              "Pet Item's Delivery": ["No"]
            },
            "businessDetails": {
              "businessName": "pashan",
              "businessAddress": "sdfs",
              "businessPhone": "8542587898",
              "businessEmail": "jay@gmail.com",
              "website": "www.time.com",
              "gstNumber": "254697745",
              "whatsapp": "8542587898",
              "providerName": "sdfs",
              "BusinessStartedSince": "0896-01-01T00:00:00.000Z"
            },
            "createdBy": "67cc27716c7b961f9d84f99c",
            "_id": "67d27c5090e53e64beee469d",
            "createdAt": DateTime.now().toIso8601String(),
            "updatedAt": DateTime.now().toIso8601String(),
            "__v": 0
          }
        };
        return formattedResponse;
      } else {
        return {"error": "Unexpected response"};
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("DioError Response: ${e.response!.data}");
      } else {
        print("DioError Message: ${e.message}");
      }
      return e.response?.data ?? {'error': 'Unknown error'};
    } catch (e) {
      print("Error: $e");
      return {'error': e.toString()};
    }
  }
*/


  // Future<Map<String, dynamic>> NewCreateProductApi(String name) async {
  //   String url = ApiConstant().BaseUrl + ApiConstant().CreateProduct;
  //   String? userId = await NewAuthStorage.getUserId();
  //
  //
  //   if (userId == null || userId.isEmpty) {
  //     print("❌ Error: User ID is missing from storage.");
  //     return {"success": false, "message": "User ID not found"};
  //   }
  //
  //   String? accessToken = NewAuthStorage.getAccessToken();
  //   print("🟢 AuthStorage User ID: $userId");
  //   print("🟢 Access Token: $accessToken");
  //   print("Access Token: $accessToken");
  //
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'name': name,
  //       'userId': userId,
  //     });
  //
  //     Response response = await _dio.post<Map<String, dynamic>>(
  //       url,
  //       data: formData,
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $accessToken'},
  //       ),
  //     );
  //
  //     if (response.data != null && response.statusCode == 200) {
  //       return {
  //         "success": true,
  //         "message": "Product created successfully!",
  //         "data": {
  //           "name": name,
  //         }
  //       };
  //     } else {
  //       return {"success": false, "error": "Unexpected response"};
  //     }
  //   } on DioError catch (e) {
  //     print("DioError: ${e.response?.data}");
  //
  //     return {
  //       "success": false,
  //       "error": e.response?.data.toString() ?? "Dio error occurred",
  //     };
  //   } catch (e) {
  //     print("General Error: $e");
  //
  //     return {
  //       "success": false,
  //       "error": e.toString(),
  //     };
  //   }
  // }
  Future<Map<String, dynamic>> NewCreateProductApi(String name,String description,String BName,String BContact,String BEmail,
      String BWhatapps,String GSTINO,String bSpecialty,int quantity,String PYear,String categoryId,String SubCategoryId ) async {
    String url = ApiConstant().BaseUrl + ApiConstant().CreateProduct;
    String? userId = NewAuthStorage.getUserId();

    if (userId == null || userId.isEmpty) {

      return {"success": false, "message": "User ID not found"};
    }

    String? accessToken = NewAuthStorage.getAccessToken();


    if (accessToken == null || accessToken.isEmpty) {
      return {"success": false, "message": "Access token is missing"};
    }

    try {
      var requestData = {
        "name": name,
        "description": description,
        "businessName": BName,
        "businessPhone": BContact,
        "businessEmail": BEmail,
        "website": BWhatapps,
        "gstNumber": GSTINO,
        "specialtyofProductUses": bSpecialty,
        "quantity": quantity,
        "productionYear": PYear,
        "categoryId": categoryId,
        "subCategoryId": SubCategoryId,
        "userId": int.tryParse(userId) ?? userId,
      };

      print("Sending Request: $requestData");

      Response response = await _dio.post(
        url,
        data: jsonEncode(requestData),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("API Response: ${response.data}");

      if (response.data != null && response.statusCode == 200) {
        return {
          "success": true,
          "message": response.data['message'] ?? "Product created successfully!",
          "data": response.data['data'],
        };
      } else {
        return {"success": false, "error": "Unexpected response from server"};
      }
    } on DioError catch (e) {


      return {
        "success": false,
        "error": e.response?.data?['message'] ?? "Unknown error occurred",
      };
    }}

}
