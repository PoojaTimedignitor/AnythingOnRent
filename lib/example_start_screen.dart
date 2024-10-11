import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'animation_screen.dart';

void main() {
  runApp(regis());
}

class regis extends StatefulWidget {
  @override
  _regisState createState() => _regisState();
}

class _regisState extends State<regis> {
  TextEditingController nameController = TextEditingController();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff6a83da),
                        Color(0xff665365B7),
                      ],
                    )),
              ),
            ),
            Stack(
              children: [
                RegisterContent(SizeConfig.screenHeight, SizeConfig.screenWidth),
               // NameData(SizeConfig.screenHeight, SizeConfig.screenWidth),
              ],
            ),
           AnimationScreen(color: Theme.of(context).colorScheme.secondary)
          ],
        ),
      ),
    );
  }
  Widget RegisterContent(double parentWidth,double parentHeight){
    return Center(child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                ),
                onChanged: (text) {
                  setState(() {
                    fullName = text;
                    //you can access nameController in its scope to get
                    // the value of text entered as shown below
                    //fullName = nameController.text;
                  });
                },
              )),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(fullName),
          )
        ]
        ));
  }
}