import 'package:flutter/material.dart';

class TapColorChangeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Tap Color Change'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // Perform your action when tapped
            print("Container tapped!");
          },
          splashColor: Colors.blue.withOpacity(0.3), // Color when tapped
          highlightColor: Colors.blue.withOpacity(0.1), // Color while holding
          borderRadius: BorderRadius.circular(12), // Optional: Adds rounded corners
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.teal, // Default container color
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            child: Text(
              'Tap Me!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: TapColorChangeExample(),
));
