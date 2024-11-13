import 'package:anything/All_Product_List.dart';
import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_widget.dart';
import 'package:anything/pupularCatagoriesViewAll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

import 'bottomNavigationBar.dart';
import 'Common_File/common_color.dart';
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
      menuBackgroundColor: Color(0xFFFEDEDE),
      mainScreen: const Body(),
      // moveMenuScreen: false,
      menuScreen: Scaffold(
        backgroundColor: Color(0xFFFEDEDE),
        body: ListView(
          //shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          //crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/profile.png"),
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          z.stateNotifier?.addListener(() {
            print("========> State: ${z.stateNotifier?.value}");
          });
          controller.fling(velocity: isPanelVisible ? -18.0 : 1.0);
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.close_menu,
          progress: controller.view,
        ),
      ),*/
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
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
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
              children: [
                sliderData(SizeConfig.screenHeight, SizeConfig.screenWidth),
                AddPostButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
                PopularCategories(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.16),
                  child: Container(
                    height: SizeConfig.screenHeight * 0.99,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.8, 0.9],
              colors: [Color(0xffC291EE), Color(0xff8E55C1)],
            ),
          ),
          child: FloatingActionButton(
            shape: CircleBorder(),
            heroTag: GestureDetector(
              onTap: () {},
            ),
            onPressed: _incrementCounter,
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                20, // Adjust bottom padding when keyboard is open
          ),
          child: BottomNavyBar(
            showInactiveTitle: true,
            backgroundColor: Color(0xffBFCCFC),
            selectedIndex: _currentIndex,
            showElevation: true,
            itemPadding: EdgeInsets.symmetric(horizontal: 0),
            itemCornerRadius: 24,
            iconSize: 20,
            curve: Curves.easeIn,
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
        ),
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
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
                image: AssetImage('assets/images/sidebar.png'),
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
            SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.03),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/location.png'),
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
              image: AssetImage('assets/images/notification.png'),
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
                              image: AssetImage("assets/images/search.png"),
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
                        fillColor: Color(0xfffbf3f3),
                        hoverColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1),
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
                  : NetworkImage("");

              return Container(
                  margin: EdgeInsets.all(16),
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
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
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
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
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
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ImageSliders(

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
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
            "Create Post +",
            style: TextStyle(
              fontFamily: "Roboto_Medium",
              fontSize: SizeConfig.blockSizeHorizontal * 3.1,
              color: Color(0xff3684F0),
              fontWeight: FontWeight.w300,
            ),
          )),
        ),
      ),
    );
  }

  Widget PopularCategories(double parentHeight, double parentWidth) {
    return Padding(
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
              )*/
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
    );
  }

  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.01,
            right: parentWidth * 0.02,
            left: parentWidth * 0.02),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          // give the tab bar a height [can change hheight to preferred height]
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                // color: Color(0xffDDE4FD),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CommonColor.bottomsheet, width: 0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,

                  //labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                  indicator: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/tab.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.green.shade800,
                  tabs: [
                    Tab(
                      child: Container(
                        width: 160,
                        child: Center(
                            child: Row(
                          children: [
                            Image(
                                image: AssetImage('assets/images/pro.png'),
                                height: 72,
                                width: 50),
                            Text(
                              "Product",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 150,
                        child: Center(
                            child: Row(
                          children: [
                            Image(
                                image: AssetImage('assets/images/service.png'),
                                height: 72,
                                width: 80),
                            Text(
                              "Service",
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // tab bar view here
          Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.01),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffEBEFFF),
                        borderRadius: BorderRadius.circular(10),
                        //  border: Border.all(color: CommonColor.bottomsheet, width: 0.2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        /*   physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,*/
                        children: [
                          SizedBox(height: 10),
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
                                              PopularCatagoriesData()));
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: parentWidth * 0.35),
                                  child: Container(
                                    height: parentHeight * 0.035,
                                    width: parentWidth * 0.22,
                                    decoration: BoxDecoration(
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
                                        Image(
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
                            padding: EdgeInsets.only(top: 15),
                            physics:
                                NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                            shrinkWrap: true, // Take only the space it needs
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  2, // Number of columns in the grid
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 1.0, // Adjust as needed
                            ),
                            itemCount: 4, // Number of items in the grid
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 10.0,
                                    right: 5.0,
                                    top: 0.0,
                                    bottom: 30.0),
                                //  height: SizeConfig.screenHeight * 0,
                                decoration: BoxDecoration(
                                    color: CommonColor.redContainer,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xff000000)
                                              .withOpacity(0.2),
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                          offset: Offset(0, 1)),
                                    ],
                                    /*  border: Border.all(
                                            color: Colors.black38, width: 0.9),*/
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),

                                // alignment: Alignment.center,

                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: SizeConfig.screenHeight * 0.1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
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
                                              padding: EdgeInsets.only(
                                                  top: 67, left: 111),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff5095f1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
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
                                        /*Padding(
                                            padding: EdgeInsets.only(
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
                                                          Color(0xffFFB905),
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
                                            ))*/
                                      ],
                                    ),
                                    SizedBox(height: 4),
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
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: SizeConfig.screenHeight *
                                                    0.019,
                                                color: Color(0xff3684F0),
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
                                                    color: Color(0xff3684F0),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
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
                                              SizedBox(width: 6),
                                              Image(
                                                  image: AssetImage(
                                                      'assets/images/share.png'),
                                                  height: 13),
                                              SizedBox(width: 71),
                                              Container(
                                                width: SizeConfig.screenWidth *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffffffff),
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
                                                      color: Color(0xffFFB905),
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
                                              AllProductList()));
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: parentWidth * 0.35),
                                  child: Container(
                                    height: parentHeight * 0.035,
                                    width: parentWidth * 0.22,
                                    decoration: BoxDecoration(
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
                                        Image(
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
                              padding: EdgeInsets.only(top: 15.0, bottom: 16.0),
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
                                          EdgeInsets.symmetric(horizontal: 9.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
    borderRadius:
        BorderRadius.circular(7),
                                        border: Border.all(
                                            color: CommonColor.grayText,
                                            width: 0.3),
                                        //  color: Color(0xffFFE5E3),
                                        //  borderRadius:
                                        /*     BorderRadius.circular(12.0),
                                       */ /* boxShadow: [
                                          BoxShadow(
                                              color: Color(0xff000000)
                                                  .withOpacity(0.2),
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                              offset: Offset(0, 1)),
                                        ],*/
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              height: SizeConfig.screenHeight *
                                                  0.13,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
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
                                                SizedBox(height: 7),
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
                                                            3.3,
                                                        color:
                                                            CommonColor.Black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    SizedBox(height: 3),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: SizeConfig
                                                                  .screenHeight *
                                                              0.019,
                                                          color: Color(
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
                                                                  3.1,
                                                              color: Color(
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
                                                    SizedBox(height: 5),
                                                    Container(
                                                      height: 25,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: Color(
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
                                                                Color(0xffC56262),
                                                                fontWeight:
                                                                FontWeight.w400,
                                                              ),
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                            ),
SizedBox(width: 10),
                                                            Icon(
                                                              Icons.star,
                                                              size: SizeConfig
                                                                  .screenHeight *
                                                                  0.016,
                                                              color: Color(
                                                                  0xffFFB905),
                                                            ),
                                                            Text(
                                                              " 4.5",
                                                              style:
                                                              TextStyle(
                                                                fontFamily:
                                                                "Roboto-Regular",
                                                                fontSize:
                                                                SizeConfig.blockSizeHorizontal *
                                                                    2.8,
                                                                color: CommonColor
                                                                    .Black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w400,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 40,
                                                              child: Text(
                                                                " (150 Reviews)",
                                                                style:
                                                                TextStyle(
                                                                  fontFamily:
                                                                  "Roboto-Regular",
                                                                  fontSize:
                                                                  SizeConfig.blockSizeHorizontal *
                                                                      2.8,
                                                                  color: CommonColor
                                                                      .Black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                ),overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                    SizedBox(height: 10),
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
                                                        SizedBox(width: 17),
                                                        Image(
                                                            image: AssetImage(
                                                                'assets/images/share.png'),
                                                            height: 15),
                                                     /*   SizedBox(width: 85),
                                                        Container(
                                                          width: SizeConfig
                                                                  .screenWidth *
                                                              0.1,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffFFE5E3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3)),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                size: SizeConfig
                                                                        .screenHeight *
                                                                    0.016,
                                                                color: Color(
                                                                    0xffFFB905),
                                                              ),
                                                              Text(
                                                                "  4.5",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Roboto-Regular",
                                                                  fontSize:
                                                                      SizeConfig.blockSizeHorizontal *
                                                                          2.5,
                                                                  color: CommonColor
                                                                      .Black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),*/
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

                    // first tab bar view widget

                    // second tab bar view widget
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 3);
                          },
                          //scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          padding: const EdgeInsets.only(bottom: 20, top: 5),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 24.0),
                              child: Container(
                                height: parentHeight * 0.23,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade50,
                                      offset: const Offset(-5, 0),
                                    ),
                                    BoxShadow(
                                      color: Colors.grey.shade50,
                                      offset: const Offset(5, 0),
                                    )
                                  ],
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.01),
                                      child: Container(
                                          height: parentHeight * 0.17,
                                          width: parentWidth * 0.30,
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/logo.png"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: parentHeight * 0.01),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentWidth * 0.05,
                                                    top: parentHeight * 0.03),
                                                child: Text("Masjit Name",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.3,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: CommonColor.Black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight * 0.03,
                                                    left: parentWidth * 0.04,
                                                    right: parentWidth * 0.0),
                                                child: Container(
                                                    height: parentHeight * 0.04,
                                                    width: parentHeight * 0.12,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                          colors: [
                                                            CommonColor.Black,
                                                            CommonColor.Black
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "JOIN",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto_Regular",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                4.3,
                                                            color: CommonColor
                                                                .bottomsheet),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentHeight * 0.02,
                                                    top: parentHeight * 0.002),
                                                child: Text("Location :",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: CommonColor.Black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentHeight * 0.02,
                                                    top: parentHeight * 0.01),
                                                child: Text("FAZAR",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: CommonColor.Black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentHeight * 0.0,
                                                    top: parentHeight * 0.01),
                                                child: Text("AZAN :",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: CommonColor.Black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentWidth * 0.02,
                                                    top: parentHeight * 0.01),
                                                child: Text("05:30",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CommonColor.Black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentHeight * 0.01,
                                                    top: parentHeight * 0.01),
                                                child: Text("JAMA'AT :",
                                                    style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: CommonColor.Black,
                                                    )),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentWidth * 0.0,
                                                    top: parentHeight * 0.01),
                                                child: Text(
                                                  "05:30",
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4.0,
                                                      fontFamily: 'Roboto_Bold',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: CommonColor.Black),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ))
        ]));
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
      body: Center(
        child: Text("Test Page !"),
      ),
    );
  }
}
