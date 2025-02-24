import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'DetailScreen.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            width: double.infinity,
            height: SizeConfig.screenHeight * 0.43, // 40% of screen height
            child: Image.asset(
              'assets/images/estione.png',
              fit: BoxFit.cover,
            ),
          ),

          // Black Shadow Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            left: SizeConfig.screenWidth * 0.05,
            top: SizeConfig.screenHeight * 0.05,
            child: Container(
              height: SizeConfig.screenHeight * 0.05, // 5% of screen height
              width: SizeConfig.screenHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: CommonColor.grayText, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: SizeConfig.screenHeight * 0.025, // Responsive icon size
                ),
              ),
            ),
          ),

          // All Information (Title + Location)
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.22,
                left: SizeConfig.screenWidth * 0.03),
            child: Container(
                // color: Colors.red,
                height: SizeConfig.screenHeight * 0.2,
                child: AllInformationWidget(
                    SizeConfig.screenWidth, SizeConfig.screenHeight)),
          ),
        ],
      ),
    );
  }
}

class AllInformationWidget extends StatefulWidget {
  final double parentHeight;
  final double parentWidth;

  AllInformationWidget(this.parentHeight, this.parentWidth);

  @override
  _AllInformationWidgetState createState() => _AllInformationWidgetState();
}

class _AllInformationWidgetState extends State<AllInformationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _animation;
  String text = "PET WORLD";

  late Animation<double> _scaleAnimation;
  late AnimationController _controllerss;
  late AnimationController _scaleController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400), // Fast Slide Effect
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-0.1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth effect
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    repeatAnimation();

    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerss, curve: Curves.easeOutBack),
    );

    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      upperBound: 2.0, // Loop exactly 2 times
    );

    _controllerss.repeat().whenComplete(() {
      setState(() {
        _isVisible = false;
      });
    });
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
  }

  void repeatAnimation() async {
    while (mounted) {
      await _controller.forward();
      await Future.delayed(Duration(milliseconds: 800));
      await _controller.reverse();
      await Future.delayed(Duration(milliseconds: 800));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerss.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: "Montserrat-BoldItalic",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    double textWidth =
        textPainter.width + 30; // ✅ Extra padding for better spacing
    double textHeight = textPainter.height + 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Create Product",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat-Bold",
            fontSize: SizeConfig.blockSizeHorizontal * 5.7,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.004),
        Text(
          "Hi, Aayshaaa",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat_Medium',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.005),
        Text(
          "Generating ideas for new product",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat-Medium",
            fontSize: SizeConfig.blockSizeHorizontal * 3.7,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        /* IntrinsicWidth(
          child: Container(
            height: widget.parentHeight * 0.1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff632883), Color(0xff8d42a3)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            alignment:
                Alignment.centerLeft, // Align text to left inside container
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,


                child: Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.5),
                  highlightColor: Colors.white,
                  period: Duration(milliseconds: 800), // Slow shimmer effect

                  child: Text(
                    "PET WORLD",
                    style: TextStyle(
                      fontFamily: "Montserrat-BoldItalic",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),*/

        /* IntrinsicWidth(
          child: Container(
            height: widget.parentHeight * 0.1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff632883),
                  Color(0xff8d42a3)

                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              alignment: Alignment.center,
              children: [

                Visibility(
                  visible: _isVisible,
                  child: AnimatedBuilder(
                    animation: _controllerss,
                    builder: (context, child) {

                      TextPainter textPainter = TextPainter(
                        text: TextSpan(
                          text: "PET WORLD",
                          style: TextStyle(
                            fontFamily: "Montserrat-BoldItalic",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textDirection: TextDirection.ltr,
                      )..layout();

                      double textWidth = textPainter.width + 25;
                      double textHeight = textPainter.height + 15;

                      return CustomPaint(
                        painter: SnakeBorderPainter(progress: _controllerss.value),
                        size: Size(textWidth, textHeight),
                      );
                    },
                  ),
                ),


                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Text(
                      "PET WORLD",
                      style: TextStyle(
                        fontFamily: "Montserrat-BoldItalic",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),*/

        Stack(
          alignment: Alignment.center,
          children: [
            // 🔥 Border Animation
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controllerss,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SnakeBorderPainter(progress: _controllerss.value),
                    child: Container(
                      width: textWidth,
                      height: textHeight,
                    ),
                  );
                },
              ),
            ),


            Container(
              width: textWidth,
              height: textHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff632883), Color(0xff8d42a3)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: "Montserrat-BoldItalic",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),


      ],
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
      ..strokeWidth = 2
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height),
        [
          Color(0xffe8a33e),
          Color(0xffe8a33e),
        ],
      );

    // Define path for rounded rectangle
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(10),
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
