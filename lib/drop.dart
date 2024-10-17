import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

void main() {
  runApp(MyAppss());
}

class MyAppss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownvalue = 'Apple';
  var items = [
    'Apple',
    'Banana',
    'Grapes',
    'Orange',
    'watermelon',
    'Pineapple'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DropDownList Example"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Title"),
            DropdownButtonHideUnderline(
                                    child: Container(
                                      height: 40,

                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.greenAccent,borderRadius: BorderRadius.circular(30.0)),
            child: DropdownButton2(
              style: Theme.of(context).textTheme.titleLarge,
              hint: Text(
                'Select Item',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items
                  .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
              value: dropdownvalue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            /*  buttonHeight: 40,
              buttonWidth: 140,
              itemHeight: 40,*/
            ),
                                    ),
                                  ),
          ],
        ),
      ),
    );
  }
}