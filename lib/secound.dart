import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String textToReturn = "This is some text that can be selected.";

    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SelectableText(
              textToReturn,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Return the selected text to the first screen
                Navigator.pop(context, textToReturn);
              },
              child: Text("Return Selected Text"),
            ),
          ],
        ),
      ),
    );
  }
}
