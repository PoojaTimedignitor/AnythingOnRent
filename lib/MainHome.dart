import 'package:anything/All_Product_List.dart';
import 'package:anything/CatagrioesList.dart';
import 'package:anything/MainScreen/login_screen.dart';
import 'package:anything/model/dio_client.dart';
import 'package:anything/pupularCatagoriesViewAll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'ConstantData/Constant_data.dart';
import 'Home_screens.dart';
import 'MyBehavior.dart';
import 'SearchCatagries.dart';
import 'SideBar/AppImprovment.dart';
import 'SideBar/My Collection.dart';
import 'SideBar/My Ratings.dart';
import 'SideBar/My Transaction History.dart';
import 'SideBar/MyFevorites.dart';
import 'SideBar/MyProfileDetails.dart';
import 'SideBar/chat.dart';
import 'addProductService.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import 'package:get_storage/get_storage.dart';



class MainHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainHomeState();
}

class MainHomeState extends State<MainHome>
    with SingleTickerProviderStateMixin {
  String? profileImage = GetStorage().read(ConstantData.UserProfileImage);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      firstname = GetStorage().read(ConstantData.UserFirstName) ?? "Guest";

      _tabController = TabController(length: 2, vsync: this);
    });
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _tabController.dispose();
    super.dispose();
  }

  late final String firstname;
  final _searchFocus = FocusNode();
  final searchController = TextEditingController();
  int currentIndex = 0;

  final box = GetStorage();

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
    "Sports Equipment"
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
    'assets/images/catone.png',
    'assets/images/catfour.png'
  ];

  void LogoutDialogBox(BuildContext context) {
    SizeConfig().init(context);
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text("Logout",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/images/logthree.png'),
                    height: SizeConfig.screenHeight * 0.07,
                  ),
                ),
              ),
              Container(
                height:
                    SizeConfig.screenHeight * 0.03, // Adjust height as needed

                child: Text(
                  " Are You Sure you want to Logout?",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat-Medium",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2, // Ensures text spans at most two lines
                  overflow:
                      TextOverflow.ellipsis, // Adds ellipsis if text overflows
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      String email =
                          GetStorage().read<String>(ConstantData.Useremail) ??
                              "";
                      String password = GetStorage()
                              .read<String>(ConstantData.Userpassword) ??
                          "";

                      final response =
                          await ApiClients().getLogoutUser(email, password);
                      if (response['success'] == true) {
                        print("Logout Successful");

                        // Remove user data from storage
                        GetStorage().remove(ConstantData.UserAccessToken);
                        GetStorage().remove(ConstantData.Useremail);
                        GetStorage().remove(ConstantData.Userpassword);


                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),

                          (route) => false,
                        );
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.white,

                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffFEBA69),
                              Color(0xffFE7F64),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                height: 2,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Medium',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      /* AppPreferences.clearAppPreference();
                      Get.to(() => const SignIn());*/
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.white,

                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffFEBA69),
                              Color(0xffFE7F64),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                height: 2,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Medium',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          title: Container(
            width: 300,
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, $firstname",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/location.png'),
                            height: SizeConfig.screenHeight * 0.017,
                            color: Color(0xff7993f3),
                          ),
                          Expanded(
                            child: Text(
                              " Park Street, Kolkata, 700021",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.4,
                                fontFamily: 'Poppins_Medium',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: Color(0xff7F96F0),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * .0),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.screenHeight * 0.0,
                    ),
                    child: Image(
                      image: AssetImage('assets/images/notification.png'),
                      height: SizeConfig.screenHeight * 0.025,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xffffffff),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
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
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.08, left: 23),
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
                                backgroundImage: (profileImage != null &&
                                        profileImage!.isNotEmpty)
                                    ? NetworkImage(
                                        profileImage!) // Display image from URL
                                    : AssetImage('assets/images/profiless.png')
                                        as ImageProvider,
                                // Profile image
                              ),
                            ),
                          ),

                          // Add some space between the avatar and the column
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hii, $firstname",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2),
                                // Adds space between the icon and text

                                GestureDetector(
                                  onTap: () {},
                                  child: Wrap(
                                    spacing: 4,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 3),
                                        child: const Image(
                                          image: AssetImage(
                                              'assets/images/location.png'),
                                          height: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        //  color: Colors.red,
                                        child: Text(
                                          "Park pashan pune, 2004 pune pashan... ",
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

            /*   Container(
              height: SizeConfig.screenHeight * 0.0003,
              width: 160,
              color: Colors.grey[500]!,
            ),*/
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Myprofiledetails()));
                    },
                    child: Wrap(
                      spacing: 13,
                      children: [
                        SizedBox(width: 03),
                        Image(
                          image: AssetImage('assets/images/userprofile.png'),
                          height: 22,
                          //color: CommonColor.gray,
                        ),
                        Text(
                            // the text of the row.
                            "My Profile",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.9,
                                fontFamily: "okra_Regular",
                                color: CommonColor.Black,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCollection()));
                    },
                    child: Wrap(
                      spacing: 13,
                      children: [
                        SizedBox(width: 01),
                        Image(
                          image: AssetImage('assets/images/myads.png'),
                          height: 22,
                        ),
                        Text(
                            // the text of the row.
                            "My Collection",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.9,
                                fontFamily: "okra_Regular",
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Myfevorites()));
                    },
                    child: Wrap(
                      spacing: 13,
                      children: [
                        SizedBox(width: 02),
                        Image(
                          image: AssetImage('assets/images/like.png'),
                          height: 20,
                          color: Colors.black54,
                        ),
                        Text(
                            // the text of the row.
                            "My Favorites",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.9,
                                fontFamily: "okra_Regular",
                                color: CommonColor.Black,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyTransaction()));
                    },
                    child: Wrap(
                      spacing: 10,
                      children: [
                        SizedBox(width: 0),
                        const Image(
                          image: AssetImage('assets/images/transaction.png'),
                          height: 27,
                        ),
                        Container(
                          width: 180,
                          //  color: Colors.red,
                          child: Text(
                              // the text of the row.
                              "My Transaction History",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.9,
                                  fontFamily: "okra_Regular",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyRatings()));
                    },
                    child: Wrap(
                      spacing: 11,
                      children: [
                        SizedBox(height: 10),
                        const Image(
                          image: AssetImage('assets/images/rating.png'),
                          height: 27,
                        ),
                        Container(
                          width: 108,
                          //  color: Colors.red,
                          child: Text(
                              // the text of the row.
                              "My Ratings",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.9,
                                  fontFamily: "okra_Regular",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => chat()));
                    },
                    child: Wrap(
                      spacing: 13,
                      children: [
                        SizedBox(width: 0),
                        const Image(
                          image: AssetImage('assets/images/chat.png'),
                          height: 20,
                        ),
                        Container(
                          width: 108,
                          //  color: Colors.red,
                          child: Text(
                              // the text of the row.
                              "Chat",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.9,
                                  fontFamily: "okra_Regular",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(width: 50),
                        Container(
                          height: 23,
                          width: 23,
                          decoration: BoxDecoration(
                            color: Color(0xffF8C5C2),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Center(
                            child: Text(
                              "12",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "okra_Medium",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AppImprov()));
                    },
                    child: Wrap(
                      spacing: 13,
                      children: [
                        SizedBox(width: 0),
                        const Image(
                          image: AssetImage('assets/images/chat.png'),
                          height: 20,
                        ),
                        Container(
                          width: 130,
                          //  color: Colors.red,
                          child: Text(
                              // the text of the row.
                              "App Improvement",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.9,
                                  fontFamily: "okra_Regular",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppImprov()));*/
                    },
                    child: Wrap(
                      spacing: 12,
                      children: [
                        SizedBox(width: 02),
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
                              "Help",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.9,
                                  fontFamily: "okra_Regular",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Myprofiledetails()));*/
                    },
                    child: Wrap(
                      spacing: 09,
                      children: [
                        SizedBox(width: 03),
                        const Image(
                          image: AssetImage('assets/images/setting.png'),
                          height: 20,
                        ),
                        Container(
                          width: 108,
                          //  color: Colors.red,
                          child: Text(
                              // the text of the row.
                              "Setting",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.9,
                                  fontFamily: "okra_Regular",
                                  color: CommonColor.Black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      LogoutDialogBox(context);
                    },
                    child: Expanded(
                      child: Row(
                        children: [
                          //  Spacer(),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Image(
                                    image:
                                        AssetImage('assets/images/logout.png'),
                                    height: 20,
                                    color: Colors.pink,
                                  ),
                                  Text(
                                    "    Logout    ",
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.9),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                elevation: 2,
                isScrollControlled: true,
                isDismissible: true,
                builder: (BuildContext bc) {
                  return CreateProductService();
                });
          },
          tooltip: 'Cool FAB',
          elevation: 009,
          child: Container(
            width: 56,
            height: 56,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffFE7F64), Color(0xffFE7F64)],
              ),
            ),
          ),
        ),
      ),

      /*  floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.8, 0.9],
              colors: [ Color(0xffFEBA69),
                Color(0xffFE7F64)],
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  context: context,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (BuildContext bc) {
                    return CreateProductService();
                  });
            },
            shape: CircleBorder(),
            foregroundColor: Color.fromARGB(200, 255, 255, 255),

            backgroundColor: Colors.transparent,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),*/

      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            /*  Container(
                height: SizeConfig.screenHeight * 0.17,
                child: Column(

                  children: [
                    getAddMainHeadingLayout(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                    HomeSearchBar(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ],
                )),*/
            Container(
              height: SizeConfig.screenHeight * 0.90,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  HomeSearchBar(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  sliderData(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  AddPostButton(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  PopularCategories(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
                    child: getAddGameTabLayout(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
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
      /*
      bottomNavigationBar:
      PersistentTabView(

        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,

        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75)
            )
          ],
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,

          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style9, // Choose the nav bar style with this property.
      ),*/
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecentSearchesScreen()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * .05,
                top: SizeConfig.screenHeight * 0.0),
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
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Image(
                          image: AssetImage("assets/images/search.png"),
                          height: SizeConfig.screenWidth * 0.07,
                        ),
                        Text(
                          " Search Product/Service",
                          style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            color: CommonColor.SearchBar,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
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
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            elevation: 2,
            isScrollControlled: true,
            isDismissible: true,
            builder: (BuildContext bc) {
              return CreateProductService();
            });
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
              fontFamily: "okra_Medium",
              fontSize: SizeConfig.blockSizeHorizontal * 3.1,
              color: Color(0xff3684F0),
              fontWeight: FontWeight.w200,
            ),
          )),
        ),
      ),
    );
  }

  Widget PopularCategories(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.01),
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
              GestureDetector(
                onTap: () {
                  /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchbarrr()));*/
                },
                child: Center(
                    child: Text(" POPULAR CATEGORIES",
                        style: TextStyle(
                            color: Colors.grey[500]!,
                            fontFamily: "okra_Regular",
                            fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.9),
                        overflow: TextOverflow.ellipsis)),
              ),
              SizedBox(
                width: 10,
              ),
              const Expanded(child: Divider()),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: parentWidth * 0.03),
            child: SizedBox(
              height: 200, // Set a fixed height for the GridView
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                physics:
                    NeverScrollableScrollPhysics(), // Enable horizontal scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of rows
                  crossAxisSpacing: 1, // Space between columns
                  mainAxisSpacing: 10, // Space between rows
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
                            fontFamily: "okra_Normal",
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            fontWeight: FontWeight.w400,
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Container(
                              height: SizeConfig.screenHeight,
                              child: CatagriesList()))));
            },
            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.72, top: 10),
              child: Container(
                height: parentHeight * 0.03,
                width: parentWidth * 0.22,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff3684F0), width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      " More",
                      style: TextStyle(
                        fontFamily: "okra_Medium",
                        fontSize: SizeConfig.blockSizeHorizontal * 3.1,
                        color: Color(0xff3684F0),
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Image(
                      image: AssetImage('assets/images/arrow.png'),
                      height: 20,
                      width: 15,
                      color: Color(0xff3684F0),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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
      padding: EdgeInsets.only(top: parentHeight * 0.02),
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
          SizedBox(
            height: 25,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffFEBA69),
                              Color(0xffFE7F64),
                            ],
                          )),
                      buttonMargin: EdgeInsets.symmetric(horizontal: 18),
                      unselectedDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      unselectedBorderColor: Color(0xffFE7F64),
                      physics: NeverScrollableScrollPhysics(),
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          child: Container(
                            height: 40,
                            width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Product",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto-Medium",
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 40,
                            width: 165,
                            padding: EdgeInsets.only(left: 28, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  20), /* border: Border.all(color: Colors.black, width: 0.5)*/
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                  child: Text(
                                "Service",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto-Medium",
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    //child: Container(
                    height: SizeConfig.screenHeight * 0.90,
                    //color: Colors.blue,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "  Near by Location",
                                  style:  TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Montserrat-Medium",
                                    fontSize: 15,
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
                              "   Near by place",
                              style: TextStyle(
                                color: CommonColor.grayText,
                                fontFamily: "Montserrat-Medium",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
                                      color: CommonColor.white,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),

                                  // alignment: Alignment.center,

                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height:
                                                SizeConfig.screenHeight * 0.2,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(Radius.circular(10)
                                              ),
                                              child: AnotherCarousel(
                                                images: const [
                                                  NetworkImage(
                                                      "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg"),
                                                  NetworkImage(
                                                      "https://pune.accordequips.com/images/products/15ccb1ae241836.png"),
                                                  NetworkImage(
                                                      "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg"),
                                                  NetworkImage(
                                                      "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg"),
                                                  NetworkImage(
                                                      "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg")

                                                ],
                                                autoplay:false,
                                                dotSize: 6,
                                                dotSpacing: 10,
                                                dotColor: Colors.white70,
                                               // overlayShadow: false,

                                                dotIncreasedColor:
                                                    Colors.black45,
                                                indicatorBgPadding: 3.0,
                                              ),
                                            ),
                                          ),


                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: parentHeight*0.125),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  height: parentHeight*0.055,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(0.3),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        0),
                                                  ),
                                                  child: Padding(
                                                    padding:  EdgeInsets.only(left: 8,right: 10,top: 2),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'HD Camera (black & white) dfgdf',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "okra_Medium",
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Padding(
                                                          padding:  EdgeInsets.only(top: 2),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.location_on,
                                                                size:
                                                                SizeConfig.screenHeight *
                                                                    0.019,
                                                                color: Color(0xffffffff).withOpacity(0.8),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  ' Park Street,pune banner 20023',
                                                                  style: TextStyle(
                                                                    color: Colors.white.withOpacity(0.8),
                                                                    fontFamily: "Montserrat-Medium",
                                                                    fontSize: 11,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0, left: 110),
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Container(
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff5095f1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
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

                                        ],
                                      ),
                                    /*  SizedBox(height: 4),
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
                                                  size:
                                                      SizeConfig.screenHeight *
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
                                         */
                                      /*   SizedBox(height: 5),
                                            Row(
                                              children: [
                                                // color: Color(0xff3684F0),

                                                Text(
                                                  " Share",
                                                  style: TextStyle(
                                                    color: CommonColor.grayText,
                                                    fontFamily:
                                                        "Roboto_Regular",
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        2.7,
                                                    fontWeight: FontWeight.w500,
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
                                            ),*/
                                      /*
                                          ],
                                        ),
                                      ),*/
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
                                        left: parentWidth * 0.38),
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
                            Padding(
                              padding:  EdgeInsets.only(top: 3,left: 10),
                              child: Container(
                                width: 350,
                                child: Text(
                                  "Display All rental product options in your choose location",
                                  style: TextStyle(
                                    color: CommonColor.grayText,
                                    fontFamily: "Montserrat-Medium",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,  // Limit to 2 lines
                                  overflow: TextOverflow.ellipsis,  // Add ellipsis if text overflows
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10, // Define the number of items
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: parentWidth * 0.55,

                                        // Set width for each item
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              color: CommonColor.grayText,
                                              width: 0.3),

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
                                                        0.16,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(7),
                                                    topRight:
                                                        Radius.circular(7),
                                                  ),
                                                  child: AnotherCarousel(
                                                    images: const [
                                                      NetworkImage(
                                                          "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg"),
                                                      NetworkImage(
                                                          "https://pune.accordequips.com/images/products/15ccb1ae241836.png"),
                                                      NetworkImage(
                                                          "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg"),
                                                      NetworkImage(
                                                          "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg"),
                                                      NetworkImage(
                                                          "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg")

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
                                              width:
                                                  SizeConfig.screenWidth * 0.5,
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
                                                    /*  SizedBox(height: 5),
                                                      Container(
                                                        height: 25,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xfff8e8e8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
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
                                                                      SizeConfig
                                                                              .blockSizeHorizontal *
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
                                                                      SizeConfig
                                                                              .blockSizeHorizontal *
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
                                                            "  Share",
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
                                                      ),*/
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
