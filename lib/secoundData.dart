import 'package:flutter/material.dart';

import 'dummyData.dart';

class SecondScreen extends StatelessWidget {
  final String ribbonText;

  const SecondScreen({super.key, required this.ribbonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Hero(
          tag: ribbonText, // Same tag for smooth transition
          child: RibbonShape(text: ribbonText, isHero: true),
        ),
      ),
    );
  }
}
