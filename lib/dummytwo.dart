import 'package:flutter/material.dart';

void main() {
  runApp(dataaaaaa());
}

class dataaaaaa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ZeptoToggleBar(),
    );
  }
}

class ZeptoToggleBar extends StatefulWidget {
  @override
  _ZeptoToggleBarState createState() => _ZeptoToggleBarState();
}

class _ZeptoToggleBarState extends State<ZeptoToggleBar> {
  int selectedIndex = 0; // To track selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[50],
        title: const Text(
          "Zepto",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Top toggle bar container with buttons inside
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Align buttons to ends
              children: [
                // Zepto Button (Left aligned)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0 ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      "Zepto",
                      style: TextStyle(
                        color: selectedIndex == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Zepto Super Saver Button (Right aligned)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1 ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Text(
                      "Zepto Super Saver",
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content based on selected tab
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: selectedIndex == 0
                  ? Text(
                "Zepto Content",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
                  : Text(
                "Zepto Super Saver Content",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
