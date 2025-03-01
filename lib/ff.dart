import 'dart:math';
import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  final double currentState;

  BorderPainter({required this.currentState});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 4;
    Rect rect = Offset(0, 0) & Size(size.width, size.height);

    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startAngle = pi / 2;
    double sweepAmount = currentState * pi;

    canvas.drawArc(rect, startAngle, sweepAmount, false, paint);
    canvas.drawArc(rect, startAngle, -sweepAmount, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BorderPage extends StatelessWidget {
  final double borderState;

  const BorderPage({Key? key, required this.borderState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Border")),
      body: Center(
        child: CustomPaint(
          painter: BorderPainter(currentState: borderState),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
