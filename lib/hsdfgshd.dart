import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

class ImagePickerCarousel extends StatefulWidget {
  @override
  _ImagePickerCarouselState createState() => _ImagePickerCarouselState();
}

class _ImagePickerCarouselState extends State<ImagePickerCarousel> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = []; // To store selected images

  // Method to pick images from the gallery
  Future<void> _pickImagesFromGallery() async {
    if (_selectedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only add up to 5 images.')),
      );
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        // Add selected images to the list, limit to 5
        _selectedImages.addAll(
          pickedFiles.map((file) => File(file.path)).take(5 - _selectedImages.length),
        );
      });
    }
  }

  // Method to clear selected images
  void _clearImages() {
    setState(() {
      _selectedImages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery Picker & Carousel'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearImages,
          ),
        ],
      ),
      body: Column(
        children: [
          // Button to open gallery
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.photo_library),
              label: Text('Select Images from Gallery'),
              onPressed: _pickImagesFromGallery,
            ),
          ),

          // Carousel Slider to display selected images
          if (_selectedImages.isNotEmpty)
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
                items: _selectedImages.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            image,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

          // Message when no images are selected
          if (_selectedImages.isEmpty)
            Center(
              child: Text(
                'No images selected',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
