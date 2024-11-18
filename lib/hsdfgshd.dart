import 'package:flutter/material.dart';

void main() {
  runApp(const MyAppss());
}

class MyAppss extends StatelessWidget {
  const MyAppss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InkWellColorChangeExample(),
    );
  }
}

class InkWellColorChangeExample extends StatefulWidget {
  @override
  _InkWellColorChangeExampleState createState() =>
      _InkWellColorChangeExampleState();
}

class _InkWellColorChangeExampleState extends State<InkWellColorChangeExample> {
  // State to keep track of color change
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InkWell Color Change"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              _isPressed = !_isPressed; // Toggle the color state
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _isPressed ? Colors.blue : Colors.green, // Change color on tap
              borderRadius: BorderRadius.circular(12),
            ),
            height: 100,
            width: 200,
            child: Center(
              child: Text(
                'Tap Me!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
