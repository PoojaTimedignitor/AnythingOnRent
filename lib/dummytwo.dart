import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';



class SnakeBorderAnimationApp extends StatelessWidget {

     SnakeBorderAnimationApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedSnakeBorder(text: 'hello',),
        ),
      ),
    );
  }
}

class AnimatedSnakeBorder extends StatefulWidget {
  final String text;
  const AnimatedSnakeBorder({Key? key, required this.text}) : super(key: key);

  @override
  _AnimatedSnakeBorderState createState() => _AnimatedSnakeBorderState();
}

class _AnimatedSnakeBorderState extends State<AnimatedSnakeBorder>
    with TickerProviderStateMixin   {
  late Animation<double> _animation;
  late AnimationController _controller;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isVisible = true; // Tracks visibility of the border

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward(); // Start the animation

    // Define scaling animation from 0 to 1
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // Animation Controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds:3),
      upperBound: 2.0, // Loop exactly 2 times
    );

    _controller.forward().whenComplete(() {
      // Hide animation after 2 loops
      setState(() {
        _isVisible = false;
      });
    });
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds:3),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 0.5),
        borderRadius:  BorderRadius.all(Radius.circular(20)),
      ),
      child:Stack(
        alignment: Alignment.center, // Align content in the center
        children: [
          // Border Animation
          Visibility(
            visible: _isVisible,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: SnakeBorderPainter(progress: _controller.value % 1),
                  size: Size(150, 50), // Ensure the CustomPaint matches the Container
                );
              },
            ),
          ),
          // Text always visible
          ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              widget.text,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SnakeBorderPainter extends CustomPainter {
  final double progress;
  SnakeBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3

      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height),
        [
        
          Color(0xffD5E2FE).withOpacity(0.1),
          Color(0xff155AEE),
        ],
      );

    // Define path for rounded rectangle
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(20),
      ));

    // Animate the path using dash effect
    final PathMetrics pathMetrics = path.computeMetrics();
    for (var metric in pathMetrics) {
      final double pathLength = metric.length;
      final double start = (progress * pathLength) % pathLength;
      final double end = start + pathLength * 0.9;

      final Path extractPath = metric.extractPath(start, end);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(SnakeBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
