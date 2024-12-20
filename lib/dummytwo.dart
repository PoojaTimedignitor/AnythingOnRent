import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  // 1. Create a GlobalKey to control the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // 2. Assign the key to the Scaffold
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      drawer: Drawer(
        backgroundColor: Color(0xffffffff),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 160,
              color: Color(0xfff1f2fd),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 108,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100)),
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 85,
                      height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100)),
                        color: Color(0xfff1f2fd),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30, left: 23),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 29.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage('assets/images/profiless.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hii, User",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2),
                                GestureDetector(
                                  onTap: () {},
                                  child: Wrap(
                                    spacing: 4,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 3),
                                        child: const Image(
                                          image: AssetImage('assets/images/location.png'),
                                          height: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        child: Text(
                                          "Location info here",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: 'Montserrat_Medium',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle tap
                    },
                    child: Wrap(
                      spacing: 13,
                      children: [
                        SizedBox(width: 03),
                        Image(
                          image: AssetImage('assets/images/userprofile.png'),
                          height: 22,
                        ),
                        Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "okra_Regular",
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  // Add more drawer items as needed...
                ],
              ),
            ),
          ],
        ),
      ),
      // 3. Button to open the drawer manually
      body: GestureDetector(
        onTap: () {
          // 4. Open the Drawer manually using the GlobalKey
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Center(child: Icon(Icons.dehaze_rounded)),
      ),
     // No AppBar
    );
  }
}
