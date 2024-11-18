import 'package:anything/All_Product_List.dart';
import 'package:anything/MainHome.dart';
import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'Home_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ValueNotifier to track the selected index
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  // Define the content for each screen/tab
  static List<Widget> _screens = <Widget>[
    MainHome(),
    AllProductList(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: Column(
            children: [
              Row(

                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi,Aaysha",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                            fontFamily: 'Roboto_Medium',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/location.png'),
                              height: SizeConfig.screenHeight * 0.017,
                            ),
                            Text(
                              "Park Street, Kolkata, 700021",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                  fontFamily: 'Poppins_Medium',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.screenWidth * .29),
                    child: Padding(
                      padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.0),
                      child: Image(
                        image: AssetImage('assets/images/notification.png'),
                        height: SizeConfig.screenHeight * 0.025,
                      ),
                    ),
                  ),

                ],
              ),
              /* HomeSearchBar(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),*/
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 108,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100)),
                          color: Color(0xffFBB3B3),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 85,
                        height: 95,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100)),
                          color: Color(0xffF48A8A),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 52,right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/images/profile.png"),
                        ),
                      ),

                      SizedBox(
                          width: 10,
                          height:
                          5), // Add some space between the avatar and the column
                      Text(
                        "Hii, Aaysha",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto_Regular",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      // Adds space between the icon and text

                      GestureDetector(
                        onTap: () {},
                        child: Wrap(
                          spacing: 8,
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
                              width: 160,
                              //  color: Colors.red,
                              child: Text(
                                "Park pashan pune, 2004 pune pashan... ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins_Medium',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black45,
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

            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Image(
                          image: AssetImage('assets/images/dashboard.png'),
                          height: 20,
                          color: Colors.black54,
                        ),
                        Text(
                          // the text of the row.
                            "My Dashboard",
                            style: TextStyle(
                                fontSize: 15,
                                color: CommonColor.gray,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Image(
                          image: AssetImage('assets/images/userprofile.png'),
                          height: 20,
                          color: Colors.black54,
                        ),
                        Text(
                          // the text of the row.
                            "My Profile",
                            style: TextStyle(
                                fontSize: 15,
                                color: CommonColor.gray,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Image(
                          image: AssetImage('assets/images/myads.png'),
                          height: 20,
                          color: Colors.black54,
                        ),
                        Text(
                          // the text of the row.
                            "My Ads",
                            style: TextStyle(
                                fontSize: 15,
                                color: CommonColor.gray,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Wrap(
                      spacing: 10,
                      children: [
                        Image(
                          image: AssetImage('assets/images/like.png'),
                          height: 20,
                          color: Colors.black54,
                        ),
                        Text(
                          // the text of the row.
                            "My Favorites",
                            style: TextStyle(
                                fontSize: 15,
                                color: CommonColor.gray,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image:
                              AssetImage('assets/images/transaction.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 140,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "My Transaction History",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/ratings.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 108,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "My Ratings",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/noti.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 108,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "Notifications",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/payment.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 140,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "My Payment History",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/privacy.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 108,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "privacy policy",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/terms.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 108,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 10,
                          children: [
                            const Image(
                              image: AssetImage('assets/images/terms.png'),
                              height: 20,
                              color: Colors.black54,
                            ),
                            Container(
                              width: 108,
                              //  color: Colors.red,
                              child: Text(
                                // the text of the row.
                                  "Support",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: CommonColor.gray,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: SizeConfig.screenHeight * 0.0007,
                    width: 160,
                    color: Colors.black54,
                  ),
                  SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                          MaterialPageRoute(
                            builder: (_) => TestPage(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: const Image(
                            image: AssetImage('assets/images/logout.png'),
                            height: 20,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(
                            width:
                            10), // Add spacing between the image and text
                        Expanded(
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, selectedIndex, child) {
          return _screens[selectedIndex]; // Change screen based on index
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000).withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 0,
                offset: Offset(0, 1)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ValueListenableBuilder<int>(
            valueListenable: _selectedIndex,
            builder: (context, selectedIndex, child) {
              return BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex.value,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,


                onTap: (index) {
                  _selectedIndex.value = index; // Change screen when tapped
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// Define screens for each tab
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // Navigate to Dashboard screen while keeping the AppBar and Drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashBoardScreen()),
          );
        },
        child: Text('Home Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page', style: TextStyle(fontSize: 24)),
    );
  }
}

// Dashboard Screen that can be opened from Home Screen
class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
          child: Text('Dashboard Content', style: TextStyle(fontSize: 24))),
    );
  }
}
