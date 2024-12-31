import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import '../ConstantData/Constant_data.dart';

class ApiClients {
  final Dio _dio = Dio();

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

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);
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

      // Debug: Print the URL and the form data
      print("URL: $url");
      print("FormData: $formData");

      // Make the POST request
      Response response = await _dio.post<Map<String, dynamic>>(
        url,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Bearer $sessionToken'},
        ),
      );

      // Debug: Print the response data
      print("Response: ${response.data}");
      return response.data!;
    } on DioError catch (e) {
      if (e.response != null) {
      } else {
        print("Dio Error Message: ${e.message}");
      }

      // Handle error gracefully
      return e.response?.data ?? {'error': 'Server error occurred'};
    }
    catch (e) {
      // Catch any other errors
      print("Error: $e");
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> loginDio(
    String email,
    String password,
  ) async {
    String url = ApiConstant().BaseUrl + ApiConstant().login;

    String? sessionToken =
        GetStorage().read<String>(ConstantData.UserAccessToken);


   /* if (sessionToken == null) {
      print("Error: Session Token is null!");
      return {"success": false, "message": "User is not logged in."};
    }*/

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


  Future<Map<String, dynamic>> getAllSubCat(String categoryId) async {
    String url = "${ApiConstant().BaseUrlGetAllCat}${ApiConstant().getAllSubCatagries(categoryId)}";
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

      // Debug: Print the response data
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

  Future<Map<String, dynamic>> getLogoutUser(String email, String password) async {
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



