import 'package:anything/All_Product_List.dart';
import 'package:anything/Common_File/SizeConfig.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:anything/MyBehavior.dart';

import 'package:anything/pupularCatagoriesViewAll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import 'Common_File/common_color.dart';
import 'Common_File/new_responsive_helper.dart';
import 'dummy.dart';


final ZoomDrawerController z = ZoomDrawerController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    return ZoomDrawer(
      controller: z,
      borderRadius: 25,
      mainScreenScale: 0.04,
      androidCloseOnBackTap: true,
      moveMenuScreen: true,
      // showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: 240,
      showShadow: true,
      duration: const Duration(milliseconds: 300),
      menuScreenTapClose: true,

      // angle: 0.0,
      menuBackgroundColor: const Color(0xFFFEDEDE),
      mainScreen: const Body(),
      // moveMenuScreen: false,
      menuScreen: Scaffold(
        backgroundColor: const Color(0xFFFEDEDE),
        body: Column(
          //shrinkWrap: true,
         // physics: const NeverScrollableScrollPhysics(),
         // padding: EdgeInsets.zero,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 108,
                    height: 120,
                    decoration: const BoxDecoration(
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
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100)),
                      color: Color(0xffF48A8A),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),

                   SizedBox(width: 10, height: responsive.height(20)),     // Add some space between the avatar and the column            /// new changes

                  const Text(
                    "Hii, Aaysha",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Roboto_Regular",
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  //SizedBox(height: 2),
                  SizedBox(height: responsive.height(2),),        /// new changes

                  // Adds space between the icon and text

                  GestureDetector(
                    onTap: () {},
                    child: Wrap(
                      spacing: 8,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Image(
                            image: AssetImage('assets/images/location.png'),
                            height: 13,
                            color: Colors.black54,
                          ),
                        ),
                        Container(
                          width: 160,
                          //  color: Colors.red,
                          child: const Text(
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

            //SizedBox(height: 5),
            SizedBox(height: responsive.height(5),),        /// new changes

            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10),
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
                                builder: (_) => const TestPage(),
                              ),
                            ),
                          );
                    },
                    child: const Wrap(
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

                  //SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
                              ),
                            ),
                          );
                    },
                    child: const Wrap(
                      spacing: 10,
                      children: [
                        Image(
                          image: AssetImage('assets/images/userprofile.png'),
                          height: 20,
                          color: Colors.black54,
                        ),
                        Text(
                            "My Profile",
                            style: TextStyle(
                                fontSize: 15,
                                color: CommonColor.gray,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),

                 // SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
                              ),
                            ),
                          );
                    },
                    child: const Wrap(
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

                  //SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
                              ),
                            ),
                          );
                    },
                    child: const Wrap(
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

                  //SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                  //SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                 // SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                 // SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                  //SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                 // SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                 // SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
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
                              child: const Text(
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

                 // SizedBox(height: 20),
                  SizedBox(height: responsive.height(20),),        /// new changes

                  Container(
                    height: SizeConfig.screenHeight * 0.0007,
                    width: 160,
                    color: Colors.black54,
                  ),

                  //SizedBox(height: 18),
                  SizedBox(height: responsive.height(18),),        /// new changes

                  GestureDetector(
                    onTap: () {
                      final navigator = Navigator.of(
                        context,
                      );
                      z.close?.call()?.then(
                            (value) => navigator.push(
                              MaterialPageRoute(
                                builder: (_) => const TestPage(),
                              ),
                            ),
                          );
                    },
                    child:  Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Image(
                            image: AssetImage('assets/images/logout.png'),
                            height: 20,
                            color: Colors.blueAccent,
                          ),
                        ),

                      //  SizedBox(width: 10),                  // Add spacing between the image and text
                        SizedBox(width: responsive.width(10)),                                                  /// new changes

                        const Expanded(
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

                 // SizedBox(height: 18),
                  SizedBox(height: responsive.height(18),),        /// new changes

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TwoPanels(
        controller: controller,
      ),
    );

  }
}

class TwoPanels extends StatefulWidget {
  final AnimationController controller;

  const TwoPanels({Key? key, required this.controller}) : super(key: key);

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> with TickerProviderStateMixin {
  static const _headerHeight = 32.0;
  late TabController tabController = TabController(length: 3, vsync: this);
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..addListener(() {
      print("SlideValue: ${_controller.value} - ${_controller.status}");
    });
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final _height = constraints.biggest.height;
    final _backPanelHeight = _height - _headerHeight;
    const _frontPanelHeight = -_headerHeight;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        0.0,
        _backPanelHeight,
        0.0,
        _frontPanelHeight,
      ),
      end: const RelativeRect.fromLTRB(0.0, 100, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: widget.controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchFocus.dispose();
    tabController.dispose();
    super.dispose();
  }

  final _searchFocus = FocusNode();
  final searchController = TextEditingController();
  int currentIndex = 0;
  int _currentIndex = 0;
  int _counter = 0;
  late TabController _tabController;
  final List<String> images = [
    "https://img.freepik.com/free-vector/gradient-car-rental-twitch-background_23-2149238538.jpg?w=1380&t=st=1724674607~exp=1724675207~hmac=0ab319f9d9411c32c9d26508151d51f62139e048ac598796c8463dac3ef0aad7"
        'https://img.freepik.com/free-vector/real-estate-landing-page_23-2148686374.jpg?w=1380&t=st=1724741972~exp=1724742572~hmac=e21195893cb55e204d9618c983abd7d4d1dc18402402af3dbe0420bd08d6ad33',
    "https://img.freepik.com/free-vector/hand-drawn-real-estate-poster-template_23-2149845735.jpg?w=740&t=st=1724742124~exp=1724742724~hmac=3920ca483a7e7dc65a3006016da9687799d3d72e35d5a70af985ce681bbdfc49"
        'https://images.pexels.com/photos/3757226/pexels-photo-3757226.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/13065690/pexels-photo-13065690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/372810/pexels-photo-372810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/4489702/pexels-photo-4489702.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
  ];

  List<String> catagriesItemList = [
    "Vehicle",
    "Fashion",
    "Home Appliances",
    "Event",
    "Furniture",
    "Party Bus",
    "Car",
    "Camera",
    "Bike",
    "Sports Equipment",
    "Clothing",
    "Electronics",
    "Kitchenware",
    "Office Equipment",
  ];
  final List<String> catagriesImage = [
    'assets/images/catsaven.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png',
    'assets/images/catone.png',
    'assets/images/catthree.png',
    'assets/images/catsix.png',
    'assets/images/catfive.png',
    'assets/images/catsix.png',
    'assets/images/catfive.png',
    'assets/images/catsix.png',
    'assets/images/catsaven.png',
    'assets/images/catfour.png',
    'assets/images/catsix.png',
    'assets/images/catsaven.png'
  ];
  final Map<String, int> productCountList = {
    "Vehicle": 12,
    "Fashion": 8,
    "Home Appliances": 15,
    "Event": 5,
    "Furniture": 20,
    "Party Bus": 3,
    "Camera": 6,
    "Bike": 7,
    "Sports Equipment": 11,
    "Clothing": 9,
    "Electronics": 14,
    "Kitchenware": 13,
    "Office Equipment": 8,
  };


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
                height: SizeConfig.screenHeight * 0.17,
                child: Column(

                  children: [
                    getAddMainHeadingLayout(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    HomeSearchBar(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ],
                )),
            Container(
              height: SizeConfig.screenHeight * 0.83,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  sliderData(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  AddPostButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  PopularCategories(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.07),
                    child: Container(
                    //  height: SizeConfig.screenHeight * 0.99,
                      child: getAddGameTabLayout(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                    ),
                  ),
                  /* Stack(
                    children: [
                   Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.68, top: 200),
                    child: Image(
                      image: AssetImage('assets/images/home.png'),
                      height: SizeConfig.screenHeight * 0.280,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.30),
                    child: Image(
                      image: AssetImage('assets/images/homecircle.png'),
                      height: SizeConfig.screenHeight * 0.120,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.40),
                    child: Image(
                      image: AssetImage('assets/images/homecircle.png'),
                      height: SizeConfig.screenHeight * 0.120,
                    ),
                  ),


                      // RegisterButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),

     /* bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BottomNavyBar(
          showInactiveTitle: true,
          backgroundColor: Colors.grey[200],
          selectedIndex: _currentIndex,
          showElevation: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 0),
        //  itemCornerRadius: 24,
         // iconSize: 20,

          curve: Curves.linear,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(Icons.home, color: Colors.black, size: 17),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              activeBackgroundColor: Colors.white,
              activeTextColor: Colors.black87,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 17,
                ),
              ),
              title: Text(
                'Search',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              activeTextColor: Colors.black87,
              activeBackgroundColor: Colors.white,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.all(6.0),
                child: Image(
                  image: AssetImage('assets/images/like.png'),
                  color: Colors.black,
                  height: 18,
                ),
              ),
              title: Text(
                'Favorite',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              activeTextColor: Colors.black,
              textAlign: TextAlign.center,
              activeBackgroundColor: Colors.white,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(Icons.settings, color: Colors.black, size: 17),
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              activeTextColor: Colors.black87,
              activeBackgroundColor: Colors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),*/
    );

  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {

    final responsive = ResponsiveHelper(context);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            z.toggle!();
            z.open!();
          },
          onDoubleTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: parentWidth * .02),
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.04),
              child: Image(
                image: const AssetImage('assets/images/sidebar.png'),
                height: parentHeight * 0.045,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.05),
              child: Text(
                "    Hi,Aaysha",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),

           // SizedBox(height: 4),
            SizedBox(height: responsive.height(4),),        /// new changes

            Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.03),
              child: Row(
                children: [
                  Image(
                    image: const AssetImage('assets/images/location.png'),
                    height: parentHeight * 0.017,
                  ),
                  Text(
                    "  Park Street, Kolkata, 700021",
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
          padding: EdgeInsets.only(left: parentWidth * .29),
          child: Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.04),
            child: Image(
              image: const AssetImage('assets/images/notification.png'),
              height: parentHeight * 0.025,
            ),
          ),
        ),
      ],
    );
  }

  Widget HomeSearchBar(double parentHeight, double parentWidth) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * .05,
              top: SizeConfig.screenHeight * 0.014),
          child: SizedBox(
            height: SizeConfig.screenHeight * .055,
            width: SizeConfig.screenWidth * .95,
            child: Padding(
              padding: EdgeInsets.only(right: parentWidth * 0.04),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      autocorrect: true,
                      controller: searchController,
                      focusNode: _searchFocus,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Image(
                              image: const AssetImage("assets/images/search.png"),
                              height: SizeConfig.screenWidth * 0.07,
                            )),
                        hintText: "Search product/service",
                        hintStyle: TextStyle(
                          fontFamily: "Roboto_Regular",
                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          color: CommonColor.SearchBar,
                          fontWeight: FontWeight.w300,
                        ),
                        contentPadding: EdgeInsets.only(
                          top: parentWidth * 0.05,
                        ),
                        fillColor: const Color(0xfffbf3f3),
                        hoverColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ))),
            ),
          ),
        ),
      ],
    );
  }

  Widget sliderData(double parentHeight, double parentWidth) {

    final responsive = ResponsiveHelper(context);                                /// new add

    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              initialPage: 1,
              height: MediaQuery.of(context).size.height * .19,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              autoPlay: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            itemBuilder: (BuildContext context, int itemIndex, int index1) {
              final img = images.isNotEmpty
                  ? NetworkImage(images[index1])
                  : const NetworkImage("");

              return Container(
                  margin: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: const Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(-2, 0),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(1, 0),
                      )
                    ],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < images.length; i++)
              currentIndex == i
                  ? Container(
                      width: 25,
                      height: 7,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff6a83da),
                              Color(0xff665365B7),
                            ]),
                      ),
                    )
                  : Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff7F9ED4),
                                Color(0xff999999),
                              ]),
                          shape: BoxShape.circle),
                    )
          ],
        ),
      ],
    );
  }

  Widget AddPostButton(double parentHeight, double parentWidth) {

    final responsive = ResponsiveHelper(context);                                   /// new add

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoardScreen(

                    //  recLane: widget.recLane,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: parentWidth * 0.67, right: parentWidth * 0.05),
        child: Container(
          //alignment: Alignment.,
          height: parentHeight * 0.030,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: CommonColor.Blue),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
            "Create Post +",
            style: TextStyle(
              fontFamily: "okra_regular",
              fontSize: SizeConfig.blockSizeHorizontal * 3.1,
              color: const Color(0xff3684F0),
              fontWeight: FontWeight.w300,
            ),
          )),
        ),
      ),
    );
  }

  Widget PopularCategories(double parentHeight, double parentWidth) {

    final responsive = ResponsiveHelper(context);

    return Column(

  children: [
     Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: Divider()),

        //SizedBox(width: 10,),
        SizedBox(width: responsive.width(10)),                            /// new changes

        Center(
            child: Text(
              " POPULAR CATEGORIES",
              style: TextStyle(color: Colors.grey[500]!,
                  fontFamily: "okra_Regular",
                  fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                  fontWeight: FontWeight.w400,
                letterSpacing: 0.9
             ),overflow: TextOverflow.ellipsis
            )),

        //SizedBox(width: 10,),
        SizedBox(width: responsive.width(10)),                            /// new changes


        const Expanded(child: Divider()),
      ],
    ),
    Padding(
      padding:  EdgeInsets.only(left: parentWidth*0.02),
      child: SizedBox(
        height: 200, // Set a fixed height for the GridView
        child: GridView.builder(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of rows
            crossAxisSpacing: 2, // Space between columns
            mainAxisSpacing: 23, // Space between rows
            childAspectRatio: 3 / 2,
          ),
          itemCount: catagriesItemList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.00),
                    child:   Image.asset(
                      catagriesImage[index],
                      height: 78,
                      width: 45,
                    ),
                  ),
                ),

                Center(
                  child: Text(
                          catagriesItemList[index],
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.0,
                      fontFamily: "okra_medium",
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      fontWeight: FontWeight.w500,
                    ),overflow: TextOverflow.ellipsis,

                   /* style: TextStyle(
                      color: CommonColor.Black,
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                      fontWeight: FontWeight.w500,
                    ),*/

                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  ],
);

     /* Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "   Popular Categories",
                style: TextStyle(
                  fontFamily: "Montserrat-Medium",
                  fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                  color: CommonColor.TextBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              */
    /*GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => PopularCatagoriesData(
                  )));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.3, top: parentWidth * 0.0),
                  child: Container(
                    height: parentHeight * 0.025,
                    width: parentWidth * 0.2,
                    decoration: BoxDecoration(
                        color: CommonColor.ViewAll,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("View All",
                            style: TextStyle(
                              fontFamily: "Montserrat-Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 2.4,
                              color: CommonColor.TextBlack,
                              fontWeight: FontWeight.w400,
                            )),
                        Image(
                          image: AssetImage('assets/images/arrow.png'),
                          height: 20,
                          width: 15,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                ),
              )*//*
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.009,
                left: parentWidth * 0.04,
                right: parentWidth * 0.04),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

              child: CommonWidget(
                text: "Electronics",
                texttwo: 'Mobiles & Tab',
                textthree: 'Furniture',
                textfour: 'Events',
                textfive: 'Events',
                textsix: 'More',
              ),
            ),
          ),
          SizedBox(height: 13),
          Center(
            child: Container(
              height: parentHeight * 0.0005,
              width: parentWidth * 0.95,
              color: CommonColor.SearchBar,
            ),
          )
        ],
      ),
    );*/
  }

  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {

    final responsive = ResponsiveHelper(context);                                    /// new add

    return Padding(
        padding:  EdgeInsets.only(top: parentHeight*0.04),
        child: Column(

          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(child: Divider()),

                //SizedBox(width: 10,),
                SizedBox(width: responsive.width(10)),                            /// new changes


                Center(
                    child: Text(
                        "WHAT'S ON YOUR RENTAL MATERIALS?",
                        style: TextStyle(color: Colors.grey[500]!, fontFamily: "okra_Regular",
                            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.9
                        ),overflow: TextOverflow.ellipsis
                    )),

               // SizedBox(width: 10,),
                SizedBox(width: responsive.width(10)),                            /// new changes


                const Expanded(child: Divider()),
              ],
            ),
            SafeArea(
              child: DefaultTabController(
                length: 2,
                child: Column(

                  children: [
                    Container(
                      height: 60,

                      padding: const EdgeInsets.only(left: 0, bottom: 20, right: 0),
                      child: ButtonsTabBar(
                        backgroundColor: CommonColor.ViewAll,
                        buttonMargin: const EdgeInsets.symmetric(horizontal: 25),
                        unselectedBackgroundColor: Colors.grey[200],
                        physics: const NeverScrollableScrollPhysics(),
                        unselectedLabelStyle: const TextStyle(color: Colors.black),
                         // center:true,
                        labelStyle:
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),


                        tabs: [
                          Tab(
                            child: Container(
                              height: 40,
                              width: 150,
                              padding: const EdgeInsets.only(left: 10, right: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(

                                children: [
                                  const Image(
                                      image: AssetImage('assets/images/pro.png'),
                                      height: 72,
                                      width: 50),
                                  Text(
                                    "Product",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontFamily: "okra_medium",
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 40,
                              width: 150,
                              padding: const EdgeInsets.only(left: 10, right: 20),
                              decoration: BoxDecoration(
                               // borderRadius: BorderRadius.circular(10),
                                borderRadius: BorderRadius.circular(responsive.width(12)),                      /// new change

                                /* border: Border.all(color: Colors.black, width: 0.5)*/),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                      child: Row(
                                        children: [
                                          const Image(
                                              image: AssetImage('assets/images/service.png'),
                                              height: 72,
                                              width: 50),
                                          Text(
                                            "Service",
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                              fontFamily: "okra_medium",
                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),),
                            ),
                          ),


                        ],
                      ),
                    ),

                    Container(
                      //child: Container(
                      height: SizeConfig.screenHeight*0.9,
                      //color: Colors.blue,
                      child: TabBarView(
                        children: [

                          Flexible(
                            child: Column(
                              children: [

                               // SizedBox(height: 10),
                                SizedBox(height: responsive.height(4),),        /// new changes

                                Row(
                                  children: [
                                    Text(
                                      "  Near by Location",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-Medium",
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PopularCatagoriesData()));
                                      },
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(left: parentWidth * 0.35),
                                        child: Container(
                                          height: parentHeight * 0.035,
                                          width: parentWidth * 0.22,
                                         // width: responsive.width(10),                               /// new changes
                                          decoration: const BoxDecoration(
                                              color: CommonColor.ViewAll,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("View All",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat-Regular",
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2.8,
                                                    color: CommonColor.TextBlack,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              const Image(
                                                image: AssetImage(
                                                    'assets/images/arrow.png'),
                                                height: 20,
                                                width: 15,
                                                color: Colors.black54,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "   Near By Place",
                                  style: TextStyle(
                                    fontFamily: "Roboto_Normal",
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                    color: CommonColor.grayText,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                GridView.builder(
                                  padding: const EdgeInsets.only(top: 15),
                                  physics:
                                  const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                                  shrinkWrap: true, // Take only the space it needs
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                    2, // Number of columns in the grid
                                    crossAxisSpacing: 1.0,
                                    mainAxisSpacing: 0.0,
                                    childAspectRatio: 1.0, // Adjust as needed
                                  ),
                                  itemCount: 4, // Number of items in the grid
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0,
                                          right: 5.0,
                                          top: 0.0,
                                          bottom: 30.0),
                                      //  height: SizeConfig.screenHeight * 0,
                                      decoration: BoxDecoration(
                                          color: CommonColor.redContainer,
                                          boxShadow: [
                                            BoxShadow(
                                                color: const Color(0xff000000)
                                                    .withOpacity(0.2),
                                                blurRadius: 2,
                                                spreadRadius: 0,
                                                offset: const Offset(0, 1)),
                                          ],
                                   /*       border: Border.all(
                                              color: Colors.black38, width: 0.9),*/

                                          borderRadius: const BorderRadius.all(Radius.circular(7))),

                                      // alignment: Alignment.center,

                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: SizeConfig.screenHeight * 0.1,
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(7),
                                                    topRight: Radius.circular(7),
                                                  ),
                                                  child: AnotherCarousel(
                                                    images: const [
                                                      NetworkImage(
                                                          "https://media.istockphoto.com/id/1269776313/photo/suburban-house.jpg?s=1024x1024&w=is&k=20&c=xIwaYa1oKX9jnEnlsObNYDrljAkEsjOLlE66Eg2fDco="),
                                                      NetworkImage(
                                                          "https://media.istockphoto.com/id/507832549/photo/couple-standing-on-balcony-of-modern-house.jpg?s=2048x2048&w=is&k=20&c=7ooit4W_g24NDUGnLDWs9Dlh0F8T6dRbtX8RBBgQiuE="),
                                                      NetworkImage(
                                                          "https://media.istockphoto.com/id/1436217023/photo/exterior-of-a-blue-suburban-home.jpg?s=2048x2048&w=is&k=20&c=Z9Wc1NpUagwfdZbtHCyVEF9JnLXDIsPyIrw48-UXFb0="),
                                                      // we have display image from netwrok as well
                                                      NetworkImage(
                                                          "https://media.istockphoto.com/id/1132628728/photo/couple-in-front-of-residential-home-smiling.jpg?s=2048x2048&w=is&k=20&c=wqxgUhQQAqthoi-h80nHksGOhklcUywyrkCDwXPXxEc=")
                                                    ],
                                                    dotSize: 6,
                                                    dotSpacing: 10,
                                                    dotColor: Colors.white70,
                                                    dotIncreasedColor: Colors.black45,
                                                    indicatorBgPadding: 5.0,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                //  border: Border.all(color: CommonColor.bottomsheet, width: 0.2),

                                                child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 67, left: 111),
                                                    child: Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: Container(
                                                        height: 15,
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xff5095f1),
                                                          borderRadius: BorderRadius.circular(0),
                                                        //  borderRadius: BorderRadius.circular(responsive.width(0)),                /// new change
                                                        ),
                                                        child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                            children: [
                                                              Icon(
                                                                Icons.location_on,
                                                                size: SizeConfig
                                                                    .screenHeight *
                                                                    0.019,
                                                                color: Colors.white,
                                                              ),
                                                              Text(
                                                                '1.2 Km   ',
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  "Montserrat-Regular",
                                                                  fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                      2.5,
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                  FontWeight.w600,
                                                                ),
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                              ),
                                                            ]),
                                                      ),
                                                    )),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 65, left: 2),
                                                  child: Align(
                                                    alignment:
                                                    Alignment.bottomRight,
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            size: SizeConfig
                                                                .screenHeight *
                                                                0.02,
                                                            color:
                                                            const Color(0xffFFB905),
                                                          ),
                                                          Text(
                                                            " 4.5",
                                                            style: TextStyle(
                                                              fontFamily:
                                                              "Roboto-Regular",
                                                              fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  2.8,
                                                              color:
                                                              CommonColor.white,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ]),
                                                  ))
                                            ],
                                          ),

                                          //SizedBox(height: 4),
                                          SizedBox(height: responsive.height(4),),        /// new changes

                                          Container(
                                            width: SizeConfig.screenWidth * 0.42,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'HD Camera (black & white) dfgdf',
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat-Regular",
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        3.3,
                                                    color: CommonColor.Black,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),

                                                //SizedBox(height: 2),
                                                SizedBox(height: responsive.height(2),),        /// new changes

                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: SizeConfig.screenHeight *
                                                          0.019,
                                                      color: const Color(0xff3684F0),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        ' Park Street,pune banner 20023',
                                                        style: TextStyle(
                                                          fontFamily:
                                                          "Montserrat-Regular",
                                                          fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                              2.6,
                                                          color: const Color(0xff3684F0),
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              //  SizedBox(height: 5),
                                                SizedBox(height: responsive.height(5),),        /// new changes

                                                Row(
                                                  children: [
                                                    // color: Color(0xff3684F0),

                                                    Text(
                                                      " Share",
                                                      style: TextStyle(
                                                        color: CommonColor.grayText,
                                                        fontFamily: "Roboto_Regular",
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            2.7,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),

                                                   // SizedBox(width: 6),
                                                    SizedBox(width: responsive.width(6)),                            /// new changes

                                                    const Image(
                                                        image: AssetImage(
                                                            'assets/images/share.png'),
                                                        height: 13),

                                                    //SizedBox(width: 71),
                                                    SizedBox(width: responsive.width(71)),                            /// new changes

                                                    Container(
                                                      width: SizeConfig.screenWidth *
                                                          0.1,
                                                      decoration: BoxDecoration(
                                                          color: const Color(0xffffffff),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              3)),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            size: SizeConfig
                                                                .screenHeight *
                                                                0.016,
                                                            color: const Color(0xffFFB905),
                                                          ),
                                                          Text(
                                                            "  4.5",
                                                            style: TextStyle(
                                                              fontFamily:
                                                              "Roboto-Regular",
                                                              fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  2.5,
                                                              color:
                                                              CommonColor.Black,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "  All Product List",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-Medium",
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.1,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AllProductList()));
                                      },
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(left: parentWidth * 0.35),
                                        child: Container(
                                          height: parentHeight * 0.035,
                                          width: parentWidth * 0.22,
                                          decoration: const BoxDecoration(
                                              color: CommonColor.ViewAll,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("View All",
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat-Regular",
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2.8,
                                                    color: CommonColor.TextBlack,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                              const Image(
                                                image: AssetImage(
                                                    'assets/images/arrow.png'),
                                                height: 20,
                                                width: 15,
                                                color: Colors.black54,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "   Display All rental product options in your choose location",
                                  style: TextStyle(
                                    fontFamily: "Roboto_Normal",
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                                    color: CommonColor.grayText,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 10,
                                   // color: Colors.red,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    // Set height to fit the horizontal list
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10, // Define the number of items
                                        itemBuilder: (context, index) {
                                          return Container(
                                            width: parentWidth * 0.55,

                                            // Set width for each item
                                            margin:
                                            const EdgeInsets.symmetric(horizontal: 9.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(7),
                                              border: Border.all(
                                                  color: CommonColor.grayText,
                                                  width: 0.3),
                                              //  color: Color(0xffFFE5E3),
                                              //  borderRadius:
                                              //  BorderRadius.circular(12.0),

                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color(0xff000000)
                                                        .withOpacity(0.2),
                                                    blurRadius: 2,
                                                    spreadRadius: 0,
                                                    offset: const Offset(0, 1)),
                                              ],
                                            ),
                                            child: ListView(
                                              physics: const NeverScrollableScrollPhysics(),
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Container(
                                                    height: SizeConfig.screenHeight *
                                                        0.13,
                                                    child: ClipRRect(
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(7),
                                                        topRight: Radius.circular(7),
                                                      ),
                                                      child: AnotherCarousel(
                                                        images: const [
                                                          NetworkImage(
                                                              "https://media.istockphoto.com/id/1269776313/photo/suburban-house.jpg?s=1024x1024&w=is&k=20&c=xIwaYa1oKX9jnEnlsObNYDrljAkEsjOLlE66Eg2fDco="),
                                                          NetworkImage(
                                                              "https://media.istockphoto.com/id/507832549/photo/couple-standing-on-balcony-of-modern-house.jpg?s=2048x2048&w=is&k=20&c=7ooit4W_g24NDUGnLDWs9Dlh0F8T6dRbtX8RBBgQiuE="),
                                                          NetworkImage(
                                                              "https://media.istockphoto.com/id/1436217023/photo/exterior-of-a-blue-suburban-home.jpg?s=2048x2048&w=is&k=20&c=Z9Wc1NpUagwfdZbtHCyVEF9JnLXDIsPyIrw48-UXFb0="),
                                                          // we have display image from netwrok as well
                                                          NetworkImage(
                                                              "https://media.istockphoto.com/id/1132628728/photo/couple-in-front-of-residential-home-smiling.jpg?s=2048x2048&w=is&k=20&c=wqxgUhQQAqthoi-h80nHksGOhklcUywyrkCDwXPXxEc=")
                                                        ],
                                                        dotSize: 6,
                                                        dotSpacing: 10,
                                                        dotColor: Colors.white70,
                                                        dotIncreasedColor:
                                                        Colors.black45,
                                                        indicatorBgPadding: 5.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Container(
                                                  width: SizeConfig.screenWidth * 0.5,


                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [

                                                     // SizedBox(height: 7),
                                                      SizedBox(height: responsive.height(7),),        /// new changes

                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            ' HD Camera (black & white) dfgdf',
                                                            style: TextStyle(
                                                              fontFamily:
                                                              "Montserrat-Regular",
                                                              fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  3.7,
                                                              color:
                                                              CommonColor.Black,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),

                                                         // SizedBox(height: 3),
                                                          SizedBox(height: responsive.height(3),),        /// new changes

                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.location_on,
                                                                size: SizeConfig
                                                                    .screenHeight *
                                                                    0.019,
                                                                color: const Color(
                                                                    0xff3684F0),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  ' Park Street,pune banner 20023',
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                    "Montserrat-Regular",
                                                                    fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                        3.0,
                                                                    color: const Color(
                                                                        0xff3684F0),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                  ),
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                              ),

                                                            ],
                                                          ),

                                                         // SizedBox(height: 5),
                                                          SizedBox(height: responsive.height(5),),        /// new changes

                                                          Container(
                                                            height: 25,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: const Color(
                                                                  0xfff8e8e8),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  4),
                                                            ),
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                                children: [

                                                                  Text(
                                                                    '   Posted By:  ',
                                                                    style:
                                                                    TextStyle(
                                                                      fontFamily:
                                                                      "Montserrat-Regular",
                                                                      fontSize:
                                                                      SizeConfig.blockSizeHorizontal * 2.8,
                                                                      color:
                                                                      Colors.black87,
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                    ),
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                  ),
                                                                  Text(
                                                                    'Aaysha',
                                                                    style:
                                                                    TextStyle(
                                                                      fontFamily:
                                                                      "Montserrat-Regular",
                                                                      fontSize:
                                                                      SizeConfig.blockSizeHorizontal * 2.8,
                                                                      color:
                                                                      const Color(0xffC56262),
                                                                      fontWeight:
                                                                      FontWeight.w400,
                                                                    ),
                                                                    overflow:
                                                                    TextOverflow.ellipsis,
                                                                  ),

                                                                  //const SizedBox(width: 38),
                                                                  SizedBox(width: responsive.width(38)),                            /// new changes

                                                                  Container(
                                                                    width: SizeConfig.screenWidth *
                                                                        0.1,
                                                                    decoration: BoxDecoration(
                                                                        color: const Color(0xffffffff),
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            3)),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons.star,
                                                                          size: SizeConfig
                                                                              .screenHeight *
                                                                              0.016,
                                                                          color: const Color(0xffFFB905),
                                                                        ),
                                                                        Text(
                                                                          "  4.5",
                                                                          style: TextStyle(
                                                                            fontFamily:
                                                                            "Roboto-Regular",
                                                                            fontSize: SizeConfig
                                                                                .blockSizeHorizontal *
                                                                                2.5,
                                                                            color:
                                                                            CommonColor.Black,
                                                                            fontWeight:
                                                                            FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),

                                                          //SizedBox(height: 10),
                                                          SizedBox(height: responsive.height(10),),        /// new changes

                                                          Row(
                                                            children: [
                                                              // color: Color(0xff3684F0),

                                                              Text(
                                                                " Share",
                                                                style: TextStyle(
                                                                  color: CommonColor
                                                                      .grayText,
                                                                  fontFamily:
                                                                  "Roboto_Regular",
                                                                  fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                      3.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                ),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                              ),

                                                            //  SizedBox(width: 17),
                                                              SizedBox(width: responsive.width(17)),                            /// new changes

                                                              const Image(
                                                                  image: AssetImage(
                                                                      'assets/images/share.png'),
                                                                  height: 15),

                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),

                          const Text('Two'),

                        ],
                      ),
                    ),
                    //),
                    //Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );



  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Test Page !"),
      ),
    );
  }
}
