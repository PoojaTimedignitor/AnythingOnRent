import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../ApiConstant/api_constant.dart';
import '../ConstantData/Constant_data.dart';

class ApiClients {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> registerDio(String firstName,
      String lastName,
      String phoneNumber,
      String email,
      String password,
      String cpassword,
      File? profilePicture,
      File? frontImages,
      File? backImages,
      String permanentAddress,
      String latitude,
      String longitude,) async
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
        'latitude': latitude,
        'longitude': longitude,
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

  Future<Map<String, dynamic>> loginDio(String email,
      String password,) async
  {
    String url = ApiConstant().BaseUrlLogin + ApiConstant().login;

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
      // print("data....>$dataa");
      print("statusCode --> ${response.statusCode}");
      print("dateeeee --> ${response.data}");
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<Map<String, dynamic>> getAllCat() async {
    String url =
        ApiConstant().BaseUrlgetAllCatagries + ApiConstant().getAllCatagries;

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
    String url = ApiConstant().BaseUrlCreateProdcut + ApiConstant().createProduct;

    String? sessionToken = GetStorage().read<String>(ConstantData.UserAccessToken);
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
        // Rent data can be adjusted as needed
        'rent': {
          'perHour': 0,
          'perDay': 0,
          'perWeek': 0,
          'perMonth': 0,
        },
        'type': 'Product',
        // Mapping images to MultipartFile for file upload
        'images': images.map((file) {
          return MultipartFile.fromFileSync(
            file.path,
            filename: file.path.split('/').last, // Extract filename
          );
        }).toList(),
      });

      // Debug: Print the URL and the form data
      print("URL: $url");
      print("FormData: $formData");

      // Make the POST request with the FormData
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

}