import 'dart:io';
import 'package:dio/dio.dart';

class ApiClients {
  final Dio _dio = Dio();

  // Function to upload the front image
  Future<Map<String, dynamic>> uploadFrontImage(File frontImage) async {
    String url = 'https://rental-api-5vfa.onrender.com/user/api/users/register'; // Replace with your API endpoint

    try {
      // Prepare form data
      FormData formData = FormData.fromMap({
        'frontImage': await MultipartFile.fromFile(frontImage.path,
            filename: frontImage.path.split('/').last),
      });

      // API call
      Response response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer your-token', // Add token if needed
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      print('Error: ${e.response?.data}');
      return e.response?.data ?? {'error': 'Unknown error occurred'};
    }
  }
}
