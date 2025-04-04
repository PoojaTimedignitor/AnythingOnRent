import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Admin/UserFeedback.dart';
import 'Admin/helpCentre.dart';
import 'Admin/vedio_player.dart';

import 'Cat_Product_Service.dart';
import 'ProductSeparateCat.dart';
import 'Common_File/ResponsiveUtil.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'ConstantData/Constant_data.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:carousel_slider/carousel_slider.dart';
import 'ResponseModule/getAllCatList.dart';

import 'MyBehavior.dart';
import 'NewDioClient.dart';
import 'ProductConfirmation.dart';
import 'ResponseModule/BusniessAdsResponseModel.dart';
import 'package:anything/ResponseModule/getAllCatList.dart' as custom;
import 'package:another_carousel_pro/another_carousel_pro.dart';

import 'ResponseModule/getAllProductList.dart';
import 'SearchCatagries.dart';
import 'SideBar/My Collection.dart';
import 'SideBar/My Ratings.dart';
import 'SideBar/My Transaction History.dart';
import 'SideBar/MyFevorites.dart';
import 'SideBar/MyProfileDetails.dart';
import 'SideBar/chat.dart';
import 'createService.dart';
import 'location_map.dart';
import 'mm.dart';
import 'model/dio_client.dart';

class ChangeHome extends StatefulWidget {
  const ChangeHome({super.key});

  @override
  State<ChangeHome> createState() => _ChangeHomeState();
}

class _ChangeHomeState extends State<ChangeHome> with TickerProviderStateMixin {
  String? profileImage = GetStorage().read(ConstantData.UserProfileImage);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();
  List<String> adsUrlsList = [];
  List<Products> filteredItemss = [];
  int currentIndex = 0;
  int selectedIndex = 0;
  String updatedCity = "No city selected";
  String text = "Create Post +";
  List<custom.Data> filteredItems = [];
  List<custom.Data> items = [];
  // List<Data> filteredItems = [];
  bool isLoading = true;
  late AnimationController _controllerss;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  late AnimationController _scaleController;
  bool _isVisible = true;
  late Animation<double> _animation;

  final List<String> images = [
    'https://img.freepik.com/free-psd/shoes-sale-social-media-post-square-banner-template-design_505751-2862.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-vector/black-friday-sale-social-media-post-banner-home-appliance-product-instagram-post-banner-design_755018-930.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/drink-ad-nature-pear-juice_52683-34246.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-psd/ironing-machine-brand-product-social-media-banner_154386-123.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/sports-drink-advertisement_52683-430.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
  ];

  final List<String> catagriesImage = [
    'assets/images/fashion.png',
    'assets/images/furniture.png',
    'assets/images/vehicle.png',
    'assets/images/electronics.png',
    'assets/images/cosmatics.png',
    'assets/images/stationery.png',
    'assets/images/books.png',
    'assets/images/sports.png',
  ];

  final ApiClients authService = ApiClients();
  BoxDecoration _backgroundDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage("assets/images/estione.png"),
      fit: BoxFit.cover,
    ),
  );

  void _changeBackground(int index) {
    setState(() {
      _backgroundDecoration = BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            index == 0
                ? "assets/images/estione.png"
                : "assets/images/servicess.jpg",
          ),
          fit: BoxFit.cover,
        ),
      );
    });
  }

  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await NewApiClients().NewGetAllCat();
      var jsonList = GetAllCategoriesList.fromJson(response);
      setState(() {
        items = jsonList.data ?? [];

        filteredItems = List.from(items);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching categories: $e");
    }
  }

  @override
  void initState() {
    fetchBusinessAds();
    fetchCategories();
    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerss, curve: Curves.easeOutBack),
    );

    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      upperBound: 2.0,
    );

    _controllerss.repeat().whenComplete(() {
      setState(() {
        _isVisible = false;
      });
    });
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    super.initState();
  }

  void fetchBusinessAds() async {
    try {
      Map<String, dynamic> response = await ApiClients().fetchBusinessAdssss();

      AdminBusinessAdsResponseModel businessAdsResponse =
          AdminBusinessAdsResponseModel.fromJson(response);

      List<String>? adsUrls = businessAdsResponse.urls;

      setState(() {
        isLoading = false;
        adsUrlsList = adsUrls ?? [];
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching business ads: $e");
    }
  }

  @override
  void dispose() {
    _controllerss.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          backgroundColor: Color(0xffffffff),
          child: Column(
            children: <Widget>[
              Container(
                height: ResponsiveUtil.height(180),
                color: const Color(0xfff1f2fd),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: ResponsiveUtil.width(108),
                        height: ResponsiveUtil.height(120),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100)),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: ResponsiveUtil.width(85),
                        height: ResponsiveUtil.height(95),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(100)),
                          color: Color(0xfff1f2fd),
                        ),
                      ),
                    ),
                    Positioned(
                      top: ResponsiveUtil.height(40),
                      right: ResponsiveUtil.width(20),
                      child: Container(
                        width: ResponsiveUtil.width(33),
                        height: ResponsiveUtil.width(33),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xffe4b4fb),
                              Color(0xfffddfdf),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.settings,
                              size: 18, color: Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Myprofiledetails(
                                    option: () {},
                                  )),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveUtil.height(80),
                          left: ResponsiveUtil.width(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: ResponsiveUtil.width(29),
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: ResponsiveUtil.width(25),
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: profileImage != null &&
                                            profileImage!.isNotEmpty
                                        ? NetworkImage(profileImage!)
                                        : const AssetImage(
                                                'assets/images/profiless.png')
                                            as ImageProvider,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(ResponsiveUtil.width(4)),
                                    child: Image.asset(
                                        'assets/images/pro_edit.png',
                                        height: ResponsiveUtil.width(16)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: ResponsiveUtil.width(10)),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ResponsiveUtil.height(10),
                                  left: ResponsiveUtil.width(3)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: ResponsiveUtil.width(150),
                                    child: Text(
                                      "Hii, Aayshaaaaaaaa",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "okra_Medium",
                                        fontSize: ResponsiveUtil.fontSize(15),
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/location.png'),
                                        height: 13,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(width: 4),
                                      SizedBox(
                                        width: ResponsiveUtil.width(190),
                                        child: Text(
                                          "Opposite Sassoon Hospital, Station Road, Pune-411001",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveUtil.fontSize(13),
                                            fontFamily: 'Montserrat_Medium',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
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
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  "Manage Posts",
                                  /*style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.93,
                                      fontFamily: "okra_Regular",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400)*/

                                  style: TextStyle(
                                    color: Color(0xff2B2B2B),
                                    fontFamily: "okra_Medium",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddToCart()));
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
                                  /* style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.9,
                                      fontFamily: "okra_Regular",
                                      color: CommonColor.Black,
                                      fontWeight: FontWeight.w400)*/
                                  style: TextStyle(
                                    color: Color(0xff2B2B2B),
                                    fontFamily: "okra_Medium",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
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
                                  image: AssetImage(
                                      'assets/images/transaction.png'),
                                  height: 27,
                                ),
                                Container(
                                  width: 180,
                                  //  color: Colors.red,
                                  child: Text(
                                      // the text of the row.
                                      "Contacted History",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
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
                                  image: AssetImage(
                                      'assets/images/transaction.png'),
                                  height: 27,
                                ),
                                Container(
                                  width: 180,
                                  //  color: Colors.red,
                                  child: Text(
                                      // the text of the row.
                                      "Users Contacted",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyRatings()));
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
                                  child: Text("My Ratings",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: Container(
                              height: 0.4,
                              // width:  0.95,
                              color: CommonColor.bottomsheet,
                            ),
                          ),
                          SizedBox(height: 3),
                          Center(
                            child: Container(
                              height: 0.4,
                              // width:  0.95,
                              color: CommonColor.bottomsheet,
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chat()));
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
                                  // width: 125,
                                  //  color: Colors.red,
                                  child: Text(
                                      // the text of the row.
                                      "Subscription History",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(width: 50),
                                /* Container(
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
                              )*/
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
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
                                  child: Text("Due for renewal",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HelpCenterScreen()));
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
                                  // width: 108,
                                  //  color: Colors.red,
                                  child: Text("Help & Support",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  context: context,
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  builder: (BuildContext bc) {
                                    return Userfeedback();
                                  });

                              /*   Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AppImprov()));*/
                            },
                            child: Wrap(
                              spacing: 09,
                              children: [
                                SizedBox(width: 03),
                                const Image(
                                  image:
                                      AssetImage('assets/images/setting.png'),
                                  height: 20,
                                ),
                                Container(
                                  width: 108,
                                  child: Text("FeedBack",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductConfigurations()));
                            },
                            child: Wrap(
                              spacing: 09,
                              children: [
                                SizedBox(width: 03),
                                const Image(
                                  image:
                                      AssetImage('assets/images/setting.png'),
                                  height: 20,
                                ),
                                Container(
                                  // width: 108,
                                  //  color: Colors.red,
                                  child: Text("Report & Suggestions",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: Container(
                              height: 0.4,
                              // width:  0.95,
                              color: CommonColor.bottomsheet,
                            ),
                          ),
                          SizedBox(height: 3),
                          Center(
                            child: Container(
                              height: 0.4,
                              // width:  0.95,
                              color: CommonColor.bottomsheet,
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductConfigurations()));
                            },
                            child: Wrap(
                              spacing: 09,
                              children: [
                                SizedBox(width: 03),
                                const Image(
                                  image:
                                      AssetImage('assets/images/setting.png'),
                                  height: 20,
                                ),
                                Container(
                                  // width: 108,
                                  //  color: Colors.red,
                                  child: Text("About Us",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductConfigurations()));
                            },
                            child: Wrap(
                              spacing: 09,
                              children: [
                                SizedBox(width: 03),
                                const Image(
                                  image:
                                      AssetImage('assets/images/setting.png'),
                                  height: 20,
                                ),
                                Container(
                                  // width: 108,
                                  //  color: Colors.red,
                                  child: Text(
                                      // the text of the row.
                                      "Rate Us",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductConfigurations()));
                            },
                            child: Wrap(
                              spacing: 09,
                              children: [
                                SizedBox(width: 03),
                                const Image(
                                  image:
                                      AssetImage('assets/images/setting.png'),
                                  height: 20,
                                ),
                                Container(
                                  // width: 108,
                                  //  color: Colors.red,
                                  child: Text(
                                      // the text of the row.
                                      "Follow Us",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chat()));
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
                                  // width: 125,
                                  //  color: Colors.red,
                                  child: Text(
                                      // the text of the row.
                                      "Share App",
                                      style: TextStyle(
                                        color: Color(0xff2B2B2B),
                                        fontFamily: "okra_Medium",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Container(
                                  height: 23,
                                  width: 23,
                                  child: Center(
                                      child: Icon(
                                    Icons.share_sharp,
                                    size: 18,
                                  )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chat()));
                            },
                            child: Wrap(
                              spacing: 13,
                              children: [
                                SizedBox(width: 0),
                                Image(
                                  image: AssetImage('assets/images/chat.png'),
                                  height: 20,
                                ),
                                Text(
                                    // the text of the row.
                                    "Legal",
                                    style: TextStyle(
                                      color: Color(0xff2B2B2B),
                                      fontFamily: "okra_Medium",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              //  LogoutDialogBox(context);
                            },
                            child: Row(
                              children: [
                                //  Spacer(),
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/logout.png'),
                                          height: 20,
                                          color: Colors.pink,
                                        ),
                                        Text(
                                          "    Logout    ",
                                          style: TextStyle(
                                            color: Colors.pink,
                                            fontFamily: "okra_Medium",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),

                                          /* style: TextStyle(
                                            color: Colors.pink,
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal * 3.9),*/
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer()
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  Container(
                    height: ResponsiveUtil.height(300),
                    decoration: _backgroundDecoration.copyWith(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveUtil.height(40),
                          left: ResponsiveUtil.width(15),
                          right: ResponsiveUtil.width(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: Icon(Icons.dehaze_rounded,
                                  color: Colors.black),
                            ),
                            SizedBox(width: ResponsiveUtil.width(10)),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name Text
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "Hi, Aayshaaa",
                                      style: TextStyle(
                                        fontSize: ResponsiveUtil.fontSize(15),
                                        fontFamily: 'okra_extrabold',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: ResponsiveUtil.height(2)),

                                  // Location Row
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png',
                                        height: ResponsiveUtil.height(16),
                                        color: CupertinoColors.white,
                                      ),
                                      SizedBox(width: ResponsiveUtil.width(3)),
                                      Expanded(
                                        child: Text(
                                          "Opposite Sassoon Hospital, Station Road, Pune-411001",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveUtil.fontSize(14),
                                            fontFamily: 'Poppins_Bold',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                            color: CupertinoColors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1, // Prevents text overflow
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                                width: ResponsiveUtil.width(
                                    10)), // Spacing before icon
                            Image.asset(
                              'assets/images/notification.png',
                              height: ResponsiveUtil.height(20),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ResponsiveUtil.height(13)),

                      // Tab Buttons
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtil.width(10)),
                        child: Container(
                          padding: EdgeInsets.all(ResponsiveUtil.width(2)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              // Product Button
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 0;
                                      _changeBackground(0);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtil.height(9),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: selectedIndex == 0
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xfff12935),
                                                Color(0xffFF5963)
                                              ],
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                            )
                                          : null,
                                      color: selectedIndex != 0
                                          ? Colors.transparent
                                          : null,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Service",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-BoldItalic",
                                        color: selectedIndex == 0
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveUtil.fontSize(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Service Button
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = 1;
                                      _changeBackground(1);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtil.height(9),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: selectedIndex == 1
                                          ? LinearGradient(
                                              colors: [
                                                Color(0xff632883),
                                                Color(0xff8d42a3)
                                              ],
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                            )
                                          : null,
                                      color: selectedIndex != 1
                                          ? Colors.transparent
                                          : null,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Product",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-BoldItalic",
                                        color: selectedIndex == 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ResponsiveUtil.fontSize(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.02),
                        child: Text(
                          "   ANYTHING ON RENT",
                          style: TextStyle(
                            fontFamily: "okra_extrabold",
                            fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),

                      GestureDetector(
                          onTap: () async {
                            String? selectedCity = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationMapScreen()),
                            );
                            if (selectedCity != null) {
                              print("Received City: $selectedCity");

                              setState(() {
                                updatedCity = selectedCity;
                              });
                              String? id = GetStorage().read<String>('userId');
                              print("jjjjjjjj  $id");
                              bool success = await authService.storeUserCity(
                                id!,
                                18.5204,
                                73.8567,
                                selectedCity,
                              );

                              if (success) {
                                print("City successfully updated in backend!");
                              } else {
                                print("Failed to update city in backend.");
                              }
                            }
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 5, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 35,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      border: Border.all(
                                          color: Colors.black26, width: 0.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: SizeConfig.screenHeight * 0.025,
                                          color: Color(0xff632883),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            updatedCity,
                                            style: TextStyle(
                                              color: Color(0xff632883),
                                              letterSpacing: 0.0,
                                              fontFamily: "okra_Bold",
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.8,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                AddPostButton(SizeConfig.screenHeight,
                                    SizeConfig.screenWidth),
                              ],
                            ),
                          )),

                      SizedBox(height: 5),
                      HomeSearchBar(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 13),
              sliderData(
                images,
                SizeConfig.screenHeight,
                SizeConfig.screenWidth,
              ),
              //PopularCategories(SizeConfig.screenHeight, SizeConfig.screenWidth),
              Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight * 0.03, top: 0),
                child: Popular(SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),
            ],
          ),
        ));
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
            padding:
                EdgeInsets.only(left: SizeConfig.screenWidth * .05, top: 10),
            child: SizedBox(
              height: SizeConfig.screenHeight * .053,
              width: SizeConfig.screenWidth * .95,
              child: Padding(
                padding: EdgeInsets.only(right: parentWidth * 0.04),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black26, width: 0.5),
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

  Widget AddPostButton(double parentHeight, double parentWidth) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: "Montserrat-BoldItalic",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    double textWidth = textPainter.width + 30;
    double textHeight = textPainter.height + 20;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CatProductService(onChanged: (String ) {  }, categoryId: '',)));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controllerss,
              builder: (context, child) {
                return CustomPaint(
                  painter: SnakeBorderPainter(progress: _controllerss.value),
                  child: Container(
                    width: textWidth,
                    height: textHeight,
                  ),
                );
              },
            ),
          ),
          Container(
            height: parentHeight * 0.048,
            width: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xfff44343),
                  Color(0xffFEA3A3),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                fontFamily: "Montserrat-BoldItalic",
                fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                color: CupertinoColors.white,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget sliderData(
      List<String> images, double parentHeight, double parentWidth) {
    return Column(
      children: [
        isLoading
            ? Center(child: CircularProgressIndicator())
            : CarouselSlider.builder(
                itemCount: adsUrlsList.length,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  initialPage: 0,
                  height: MediaQuery.of(context).size.height * 0.17,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                itemBuilder: (BuildContext context, int itemIndex, int index1) {
                  final baseUrl = 'https://admin-fyu1.onrender.com/';

                  final imgUrl = adsUrlsList.isNotEmpty
                      ? '$baseUrl${adsUrlsList[index1].replaceAll("\\", "/")}'
                      : null;
                  final isVideo = imgUrl != null && imgUrl.endsWith('.mp4');

                  return imgUrl != null
                      ? Container(
                          margin: EdgeInsets.all(10),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: isVideo
                                  ? VideoPlayerWidget(url: imgUrl)
                                  : Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imgUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < adsUrlsList.length; i++)
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
                          ],
                        ),
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
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
          ],
        ),
      ],
    );
  }

  Widget PopularCategories(double parentHeight, double parentWidth) {
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
                  child: Text(" PRODUCT CATEGORIES",
                      style: TextStyle(
                          color: Colors.grey[500]!,
                          fontFamily: "okra_Medium",
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
            height: 15,
          ),
          Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.05),
              child: Container(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.0 / 2,
                    ),
                    itemCount: min(8, filteredItems.length),
                    itemBuilder: (context, index) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Color(0xffFFFFFF), Color(0xffF1F1F1)],
                              ),
                              border: Border.all(
                                width: 0.4,
                                color: Colors.grey[400]!,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 3, right: 2),
                                  child: Text(
                                    filteredItems[index].name.toString(),
                                    style: TextStyle(
                                      color: Colors.black,

                                      fontFamily: "Arial",
                                      fontSize: parentWidth *
                                          0.030, // Dynamic font size
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      catagriesImage[index],
                                      height: 30,
                                      width: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )),
          /*  Container(
            height: 200,
            color: Colors.red,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: catagriesItemList.length, // Define the number of items
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

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 10,left: 3,right: 2),
                              child: Text(
                                catagriesItemList[index],
                                style: TextStyle(
                                  color: Colors.black,

                                  fontFamily: "Arial",
                                  fontSize: parentWidth *
                                      0.030, // Dynamic font size
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Image.asset(
                                  catagriesImage[index],
                                  height: 40,
                                  width: 35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),*/

          /*   Container(
            height: 80,
            child:



            ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: parentWidth * 0.20,
                        height: 50,
                        // Set width for each item
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [Color(0xffeaeaea), Color(0xffffffff)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: SizedBox(
                            width: 10, // Define desired width
                            height: 10,
                            child: Image.asset(
                              catagriesImage[index],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: parentHeight * 0.02,
                        width: parentWidth * 0.2,
                        child: Text(
                          filteredItems[index]
                              .name
                              .toString(),
                          style: TextStyle(
                            letterSpacing: 0.5,
                            color: Colors.black,
                            fontFamily: "Montserrat_Medium",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }),
          ),*/
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: Container(
                              height: SizeConfig.screenHeight,
                              child: CatagriesList(
                                onChanged: (value) {},
                                categoryId: '',
                              )))));
            },
            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.72),
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
          ),
        ],
      ),
    );
  }

  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return IntrinsicHeight(
      child: Container(
        height: SizeConfig.screenHeight * 0.97,
        color: Colors.red,
        child: Expanded(
          child: Container(
            alignment: Alignment.center,
            child: selectedIndex == 1
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PopularCategories(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                      SizedBox(height: 10),
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
                                      fontFamily: "okra_Medium",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.8,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.9),
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(
                            width: 10,
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            "  Near by Location",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhoneRegistrationPage(
                                            mobileNumber: '',
                                            email: '',
                                            phoneNumber: '', showLoginWidget: false,
                                          )));*/

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeHome()));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: parentWidth * 0.38, top: 5),
                              child: Container(
                                height: parentHeight * 0.03,
                                width: parentWidth * 0.22,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff3684F0), width: 0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      " View All",
                                      style: TextStyle(
                                        fontFamily: "okra_Medium",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.1,
                                        color: Color(0xff3684F0),
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Image(
                                      image:
                                          AssetImage('assets/images/arrow.png'),
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
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 1.0, // Adjust as needed
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: 10.0, right: 5.0, top: 0.0, bottom: 30.0),

                            decoration: BoxDecoration(
                                color: CommonColor.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff000000).withOpacity(0.2),
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                      offset: Offset(0, 1)),
                                ],
                                border: Border.all(
                                    color: Colors.black38, width: 0.9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),

                            // alignment: Alignment.center,

                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: SizeConfig.screenHeight * 0.19,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                          autoplay: false,
                                          dotSize: 6,
                                          dotSpacing: 10,
                                          dotColor: Colors.white70,
                                          // overlayShadow: false,

                                          dotIncreasedColor: Colors.black45,
                                          indicatorBgPadding: 3.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.125),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            height: parentHeight * 0.055,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 10, top: 2),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'HD Camera (black & white) dfgdf',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "okra_Medium",
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 2),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          size: SizeConfig
                                                                  .screenHeight *
                                                              0.019,
                                                          color: Color(
                                                                  0xffffffff)
                                                              .withOpacity(0.8),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            'park Street pune 004120',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontFamily:
                                                                  "Montserrat-Medium",
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                        padding:
                                            EdgeInsets.only(top: 0, left: 110),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            height: 15,
                                            decoration: BoxDecoration(
                                              color: Color(0xff632883),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(children: [
                                              Icon(
                                                Icons.location_on,
                                                size: SizeConfig.screenHeight *
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
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ]),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          Text(
                            "  Recently Added",
                            style: TextStyle(
                              fontFamily: "Montserrat-Medium",
                              fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewService(
                                            lat: '',
                                            long: '',
                                            ProductAddress: '',
                                            BusinessOfficeAddress: '',
                                          )));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: parentWidth * 0.38, top: 3),
                              child: Container(
                                height: parentHeight * 0.03,
                                width: parentWidth * 0.22,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff3684F0), width: 0.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      " View All",
                                      style: TextStyle(
                                        fontFamily: "okra_Medium",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.1,
                                        color: Color(0xff3684F0),
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Image(
                                      image:
                                          AssetImage('assets/images/arrow.png'),
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
                      Padding(
                        padding: EdgeInsets.only(top: 3, left: 10),
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
                            maxLines: 2, // Limit to 2 lines
                            overflow: TextOverflow
                                .ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                     /* Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredItemss.length,
                          itemBuilder: (context, index) {
                            final product = filteredItemss[index];
                            final productImages = product.images ?? [];

                            return Container(
                              height: 300,
                              color: Colors.red,
                              width: parentWidth * 0.55,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              */
                      /*decoration: BoxDecoration(
                               // color: Colors.blue,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: CommonColor.grayText, width: 0.3),
                              ),*/
                      /*
                              child: Column( // Changed Expanded to Column
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Container(
                                      height: 150, // Fixed height
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(7),
                                          topRight: Radius.circular(7),
                                        ),
                                        child: productImages.isNotEmpty
                                            ? CarouselSlider.builder(
                                          key: PageStorageKey('carouselKey'),
                                          carouselController: _controller,
                                          itemCount: productImages.length,
                                          options: CarouselOptions(
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            initialPage: 0,
                                            height: 150,
                                            viewportFraction: 1.0,
                                            enableInfiniteScroll: false,
                                            autoPlay: false,
                                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                                          ),
                                          itemBuilder: (BuildContext context, int itemIndex, int index1) {
                                            final imgUrl = productImages[index1].url ?? "";

                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(imgUrl),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                            : Container(
                                          color: Colors.grey,
                                          child: Center(child: Text("No Image")),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 7),
                                        Text(
                                          product.name ?? "No Name",
                                          style: TextStyle(
                                            fontFamily: "Montserrat-Regular",
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                                            color: CommonColor.Black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: SizeConfig.screenHeight * 0.019,
                                              color: Color(0xff3684F0),
                                            ),
                                            Flexible(
                                              child: Text(
                                                'Park Street, Pune Banner 20023',
                                                style: TextStyle(
                                                  fontFamily: "Montserrat-Regular",
                                                  fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                                  color: Color(0xff3684F0),
                                                  fontWeight: FontWeight.w400,
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
                                ],
                              ),
                            );
                          },
                        ),
                      )*/

                    ],
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
      ),
    );
  }

  Widget Popular(double parentHeight, double parentWidth) {
    return Container(
      child: selectedIndex == 1
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PopularCategories(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                SizedBox(height: 15),
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
                                fontFamily: "okra_Medium",
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
                Row(
                  children: [
                    Text(
                      "  Near by Location",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat-Medium",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PhoneRegistrationPage(
                                        mobileNumber: '',
                                        email: '',
                                        phoneNumber: '', showLoginWidget: false,
                                      )));*/

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeHome()));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: parentWidth * 0.38, top: 5),
                        child: Container(
                          height: parentHeight * 0.03,
                          width: parentWidth * 0.22,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff3684F0), width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                " View All",
                                style: TextStyle(
                                  fontFamily: "okra_Medium",
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.1,
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
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 1.0, // Adjust as needed
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(

                      margin: EdgeInsets.only(
                          left: 10.0, right: 5.0, top: 0.0, bottom: 30.0),

                      decoration: BoxDecoration(
                          color: CommonColor.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff000000).withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(0, 1)),
                          ],
                          border: Border.all(color: Colors.black38, width: 0.9),
                          borderRadius: BorderRadius.all(Radius.circular(7))),

                      // alignment: Alignment.center,

                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: SizeConfig.screenHeight * 0.19,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                    autoplay: false,
                                    dotSize: 6,
                                    dotSpacing: 10,
                                    dotColor: Colors.white70,
                                    // overlayShadow: false,

                                    dotIncreasedColor: Colors.black45,
                                    indicatorBgPadding: 3.0,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: parentHeight * 0.125),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: parentHeight * 0.055,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8, right: 10, top: 2),
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
                                              padding: EdgeInsets.only(top: 2),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: SizeConfig
                                                            .screenHeight *
                                                        0.019,
                                                    color: Color(0xffffffff)
                                                        .withOpacity(0.8),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      'park Street pune 004120',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontFamily:
                                                            "Montserrat-Medium",
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                  padding: EdgeInsets.only(top: 0, left: 110),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      height: 15,
                                      decoration: BoxDecoration(
                                        color: Color(0xff632883),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(children: [
                                        Icon(
                                          Icons.location_on,
                                          size: SizeConfig.screenHeight * 0.019,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '1.2 Km   ',
                                          style: TextStyle(
                                            fontFamily: "Montserrat-Regular",
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    2.5,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Text(
                      "  Recently Added ",
                      style: TextStyle(
                        fontFamily: "Montserrat-Medium",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewService(
                                      lat: '',
                                      long: '',
                                      ProductAddress: '',
                                      BusinessOfficeAddress: '',
                                    )));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: parentWidth * 0.38, top: 3),
                        child: Container(
                          height: parentHeight * 0.03,
                          width: parentWidth * 0.22,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff3684F0), width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                " View All",
                                style: TextStyle(
                                  fontFamily: "okra_Medium",
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.1,
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
                Padding(
                  padding: EdgeInsets.only(top: 3, left: 10),
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
                      maxLines: 2,
                      overflow: TextOverflow
                          .ellipsis,
                    ),
                  ),
                ),

             
                SizedBox(height: 10),

                Container(

                  height: 240,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                     /* final product = filteredItemss[index];
                      final productImages = product.images ?? [];
                */
                      return Container(


                        width: parentWidth * 0.55,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: CommonColor.grayText, width: 0.3),
                        ),
                        child: Column(
                          children: [
                           /* Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    topRight: Radius.circular(7),
                                  ),
                                  child: */
                            /*productImages.isNotEmpty
                                      ?*/
                            /* CarouselSlider.builder(
                                    key: PageStorageKey('carouselKey'),
                                    carouselController: _controller,
                                    itemCount: 4,
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                      initialPage: 0,
                                      height: 150,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: false,
                                      autoPlay: false,
                                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    ),
                                    itemBuilder: (BuildContext context, int itemIndex, int index1) {
                                     // final imgUrl = productImages[index1].url ?? "";

                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        */
                            /*  image: DecorationImage(
                                            image: NetworkImage(imgUrl),
                                            fit: BoxFit.cover,
                                          ),*/
                            /*
                                        ),
                                      );
                                    },
                                  )





                                     */
                            /* : Container(
                                    color: Colors.grey,
                                    child: Center(child: Text("No Image")),
                                  ),*/
                            /*
                                ),
                              ),
                            ),*/


                            Container(
                              height: SizeConfig.screenHeight * 0.19,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                child: AnotherCarousel(
                                  images: const [
                                    NetworkImage(
                                        "https://pune.accordequips.com/images/products/15ccb1ae241836.png"),
                                    NetworkImage(
                                        "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg"),

                                    NetworkImage(
                                        "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg"),

                                    NetworkImage(
                                        "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg"),
                                    NetworkImage(
                                        "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg"),
                                    NetworkImage(
                                        "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg")
                                  ],
                                  autoplay: false,
                                  dotSize: 6,
                                  dotSpacing: 10,
                                  dotColor: Colors.white70,
                                  // overlayShadow: false,

                                  dotIncreasedColor: Colors.black45,
                                  indicatorBgPadding: 3.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 7),
                                  Text(
                                   " product.name",
                                    style: TextStyle(
                                      fontFamily: "Montserrat-Regular",
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                                      color: CommonColor.Black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: SizeConfig.screenHeight * 0.019,
                                        color: Color(0xff3684F0),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Park Street, Pune Banner 20023',
                                          style: TextStyle(
                                            fontFamily: "Montserrat-Regular",
                                            fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                            color: Color(0xff3684F0),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    " 1 day ago",
                                    style: TextStyle(
                                      fontFamily: "Montserrat-Regular",
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                                      color: CommonColor.Black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),
                      );



                    },
                  ),
                ),


              ],
            )
          : Text(
              "Zepto Super Saver Content",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}

class SnakeBorderPainter extends CustomPainter {
  final double progress;
  SnakeBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height),
        [
          Color(0xffFEBA69),
          Color(0xffFEBA69),
        ],
      );

    // Define path for rounded rectangle
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(10),
      ));

    // Animate the path using dash effect
    final PathMetrics pathMetrics = path.computeMetrics();
    for (var metric in pathMetrics) {
      final double pathLength = metric.length;
      final double start = (progress * pathLength) % pathLength;
      final double end = start + pathLength * 0.9;

      final Path extractPath = metric.extractPath(start, end);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(SnakeBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
