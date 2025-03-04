/*
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomNetworkImage extends StatefulWidget {
  final String imageUrl;
  const CustomNetworkImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _CustomNetworkImageState createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  Future<void> fetchImage() async {
    try {
      final response = await http.get(
        Uri.parse(widget.imageUrl),
        headers: {
          // Agar headers ki zarurat ho toh yahan set kar sakte hain.
          // 'Authorization': 'Bearer your_token',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          imageBytes = response.bodyBytes;
        });
      } else {
        print("HTTP request failed, statusCode: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageBytes != null
        ? Image.memory(imageBytes!, fit: BoxFit.cover)
        : Container(
      color: Colors.grey,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
*/


/*
Future<Map<String, dynamic>> getAllCat(File? imageFile) async {
  String url = ApiConstant().BaseUrl + ApiConstant().getAllCatagries;

  String? sessionToken =
  GetStorage().read<String>(ConstantData.UserAccessToken);

  try {
    FormData formData = FormData.fromMap({

      if (imageFile != null)
        'bannerImage': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    Response response = await _dio.post(
      url,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $sessionToken',
          'Content-Type': 'multipart/form-data',
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
*/
