import 'package:flutter/material.dart';
class MyRatings extends StatefulWidget {
  const MyRatings({super.key});

  @override
  State<MyRatings> createState() => _MyRatingsState();
}

class _MyRatingsState extends State<MyRatings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("My Ratings",)),
    );
  }
}
