import 'package:flutter/material.dart';

class StarAnimationExample extends StatefulWidget {
  @override
  _StarAnimationExampleState createState() => _StarAnimationExampleState();
}

class _StarAnimationExampleState extends State<StarAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 1.0,
      upperBound: 1.07,
    )..repeat(reverse: true);
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
        title: Text("Zoom In-Out Star Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _controller.value,
              child: child,
            );
          },

          child: Container(
            width: 300,
            height: 57,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(12)),
              gradient: RadialGradient(
                colors: [Colors.yellow, Colors.orange],
                center: Alignment.center,
                radius: 0.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 9,
                  spreadRadius: 1,
                ),
              ],
            ),
            child:Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(



                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(12)),
                ),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("On our platform, you can both sell and rent your products",style: TextStyle(

                        fontFamily:
                        "Montserrat-Italic",
                        color:
                      Colors.black,
                      fontWeight:
                      FontWeight.w500,
                      fontSize: 14),

                  maxLines: 2),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}
