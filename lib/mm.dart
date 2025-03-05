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




import 'package:flutter/material.dart';

// The entry point for the Flutter app
void main() {
  // Run the app by passing the MyApp widget to runApp
  runApp(ddt());
}

// MyApp is a stateless widget that returns MaterialApp
class ddt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: MyHomePage(),
    );
  }
}

// MyHomePage is a StatefulWidget
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );


    _animation = Tween(begin: 0.0, end: 200.0).animate(_controller);


    _controller.addListener(() {
      setState(() {});
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Examples'),
      ),

      body: Center(

        child: Container(

          width: _animation.value,
          height: _animation.value,
          color: Colors.blue,
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';

void main() {
  runApp(ScaleAnimationApp());
}

class ScaleAnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scale Animation Demo',
      home: ScaleAnimation(),
    );
  }
}

class ScaleAnimation extends StatefulWidget {
  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Create AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800), // Animation duration
    );

    // 2. Define scale range using Tween
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller)
      ..addStatusListener((status) {
        // Repeat the animation back and forth
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    // 3. Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Always dispose controller to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Just a blank screen with a centered animated FlutterLogo
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          // The child widget to be scaled
          child: FlutterLogo(size: 200),
        ),
      ),
    );
  }
}
*/
