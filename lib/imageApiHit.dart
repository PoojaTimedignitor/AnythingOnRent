import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'apiImage.dart';

class SaveButtonExample extends StatefulWidget {
  @override
  _SaveButtonExampleState createState() => _SaveButtonExampleState();
}

class _SaveButtonExampleState extends State<SaveButtonExample> {
  File? _frontImage;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery); // Gallery or Camera

    if (pickedFile != null) {
      setState(() {
        _frontImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveImage() async {
    print("image   ${_frontImage}");
    if (_frontImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image before saving')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // Call API to upload the front image
    ApiClients apiClient = ApiClients();
    final response = await apiClient.uploadFrontImage(_frontImage!);

    if (response.containsKey('success') && response['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response['error']}')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:  Column(
          children: [
            GestureDetector(
              onTap: _pickImage, // Pick image from gallery
              child: _frontImage == null
                  ? Container(
                height: 150,
                width: 150,
                color: Colors.grey[300],
                child: Icon(Icons.add_a_photo, size: 50),
              )
                  : Image.file(_frontImage!, height: 150, width: 150, fit: BoxFit.cover),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _saveImage, // Save button action
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffFEBA69), Color(0xffFE7F64)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      );


  }
}
