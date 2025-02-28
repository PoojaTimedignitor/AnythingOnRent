import 'package:anything/All_Product_List.dart';
import 'package:anything/pupularCatagoriesViewAll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

import 'addProductService.dart';
import 'dummy.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class BottomBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar>
    with SingleTickerProviderStateMixin {
  PersistentTabController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _tabController = TabController(length: 2, vsync: this);
      _controller = PersistentTabController(initialIndex: 0);
    });
  }

  List<Widget> _buildScreens() {
    return [
      BottomBar(),
      AllProductList(),
      AllProductList(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.electric_moped),
        title: ("Home"),
        activeColorPrimary: Color(0xffC291EE),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dining_outlined),
        title: ("Fev"),
        activeColorPrimary: Color(0xffC291EE),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.wallet),
        title: ("Chat"),
        activeColorPrimary: Color(0xffC291EE),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void dispose() {
    _controller?.dispose();
    _searchFocus.dispose();
    _tabController.dispose();
    super.dispose();
  }

  final _searchFocus = FocusNode();
  final searchController = TextEditingController();
  int currentIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
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
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  elevation: 10,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (BuildContext bc) {
                    return CreateProductService();
                  });
            },
            shape: CircleBorder(),
            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body:

          /*  ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
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
                  */ /* Stack(
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
                  ),*/ /*
                ],
              ),
            ),
          ],
        ),
      ),*/

          PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,

        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75))
          ],
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,

          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style9, // Choose the nav bar style with this property.
      ),
    );
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {},
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
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
            "Create Post +",
            style: TextStyle(
              fontFamily: "okra_regular",
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
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: Divider()),
            SizedBox(
              width: 10,
            ),
            Center(
                child: Text(" POPULAR CATEGORIES",
                    style: TextStyle(
                        color: Colors.grey[500]!,
                        fontFamily: "okra_Regular",
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.9),
                    overflow: TextOverflow.ellipsis)),
            SizedBox(
              width: 10,
            ),
            const Expanded(child: Divider()),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: parentWidth * 0.02),
          child: SizedBox(
            height: 200,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 23,
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
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.00),
                        child: Image.asset(
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
                        ),
                        overflow: TextOverflow.ellipsis,
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
              )*/ /*
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
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.04),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: Divider()),
              SizedBox(
                width: 10,
              ),
              Center(
                  child: Text("WHAT'S ON YOUR RENTAL MATERIALS?",
                      style: TextStyle(
                          color: Colors.grey[500]!,
                          fontFamily: "okra_Regular",
                          fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.9),
                      overflow: TextOverflow.ellipsis)),
              SizedBox(
                width: 10,
              ),
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
                    padding: EdgeInsets.only(left: 0, bottom: 20, right: 0),
                    child: ButtonsTabBar(
                      backgroundColor: CommonColor.ViewAll,
                      buttonMargin: EdgeInsets.symmetric(horizontal: 25),
                      unselectedBackgroundColor: Colors.grey[200],
                      physics: NeverScrollableScrollPhysics(),
                      unselectedLabelStyle: TextStyle(color: Colors.black),
                      // center:true,
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),

                      tabs: [
                        Tab(
                          child: Container(
                            height: 40,
                            width: 150,
                            padding: EdgeInsets.only(left: 10, right: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
                                    letterSpacing: 0.5,
                                    fontFamily: "okra_medium",
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.5,
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
                            padding: EdgeInsets.only(left: 10, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), /* border: Border.all(color: Colors.black, width: 0.5)*/
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                  child: Row(
                                children: [
                                  Image(
                                      image: AssetImage(
                                          'assets/images/service.png'),
                                      height: 72,
                                      width: 50),
                                  Text(
                                    "Service",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                      fontFamily: "okra_medium",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    //child: Container(
                    height: SizeConfig.screenHeight * 0.9,
                    //color: Colors.blue,
                    child: TabBarView(
                      children: [
                        Flexible(
                          child: Column(
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
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.35),
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
                                                  fontFamily:
                                                      "Montserrat-Regular",
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
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                  color: CommonColor.grayText,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              GridView.builder(
                                padding: EdgeInsets.only(top: 15),
                                physics:
                                    NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                                shrinkWrap:
                                    true, // Take only the space it needs
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
                                        /*       border: Border.all(
                                              color: Colors.black38, width: 0.9),*/
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),

                                    // alignment: Alignment.center,

                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height:
                                                  SizeConfig.screenHeight * 0.1,
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
                                            Container(
                                              //  border: Border.all(color: CommonColor.bottomsheet, width: 0.2),

                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 67, left: 111),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Container(
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff5095f1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                      ),
                                                      child: Row(
                                                          // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              size: SizeConfig
                                                                      .screenHeight *
                                                                  0.019,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              '1.2 Km   ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat-Regular",
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    2.5,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ]),
                                                    ),
                                                  )),
                                            ),
                                            Padding(
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
                                                            color: CommonColor
                                                                .white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ]),
                                                ))
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
                                                  fontFamily:
                                                      "Montserrat-Regular",
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
                                                    size: SizeConfig
                                                            .screenHeight *
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
                                                        color:
                                                            Color(0xff3684F0),
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                      color:
                                                          CommonColor.grayText,
                                                      fontFamily:
                                                          "Roboto_Regular",
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2.7,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 6),
                                                  Image(
                                                      image: AssetImage(
                                                          'assets/images/share.png'),
                                                      height: 13),
                                                  SizedBox(width: 71),
                                                  Container(
                                                    width:
                                                        SizeConfig.screenWidth *
                                                            0.1,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffffffff),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: SizeConfig
                                                                  .screenHeight *
                                                              0.016,
                                                          color:
                                                              Color(0xffFFB905),
                                                        ),
                                                        Text(
                                                          "  4.5",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Roboto-Regular",
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                2.5,
                                                            color: CommonColor
                                                                .Black,
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
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.35),
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
                                                  fontFamily:
                                                      "Montserrat-Regular",
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
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.3,
                                  color: CommonColor.grayText,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 10,
                                  // color: Colors.red,
                                  padding: EdgeInsets.only(top: 15.0),
                                  // Set height to fit the horizontal list
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          10, // Define the number of items
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: parentWidth * 0.55,

                                          // Set width for each item
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 9.0),
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
                                                  color: Color(0xff000000)
                                                      .withOpacity(0.2),
                                                  blurRadius: 2,
                                                  spreadRadius: 0,
                                                  offset: Offset(0, 1)),
                                            ],
                                          ),
                                          child: ListView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.13,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(7),
                                                      topRight:
                                                          Radius.circular(7),
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
                                                width: SizeConfig.screenWidth *
                                                    0.5,
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
                                                                3.7,
                                                            color: CommonColor
                                                                .Black,
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
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Montserrat-Regular",
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          3.0,
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
                                                                        SizeConfig.blockSizeHorizontal *
                                                                            2.8,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  'Aaysha',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat-Regular",
                                                                    fontSize:
                                                                        SizeConfig.blockSizeHorizontal *
                                                                            2.8,
                                                                    color: Color(
                                                                        0xffC56262),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                SizedBox(
                                                                    width: 38),
                                                                Container(
                                                                  width: SizeConfig
                                                                          .screenWidth *
                                                                      0.1,
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xffffffff),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3)),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        size: SizeConfig.screenHeight *
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
                                                                              SizeConfig.blockSizeHorizontal * 2.5,
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
                        Text('Two'),
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
}




/*ListView(
children: [
SizedBox(height: 25),
Center(
child: Text(
"FOLLOW US ON SOCIAL MEDIA",
style: TextStyle(
color: Color(0xff3d87f1),
fontFamily: "okra_Medium",
fontSize: 15,
letterSpacing: 0.9,
fontWeight: FontWeight.w600,
),
),
),
SizedBox(height: 25),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
GestureDetector(
onTap: () =>
launchURL("https://www.facebook.com/yourprofile"),
child: Image(
image: AssetImage('assets/images/facebook.png'),
height: parentHeight * 0.047,
),
),
SizedBox(width: 10),
GestureDetector(
onTap: () =>
launchURL("https://www.youtube.com/yourchannel"),
child: Image(
image: AssetImage('assets/images/youtub.png'),
height: parentHeight * 0.047,
),
),
SizedBox(width:10),
GestureDetector(
onTap: () =>
launchURL("https://www.instagram.com/yourprofile"),
child: Image(
image: AssetImage('assets/images/insta.png'),
height: parentHeight * 0.047,
),
),
SizedBox(width: 10),
GestureDetector(
onTap: () => launchURL(
"https://www.linkedin.com/in/yourprofile"),
child: Image(
image: AssetImage('assets/images/linkedIn.png'),
height: parentHeight * 0.045,
),
),
],
),
],
),*/
