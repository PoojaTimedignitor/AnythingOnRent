import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback? onBackPress; // Optional action for back button

  const CommonLayout({
    Key? key,
    required this.child,
    this.title = "",
    this.onBackPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackPress ?? () => Navigator.pop(context), // Back action
        ),
      ),
       body:  Stack(
    children: [

    Padding(
      padding: const EdgeInsets.all(1.0),
      child: Positioned.fill(
      child: Image.asset(
        'assets/images/register_logo.png',
        fit: BoxFit.cover
        ,  // Make the image cover the whole screen
      ),
      ),
    ),

    SingleChildScrollView(  // Scrollable content
    child: SafeArea(
    child: Padding(
    padding: const EdgeInsets.all(20),
    child: child,
    ),
    ),
    ),
    ],
    ),

    );
  }
}
