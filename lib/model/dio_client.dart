import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import '../ConstantData/AuthStorage.dart';
import '../ConstantData/Constant_data.dart';
import '../GetStoragesss.dart';



class DioClient {
  static final Dio _dio = Dio();

  static Dio get dio {
    _dio.interceptors.clear();

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? accessToken = GetStorage().read<String>('accessToken');

          if (accessToken == null || accessToken.isEmpty) {
            print("❌ Access Token Missing! Logging out...");
            AuthStorage.clearTokens();
            return handler.reject(DioException(
              requestOptions: options,
              response: Response(
                requestOptions: options,
                statusCode: 401,
                data: {"error": "Session expired, please log in again"},
              ),
            ));
          }

          options.headers["Authorization"] = "Bearer $accessToken";
          return handler.next(options);
        },

        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            print("🔄 Token Expired! Trying to Refresh...");

            bool tokenRefreshed = await _handleTokenRefresh();
            if (tokenRefreshed) {
              print("✅ Token Refreshed! Retrying Request...");
              String? newAccessToken = GetStorage().read<String>('accessToken');
              e.requestOptions.headers["Authorization"] = "Bearer $newAccessToken";

              // 🔄 Retry the request with new token
              final retryResponse = await _dio.fetch(e.requestOptions);
              return handler.resolve(retryResponse);
            } else {
              print("❌ Refresh Token Expired! Logging Out...");
              AuthStorage.clearTokens();
              return handler.reject(e);
            }
          }
          return handler.next(e);
        },
      ),
    );

    return _dio;
  }



  static Future<Map<String, dynamic>> refreshAccessToken() async {
    String? refreshToken = AuthStoragesss.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      print("❌ No refresh token found! Logging out...");
      AuthStoragesss.clearTokens();
      return {"success": false, "message": "No refresh token found!"};
    }

    String url = "https://rental-api-5vfa.onrender.com/refresh-token";

    try {
      Response response = await DioClient.dio.post(url, data: {
        "refreshToken": refreshToken,
      });

      if (response.statusCode == 200 && response.data['accessToken'] != null) {
        String newAccessToken = response.data['accessToken'];
        String newRefreshToken = response.data['refreshToken'] ?? refreshToken;

        // ✅ Save new tokens
        await AuthStoragesss.saveTokens(newAccessToken, newRefreshToken);
        print("✅ Access & Refresh Tokens Updated!");

        return {
          "success": true,
          "message": "Access Token Updated!",
          "accessToken": newAccessToken,
          "refreshToken": newRefreshToken
        };
      } else {
        print("⚠️ Failed to refresh token! Status: ${response.statusCode}");
        AuthStoragesss.clearTokens();
        return {"success": false, "message": "Failed to refresh token!"};
      }
    } on DioException catch (e) {
      print("❌ Refresh Token API Error: ${e.response?.data}");
      AuthStoragesss.clearTokens();
      return {
        "success": false,
        "message": "Error refreshing access token: ${e.message}"
      };
    }
  }

  static Future<bool> _handleTokenRefresh() async {
    Map<String, dynamic> refreshResponse = await refreshAccessToken();

    if (refreshResponse["success"] == true) {
      print("✅ Access Token Refreshed Successfully!");
      return true;
    } else {
      print("❌ Refresh Token Expired! Logging Out User...");
      AuthStoragesss.clearTokens();
      return false;
    }
  }
}


class ApiClients {
  static final ApiClients _instance = ApiClients
      ._internal(); // Singleton instance

  final Dio _dio = Dio();
  final box = GetStorage();

  factory ApiClients() {
    return _instance;
  }

  ApiClients._internal() {
    // Yahan Dio ya aur config set karo
    _dio.options.baseUrl = "https://example.com"; // Example
    print("ApiClients initialized");
  }


/*
  static  Future<bool> _handleTokenRefresh() async {
    Map<String, dynamic> refreshResponse = await refreshAccessToken();

    if (refreshResponse["success"] == true) {
      print("✅ Access Token Refreshed Successfully!");
      return true;
    } else {
      print("❌ Refresh Token Expired! Logging Out User...");
      AuthStorage.clearTokens(); // 🚀 User Logout (Optional)
      return false;
    }
  }
*/



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




  Future<bool> sendMobileOtp(String phoneNumber) async {
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




  Future<bool> storeUserCity(String userId, double latitude, double longitude, String city) async {
    String url = ApiConstant().BaseUrl + ApiConstant().storeLocation;




    String? sessionToken = GetStorage().read<String>('token'); // Token पढ़ना
    String? userId = GetStorage().read<String>('userId');

    var data = {
      'userId': userId, // Backend ko user identify karne ke liye
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
    };

    print("📡 seeeeeeeeeeeeeeee: $sessionToken");
    print("📨 Request Data: $data");

    try {

      Response response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
         'Authorization': 'Bearer $sessionToken',
            'Content-Type': 'application/json',
          },
        ),
      );


    /*  Response response = await _dio.post(url, data: data);*/

      if (response.statusCode == 200) {
        print("✅ Location updated: ${response.data}");


        GetStorage().write('selectedCity', city);
        print("🗄️ City stored locally: $city");

        return true;
      } else {
        print("❌ Error: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Exception: $e");
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

   // String? AccessToken = GetStorage().read<String>('accessToken');

    String? sessionToken = AuthStorage.getAccessToken();


   // String? userId = AuthStorage.getUserId();

    var data = {
      'phoneNumber': phoneNumber,
      'email': email,
    };

    print("📡 Sending OTP to API: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data, options: Options(
        headers: {
          'Authorization': 'Bearer $sessionToken',
          'Content-Type': 'application/json',
        },
      ),);

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









/*
  Future<bool> verifyEmailOtp(String email, String phoneNumber, String otp) async {
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

          String userId = response.data['user']['id'];
          print("qqqqqqqq $userId");
         // print("rrrrrrrrrr ${AuthStorage.saveUserData}");
          AuthStorage.saveUserData(userId: userId);



          print("✅ User ID stored successfully: $userId");
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
*/

/*  Future<bool> verifyEmailOtp(String email, String phoneNumber, String otp) async {
    String url = ApiConstant().BaseUrl + ApiConstant().emailOtp;
    String? accessToken = AuthStorage.getAccessToken();

    var data = {
      'email': email,
      'phoneNumber': phoneNumber,
      'otp': otp,
    };

    print("🔍 Verifying OTP at: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await DioClient.dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print("📩 API Response: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String accessToken = response.data['accessToken'];
        String refreshToken = response.data['refreshToken'];

        await AuthStorage.saveTokens(accessToken, refreshToken);
        print("✅ OTP Verified & Tokens Stored!");

        String apiMessage = response.data['message'];
        print("✅ API Message: $apiMessage");

        if (apiMessage.contains("verified successfully")) {
          String userId = response.data['user']['id'];
          print("✅ User ID from API: $userId");

          AuthStorage.saveUserData(userId: userId);
          print("✅ User ID stored successfully: $userId");

          return true;
        } else {
          print("❌ API Error Message: $apiMessage");
          return false;
        }
      } else if (response.statusCode == 401) {
        print("🔄 Token Expired! Refreshing...");

        bool tokenRefreshed = await DioClient._handleTokenRefresh();

        if (tokenRefreshed) {
          print("✅ Token Refreshed! Retrying OTP verification...");
          accessToken = AuthStorage.getAccessToken(); // Get new token

          Response retryResponse = await DioClient.dio.post(
            url,
            data: data,
            options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          );

          if (retryResponse.statusCode == 200) {
            String apiMessage = retryResponse.data['message'];
            print("✅ API Message (After Refresh): $apiMessage");

            if (apiMessage.contains("verified successfully")) {
              String userId = retryResponse.data['user']['id'];
              print("✅ User ID from API (After Refresh): $userId");

              AuthStorage.saveUserData(userId: userId);
              print("✅ User ID stored successfully (After Refresh): $userId");

              return true;
            } else {
              print("❌ API Error Message (After Refresh): $apiMessage");
              return false;
            }
          } else {
            print("❌ OTP Verification Failed (After Refresh)");
            return false;
          }
        } else {
          print("❌ Session Expired. Please log in again.");
          return false;
        }
      } else {
        print("❌ HTTP Error Code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("🔥 Exception: $e");

      if (e is DioException) {
        if (e.response != null) {
          print("❌ Server Response: ${e.response?.data}");
        } else {
          print("❌ Request Error: ${e.message}");
        }
      }

      return false; // **Added to prevent returning null**
    }

    // **Ensure function always returns a value**
    return false;
  }*/

  Future<Map<String, dynamic>> verifyEmailOtp(String userId, String otp) async {
    String url = "https://rental-api-5vfa.onrender.com/verify-otp";

    try {
      print("📩 Sending OTP Verification Request...");

      Response response = await DioClient.dio.post(url, data: {
        "userId": userId,
        "otp": otp,
      });

      print("✅ Response from API: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        String? accessToken = response.data['accessToken'];
        String? refreshToken = response.data['refreshToken'];

        if (accessToken == null || refreshToken == null) {
          print("❌ API Response Missing Tokens!");
          return {"success": false, "message": "Invalid API Response! Tokens not received."};
        }

        // ✅ Save tokens in GetStorage
        final box = GetStorage();
        await box.write('accessToken', accessToken);
        await box.write('refreshToken', refreshToken);

        print("✅ OTP Verified & Tokens Stored in GetStorage!");
        print("📌 Saved Access Token: $accessToken");
        print("📌 Saved Refresh Token: $refreshToken");

        return {
          "success": true,
          "accessToken": accessToken,
          "refreshToken": refreshToken,
          "message": "OTP verified successfully!"
        };
      } else {
        print("❌ OTP Verification Failed! ${response.data}");
        return {"success": false, "message": "OTP verification failed!"};
      }
    } on DioException catch (e) {
      print("❌ OTP Verification Error: ${e.response?.data}");
      return {"success": false, "message": "Error verifying OTP: ${e.message}"};
    }
  }


  // Future<bool> verifyEmailOtp(String email, String phoneNumber, String otp) async {
  //   String url = ApiConstant().BaseUrl + ApiConstant().emailOtp;
  //   String? accessToken = AuthStorage.getAccessToken();
  //
  //   var data = {
  //     'email': email,
  //     'phoneNumber': phoneNumber,
  //     'otp': otp,
  //   };
  //
  //   print("🔍 Verifying OTP at: $url");
  //   print("📨 Request Data: $data");
  //
  //   try {
  //     Response response = await DioClient.dio.post(
  //       url,
  //       data: data,
  //       options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
  //     );
  //
  //     print("📩 API Response: ${response.data}");
  //     print("📡 Status Code: ${response.statusCode}");
  //
  //     if (response.statusCode == 200) {
  //       String apiMessage = response.data['message'];
  //       print("✅ API Message: $apiMessage");
  //
  //       if (apiMessage.contains("verified successfully")) {
  //         String userId = response.data['user']['id'];
  //         print("✅ User ID from API: $userId");
  //
  //         AuthStorage.saveUserData(userId: userId);
  //         print("✅ User ID stored successfully: $userId");
  //
  //         return true;
  //       } else {
  //         print("❌ API Error Message: $apiMessage");
  //         return false;
  //       }
  //     } else if (response.statusCode == 401) {
  //       print("🔄 Token Expired! Refreshing...");
  //
  //       bool tokenRefreshed = await DioClient._handleTokenRefresh();
  //
  //       if (tokenRefreshed) {
  //         print("✅ Token Refreshed! Retrying OTP verification...");
  //         accessToken = AuthStorage.getAccessToken(); // नया token लो
  //
  //         Response retryResponse = await DioClient.dio.post(
  //           url,
  //           data: data,
  //           options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
  //         );
  //
  //         if (retryResponse.statusCode == 200) {
  //           String apiMessage = retryResponse.data['message'];
  //           print("✅ API Message (After Refresh): $apiMessage");
  //
  //           if (apiMessage.contains("verified successfully")) {
  //             String userId = retryResponse.data['user']['id'];
  //             print("✅ User ID from API (After Refresh): $userId");
  //
  //             AuthStorage.saveUserData(userId: userId);
  //             print("✅ User ID stored successfully (After Refresh): $userId");
  //
  //             return true;
  //           } else {
  //             print("❌ API Error Message (After Refresh): $apiMessage");
  //             return false;
  //           }
  //         } else {
  //           print("❌ OTP Verification Failed (After Refresh)");
  //           return false;
  //         }
  //       } else {
  //         print("❌ Session Expired. Please log in again.");
  //         return false;
  //       }
  //     } else {
  //       print("❌ HTTP Error Code: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     print("🔥 Exception: $e");
  //
  //     if (e is DioError) {
  //       if (e.response != null) {
  //         print("❌ Server Response: ${e.response?.data}");
  //       } else {
  //         print("❌ Request Error: ${e.message}");
  //       }
  //     }
  //     return false;
  //   }
  // }

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











 /* Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String permanentAddress,
    required String password,
    required String gender,
  }) async
  {
    String? sessionToken = AuthStorage.getAccessToken();


    String? userId = AuthStorage.getUserId();

    if (userId == null || userId.isEmpty) {
      print("ccccccc");
      return {'success': false, 'message': 'User ID is missing'};
    }

    AuthStorage.saveUserData(userId: userId);
    print("✅ AuthStorage से मिली userId: ${AuthStorage.getUserId()}");

    String url = ApiConstant().BaseUrl + ApiConstant().userRegister(userId);

    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "permanentAddress": permanentAddress,
      "password": password,
      "gender": gender,
    };

    try {
      Response response = await _dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $sessionToken'}),
      );

      print("📩 API Response: $response");

      if (response.statusCode == 200 && response.data.containsKey('user')) {
        var user = response.data['user'];

        if (user.containsKey('id')) {
          String newUserId = user['id'].toString();
          AuthStorage.saveUserData(userId: newUserId);
          print("✅ API से नई userId स्टोर की गई: $newUserId");
        }

        return {'success': true, 'user': user, 'message': 'User registered successfully'};
      } else {
        return {'success': false, 'message': 'User registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Something went wrong. Please try again.'};
    }
  }*/





  Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String permanentAddress,
    required String password,
    required String gender,
  }) async {
    String? sessionToken = AuthStorage.getAccessToken();
    String? userId = AuthStorage.getUserId();

    if (userId == null || userId.isEmpty) {
      print("ccccccc");
      return {'success': false, 'message': 'User ID is missing'};
    }

    AuthStorage.saveUserData(userId: userId);
    print("✅ AuthStorage से मिली userId: ${AuthStorage.getUserId()}");

    String url = ApiConstant().BaseUrl + ApiConstant().userRegister(userId);

    var data = {
      "firstName": firstName,
      "lastName": lastName,
      "permanentAddress": permanentAddress,
      "password": password,
      "gender": gender,
    };

    try {
      Response response = await DioClient.dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $sessionToken'}),
      );

      print("📩 API Response: $response");

      if (response.statusCode == 200 && response.data.containsKey('user')) {
        var user = response.data['user'];

        if (user.containsKey('id')) {
          String newUserId = user['id'].toString();
          AuthStorage.saveUserData(userId: newUserId);
          print("✅ API से नई userId स्टोर की गई: $newUserId");
        }

        return {'success': true, 'user': user, 'message': 'User registered successfully'};
      } else if (response.statusCode == 401) {
        print("🔄 Token Expired! Refreshing...");

        bool tokenRefreshed = await DioClient._handleTokenRefresh();

        if (tokenRefreshed) {
          print("✅ Token Refreshed! Retrying request...");
          sessionToken = AuthStorage.getAccessToken(); // नया token लो

          Response retryResponse = await DioClient.dio.post(
            url,
            data: data,
            options: Options(headers: {'Authorization': 'Bearer $sessionToken'}),
          );

          if (retryResponse.statusCode == 200 && retryResponse.data.containsKey('user')) {
            var user = retryResponse.data['user'];

            if (user.containsKey('id')) {
              String newUserId = user['id'].toString();
              AuthStorage.saveUserData(userId: newUserId);
              print("✅ API से नई userId स्टोर की गई: $newUserId");
            }

            return {'success': true, 'user': user, 'message': 'User registered successfully'};
          } else {
            return {'success': false, 'message': 'User registration failed after token refresh'};
          }
        } else {
          return {'success': false, 'message': 'Session expired. Please log in again.'};
        }
      } else {
        return {'success': false, 'message': 'User registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Something went wrong. Please try again.'};
    }
  }





/*  Future<Map<String, dynamic>> getProfileData() async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().getEditProfile}"; // 🖥 API URL
    String? accessToken = AuthStorage.getAccessToken();

    print("📌 Stored Access Token: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      return {"error": "Session token is missing. Please log in again."};
    }

    try {
      Response response = await _dio.get(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        print("✅ Profile Data Fetched: ${response.data}");
        return response.data;
      } else {
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        print("🔄 Token Expired! Refreshing Access Token...");
        bool tokenRefreshed = await _handleTokenRefresh();

        if (tokenRefreshed) {
          return await getProfileData(); // 🔄 Retry API Call with New Token
        } else {
          return {"error": "Session expired. Please log in again."};
        }
      }

      print("❌ Profile API Error: ${e.response?.data}");
      return {"error": "Exception: ${e.message}"};
    }
  }*/

  Future<Map<String, dynamic>> getProfileData() async {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().getEditProfile}";
    print("🌍 API Request: GET $url");

    String? accessToken = AuthStorage.getAccessToken();
    print("📌 Stored Access Token: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      print("❌ Access Token Missing!");
      return {"error": "Session expired, please log in again"};
    }

    try {
      Response response = await DioClient.dio.get(url);

      print("🔄 API Response Received!");
      print("📌 Status Code: ${response.statusCode}");
      print("📌 Headers: ${response.headers}");
      print("📌 Data: ${response.data}");

      if (response.statusCode == 200) {
        print("✅ Profile Data Fetched Successfully!");
        return response.data;
      } else {
        print("⚠️ Unexpected Response Code: ${response.statusCode}");
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioException catch (e) {
      print("❌ Profile API Error Encountered!");
      print("📌 Status Code: ${e.response?.statusCode}");
      print("📌 Headers: ${e.response?.headers}");
      print("📌 Error Data: ${e.response?.data}");
      print("📌 Error Message: ${e.message}");

      // Token Expiry Case
      if (e.response?.statusCode == 401) {
        print("🔄 Token Expired! Refreshing...");
        bool tokenRefreshed = await DioClient._handleTokenRefresh();

        if (tokenRefreshed) {
          print("✅ Token Refreshed! Retrying Request...");
          return await getProfileData(); // Retry with new token
        } else {
          print("❌ Refresh Token Failed! Logging Out...");
          return {"error": "Session expired, please log in again"};
        }
      }

      return {"error": "Exception: ${e.message}"};
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




  Future<Map<String, dynamic>?> loginWithPhoneOrEmail(String identifier, String password) async {
    String baseUrl = "https://rental-api-5vfa.onrender.com/";
    String url;

    String? accessToken = AuthStorage.getAccessToken();
    print("🔑 Access Token: $accessToken");

    if (identifier.contains('@')) {
      url = "${baseUrl}login";
    } else {
      url = "${baseUrl}loginWithPhone";
    }

    var data = {
      identifier.contains('@') ? 'email' : 'phoneNumber': identifier,
      'password': password,
    };

    print("📡 API Call: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await DioClient.dio.post(
        url,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      print("📩 API Response: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        print("✅ Login Successful: ${response.data['message']}");
        return response.data;
      } else if (response.statusCode == 401) {
        print("🔄 Token Expired! Refreshing...");

        bool tokenRefreshed = await DioClient._handleTokenRefresh();

        if (tokenRefreshed) {
          print("✅ Token Refreshed! Retrying login...");
          accessToken = AuthStorage.getAccessToken(); // नया token लो

          Response retryResponse = await DioClient.dio.post(
            url,
            data: data,
            options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          );

          if (retryResponse.statusCode == 200 && retryResponse.data['success'] == true) {
            print("✅ Login Successful (After Refresh): ${retryResponse.data['message']}");
            return retryResponse.data;
          } else {
            print("❌ Login Failed (After Refresh): ${retryResponse.data['message']}");
            return null;
          }
        } else {
          print("❌ Session Expired. Please log in again.");
          return null;
        }
      } else {
        print("❌ Login Failed: ${response.data['message']}");
        return null;
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
      return null;
    }
  }


/*
  Future<Map<String, dynamic>?> loginWithPhoneOrEmail(String identifier, String password) async {
    String baseUrl = "https://rental-api-5vfa.onrender.com/";
    String url;

    String? accessToken = AuthStorage.getAccessToken();
    print("lklklklklkk $accessToken");

    if (identifier.contains('@')) {
      url = "${baseUrl}login";
    } else {
      url = "${baseUrl}loginWithPhone";
    }

    var data = {
      identifier.contains('@') ? 'email' : 'phoneNumber': identifier,
      'password': password,
    };

    print("📡 API Call: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data,options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),);

      print("📩 API Response: ${response.data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        print("✅ Login Successful: ${response.data['message']}");
        return response.data; // ✅ पूरा JSON डेटा रिटर्न करें
      } else {
        print("❌ Login Failed: ${response.data['message']}");
        return null;
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
      return null;
    }
  }
*/



  Future<Map<String, dynamic>> getLogoutUser() async
  {
    String url = "${ApiConstant().BaseUrl}${ApiConstant().logout}";

    //String? sessionToken = GetStorage().read<String>('token');
    String? accessToken = AuthStorage.getAccessToken();
    print("📌 Stored Access Token: $accessToken");

    if (accessToken == null || accessToken.isEmpty) {
      return {"error": "Session token is missing. Please log in again."};
    }

    print("vvvvvvv $url");
    print("xxxxxx: $accessToken");

    try {
      Response response = await _dio.post(
        url,

        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("✅ Logout Successful: ${response.data}");
        return response.data;
      } else {
        return {"error": "Unexpected response code: ${response.statusCode}"};
      }
    } on DioError catch (e) {
      print("❌ Logout API Error: ${e.response?.data}");
      return {"error": "Exception: ${e.message}"};
    }
  }



  Future<bool> userLocationStore(String phoneNumber) async {
    String url = ApiConstant().BaseUrl + ApiConstant().storeLocation;

    var data = {
      'phoneNumber': phoneNumber,
    };

    print("📡 API को OTP भेजा जा रहा है: $url");
    print("📨 Request Data: $data");

    try {
      Response response = await _dio.post(url, data: data);

      print("📩 API Response: ${response
          .data}");
      print("📡 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        String apiMessage = response
            .data['message'];
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
      String userId, String ticketNumber) async
  {
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

  Future<Map<String, dynamic>> getAllTicket(String userIds) async
  {
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

        return response.data
            as Map<String, dynamic>;
      } else {
        print("Error fetching business ads: ${response.statusCode}");
        return {};
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
