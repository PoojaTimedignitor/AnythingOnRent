/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../Admin/vedio_player.dart';

class ImageOrVideoWidget extends StatelessWidget {
  final String imgUrl;

  const ImageOrVideoWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVideo = imgUrl.toLowerCase().endsWith('.mp4');

    return Container(
      height: 50,
      width: 100,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF8D6E63),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: isVideo
                ? VideoPlayerWidget(url: imgUrl)
                : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/


///

/*
import 'package:flutter/material.dart';
import '../Admin/vedio_player.dart'; // Make sure this path is correct

class ImageOrVideoWidget extends StatelessWidget {
  final String imgUrl;

  const ImageOrVideoWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVideo = imgUrl.toLowerCase().endsWith('.mp4');

    return Container(
      height: 50,
      width: 100,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF8D6E63),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: isVideo
                ? VideoPlayerWidget(url: imgUrl)
                : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/

import 'dart:ui';
import 'package:flutter/material.dart';
import '../Admin/vedio_player.dart'; // Make sure this path is correct

class ImageOrVideoWidget extends StatelessWidget {
  final String imgUrl;

  const ImageOrVideoWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVideo = imgUrl.toLowerCase().endsWith('.mp4');

    return Container(
      height: 50,
      width: 100,
      margin: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF8D6E63),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: isVideo
                ? VideoPlayerWidget(url: imgUrl)
                : Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.3), // white glass effect
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
