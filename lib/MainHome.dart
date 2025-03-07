import 'dart:async';

import 'package:anything/ProductSeparateCat.dart';
import 'package:anything/ConstantData/AuthStorage.dart';
import 'package:anything/createService.dart';
import 'package:anything/model/dio_client.dart';
import 'package:anything/newGetStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Admin/UserFeedback.dart';
import 'Admin/helpCentre.dart';
import 'Admin/vedio_player.dart';
import 'package:geolocator/geolocator.dart';
import 'Authentication/register_common.dart';

import 'Cat_Product_Service.dart';
import 'Common_File/ResponsiveUtil.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'ConstantData/Constant_data.dart';
import 'MyBehavior.dart';
import 'package:anything/ResponseModule/getAllCatList.dart' as catData;
import 'NewDioClient.dart';
import 'ProductConfirmation.dart';
import 'ResponseModule/BusniessAdsResponseModel.dart';
import 'ResponseModule/getAllCatList.dart';
import 'ResponseModule/getAllProductList.dart';
import 'SearchCatagries.dart';
import 'SideBar/My Collection.dart';
import 'SideBar/My Ratings.dart';
import 'SideBar/My Transaction History.dart';
import 'SideBar/MyFevorites.dart';

import 'SideBar/chat.dart';
import 'SideBar/common_profile_bar.dart';
import 'SideBar/klklk.dart';
import 'addProductService.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

import 'package:get_storage/get_storage.dart';

import 'package:geocoding/geocoding.dart';


import 'change_home.dart';
import 'location_map.dart';

class MainHome extends StatefulWidget {
  final String lat;
  final String long;
  final bool showLoginWidget;
  const MainHome({
    super.key,
    required this.lat,
    required this.long, required this.showLoginWidget,
  });
  @override
  State<StatefulWidget> createState() => MainHomeState();
}

class MainHomeState extends State<MainHome>
    with SingleTickerProviderStateMixin {
  String? profileImage = GetStorage().read(ConstantData.UserProfileImage);
  bool isSearchExpanded = false;
/*  List<catData.CategoryData> filteredItems = [];
  List<catData.CategoryData> items = [];*/
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  bool isLoading = true;
  bool isSearchingData = false;
  String locationName = "";



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //fetchCategories();
      fetchProductsList();
      fetchBusinessAds();
      _getCityName();
      _getLocation();

    //  firstname = GetStorage().read<String>(ConstantData.firstName,) ?? "Guest";
      firstname = NewAuthStorage.getFName() ?? "Guest";
    //  firstname = AuthStorage().
      updatedCity = GetStorage().read<String>("selectedCity") ?? "Select City";
      print("name   $firstname");
      _tabController = TabController(length: 2, vsync: this);
      //  updatedCity = GetStorage().read('selectedCity') ?? "No city selected";
    });
    startAnimation();
  }
  void startAnimation() {
    Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (mounted) {
        setState(() {
          _visible = !_visible; // Toggle visibility every 2 sec
        });
      } else {
        timer.cancel(); // Stop timer if widget is disposed
      }
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
  List<Products> itemss = [];
  List<String> adsUrlsList = [];
  List<Products> filteredItemss = [];
  int selectedIndex = 0;
  final ApiClients authService = ApiClients();
  bool _visible = true;
  //final box = GetStorage();

  late TabController _tabController;

  final List<String> images = [
    'https://img.freepik.com/free-psd/shoes-sale-social-media-post-square-banner-template-design_505751-2862.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-vector/black-friday-sale-social-media-post-banner-home-appliance-product-instagram-post-banner-design_755018-930.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/drink-ad-nature-pear-juice_52683-34246.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-psd/ironing-machine-brand-product-social-media-banner_154386-123.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/sports-drink-advertisement_52683-430.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
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
  ];

  List<String> catagriesDiscription = [
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
    "Lorem Ipsum is dummy text used as a placeholder text since 1870",
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
    'assets/images/agriculture.png',
    'assets/images/agriculture.png',
  ];

/*
  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllCat();

      var jsonList = GetAllCategoriesList.fromJson(response);
      setState(() {
        items = jsonList.categoryData?.take(10).toList() ?? [];
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
*/


  void fetchProductsList() async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllProductList();
      var jsonList = getAllProductList.fromJson(response);
      setState(() {
        itemss = jsonList.products?.take(10).toList() ?? [];
        itemss = jsonList.products ?? [];

        filteredItemss = List.from(itemss);

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("loader $isLoading");
    }
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

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enable Location"),
        content: Text("Please enable location services to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> _getCityName() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationDialog();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        updatedCity = placemarks.isNotEmpty
            ? placemarks[0].locality ?? "City not found"
            : "City not found";
      });
    } catch (e) {
      setState(() {
        updatedCity = "Failed to fetch city: $e";
      });
    }
  }


  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationDialog();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String fullAddress =
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, "
            "${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        setState(() {
          locationName = fullAddress;
        });
      } else {
        setState(() {
          locationName = "Address not found";
        });
      }
    } catch (e) {
      setState(() {
        locationName = "Failed to fetch address: $e";
      });
    }
  }


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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  GestureDetector(
                    onTap: () async {
                      print("Logout initiated...");

                      String? accessToken = AuthStorage.getAccessToken();
                      print(" Stored Access Token: $accessToken");
                      /*String? sessionToken = GetStorage()
                          .read<String>(ConstantData.userToken);*/


                      if (accessToken == null || accessToken.isEmpty) {
                        print("No session token found. Redirecting to login.");

                        return;
                      }

                      // Call the logout API
                      final response =
                          await NewApiClients().getNewLogoutUser();

                      if (response['success'] == true) {
                        print("Logout Successful");
                        NewAuthStorage.clearStorage();

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>  PhoneRegistrationPage( showLoginWidget: true, mobileNumber: '', email: '', phoneNumber: '',)),

                           (route) => false,
                        );


                      } else {
                        print("Logout failed: ${response['error']}");
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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

  String updatedCity = "No city selected";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        backgroundColor: Color(0xffffffff),
        child: Column(
        //  padding: EdgeInsets.zero,
        //  physics: NeverScrollableScrollPhysics(),
          children: <Widget>[




        Container(
        height: ResponsiveUtil.height(160),
        color: const Color(0xfff1f2fd),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: ResponsiveUtil.width(108),
                height: ResponsiveUtil.height(120),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
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
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
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
                  child: Icon(Icons.settings, size: 18, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileBar()),
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
                            backgroundImage: profileImage != null && profileImage!.isNotEmpty
                                ? NetworkImage(profileImage!)
                                : const AssetImage('assets/images/profiless.png') as ImageProvider,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(ResponsiveUtil.width(4)),
                            child: Image.asset('assets/images/pro_edit.png', height: ResponsiveUtil.width(16)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: ResponsiveUtil.width(10)),
                    Padding(
                      padding:  EdgeInsets.only(
                          top: ResponsiveUtil.height(10),
                          left: ResponsiveUtil.width(3)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: ResponsiveUtil.width(150),
                            child: Text(
                              "Hii, $firstname",
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
                                image: AssetImage('assets/images/location.png'),
                                height: 13,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              SizedBox(
                                width: ResponsiveUtil.width(190),
                                child: Text(
                                  locationName,
                                  style: TextStyle(
                                    fontSize: ResponsiveUtil.fontSize(13),
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
              child:  ScrollConfiguration(
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
                              Text("Manage Posts",

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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AddToCart()));
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
                                image: AssetImage('assets/images/transaction.png'),
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
                                image: AssetImage('assets/images/transaction.png'),
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
                          child: Padding(
                            padding:  EdgeInsets.only(left: 12),
                            child: Wrap(
                              spacing: 12, // Horizontal spacing


                              crossAxisAlignment: WrapCrossAlignment.center, // Vertical center align
                              children: [
                                const Image(
                                  image: AssetImage('assets/images/chat.png'),
                                  height: 20,
                                ),
                                Container(
                                  width: 120, // Adjust width for better wrapping
                                  child: Text(
                                    "Due for renewal",
                                    style: TextStyle(
                                      color: Color(0xff2B2B2B),
                                      fontFamily: "okra_Medium",
                                      fontSize: SizeConfig.isDesktop
                                          ? SizeConfig.safeBlockVertical * 1.8 // Desktop
                                          : SizeConfig.isTablet
                                          ? SizeConfig.safeBlockVertical * 1.5 // Tablet
                                          : SizeConfig.safeBlockVertical * 1.9, // Mobile
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                AnimatedOpacity(
                                  opacity: _visible ? 1.0 : 0.0, // Fade effect on image only
                                  duration: const Duration(milliseconds: 800), // Smooth transition
                                  child: const Image(
                                    image: AssetImage('assets/images/renew.png'),
                                    height: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),

                        SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelpCenterScreen()));
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
                                image: AssetImage('assets/images/setting.png'),
                                height: 20,
                              ),
                              Container(
                                width: 108,
                                //  color: Colors.red,
                                child: Text(
                                    // the text of the row.
                                    "FeedBack",
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
                                    builder: (context) => ProductConfigurations()));
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
                               // width: 108,
                                //  color: Colors.red,
                                child: Text(
                                  // the text of the row.
                                    "Report & Suggestions",
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
                        ), SizedBox(height: 3),
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
                                    builder: (context) => ProductConfigurations()));
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
                                // width: 108,
                                //  color: Colors.red,
                                child: Text(


                                    "About Us",
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
                                    builder: (context) => ProductConfigurations()));
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
                                    builder: (context) => ProductConfigurations()));
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
                                  child:
                                  Icon(Icons.share_sharp,size: 18,)
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => chat()));
                          },
                          child: Wrap(
                            spacing: 13,
                            children: [
                              SizedBox(width: 0),
                              Image(
                                image: AssetImage('assets/images/chat.png'),
                                height: 20,
                              ),
                              Container(
                                // width: 125,
                                //  color: Colors.red,
                                child: Text(
                                  // the text of the row.
                                    "Legal",
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
                            LogoutDialogBox(context);
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
                                        image: AssetImage('assets/images/logout.png'),
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
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.99,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: 240,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/dashtwo.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 40, left: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                child: Icon(Icons.dehaze_rounded),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " Hi, $firstname",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'okra_extrabold',
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/location.png',
                                          height: 16, // Adjusted for clarity
                                          color: CupertinoColors.black,
                                        ),
                                        SizedBox(width: 7),
                                        Container(
                                          width: ResponsiveUtil.width(250),

                                          child: Text(
                                            locationName,
                                            style: TextStyle(
                                              fontSize:
                                                  14, // Adjusted for clarity
                                              fontFamily: 'Poppins_Bold',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.5,
                                              color: CupertinoColors.black,
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
                                padding: EdgeInsets.only(top: 3, left: 30),
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/notification.png'),
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      HomeSearchBar(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                      Padding(
                        padding:
                            EdgeInsets.only(top: SizeConfig.screenHeight * 0.19),
                        child: Text(
                          "     ANYTHING ON RENT",
                          style: TextStyle(
                            fontFamily: "okra_extrabold",
                            fontSize: SizeConfig.blockSizeHorizontal * 5.1,
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.25),
                          child: Container(
                            height: SizeConfig.screenHeight * 0.07,
                            width: SizeConfig.screenWidth * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 0.2, color: CommonColor.Black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      GestureDetector(

                        onTap: () async {
                          String? selectedCity = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocationMapScreen()),

                          );
                          if (selectedCity != null) {
                            print("✅ Received City: $selectedCity");

                            setState(() {
                              updatedCity = selectedCity;
                            });
                            String? id = GetStorage().read<String>('userId');
                            print("jjjjjjjj  ${id}");
                            bool success =
                            await authService.storeUserCity(
                              id!, // User ID
                              18.5204, // Latitude
                              73.8567, // Longitude
                              selectedCity, // City
                            );

                            if (success) {
                              print(
                                  "City successfully updated in backend!");
                            } else {
                              print(
                                  "Failed to update city in backend.");
                            }
                          }
                        },
/*            onTap: () async {
                          final String? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateCity()),
                          );
                          if (result != null) {
                            updateCity(result); // Update city if selected
                          }
                        },*/
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.275, left: 30),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: SizeConfig.screenHeight * 0.025,
                                color: Color(0xfff44343),
                              ),
                              Flexible(
                                child: Container(
                                  width: 120,
                                  child: Text(
                                    updatedCity,
                                    style: TextStyle(
                                      color: Color(0xfff44343),
                                      letterSpacing: 0.0,
                                      fontFamily: "okra_Medium",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal *
                                              3.7,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AddPostButton(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                    ],
                  ),

                  sliderData(
                    images,
                    SizeConfig.screenHeight,
                    SizeConfig.screenWidth,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03),
                    child: getAddGameTabLayout(
                        SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),



   /*  LayoutBuilder(
        builder: (context, constraints) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// **Top Banner Section**
                  Stack(
                    children: [
                      /// **Background Image**
                      Container(
                        height: ResponsiveUtil.height(320),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/dashtwo.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),

                      /// **Header Row (Menu, Name, Notification)**
                      Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveUtil.height(60),
                          left: ResponsiveUtil.width(20),
                          right: ResponsiveUtil.width(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: Icon(Icons.menu,
                                  size: ResponsiveUtil.fontSize(28),
                                  color: Colors.black),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi, $firstname",
                                  style: TextStyle(
                                    fontSize: ResponsiveUtil.fontSize(22),
                                    fontFamily: 'okra_extrabold',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: ResponsiveUtil.height(5)),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/location.png',
                                      height: ResponsiveUtil.height(22),
                                      color: CupertinoColors.black,
                                    ),
                                    SizedBox(width: ResponsiveUtil.width(10)),
                                    Container(
                                      width: ResponsiveUtil.width(220),
                                      child: Text(
                                        locationName,
                                        style: TextStyle(
                                          fontSize: ResponsiveUtil.fontSize(18),
                                          fontFamily: 'Poppins_Bold',
                                          fontWeight: FontWeight.w500,
                                          color: CupertinoColors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/notification.png',
                              height: ResponsiveUtil.height(26),
                            ),
                          ],
                        ),
                      ),

                      /// **Search Bar**
                      Positioned(
                        top: ResponsiveUtil.height(10),
                        left: 2,
                        right: 0,
                        child: HomeSearchBar(SizeConfig.screenHeight,SizeConfig.screenWidth),
                      ),


                      Positioned(
                        top: ResponsiveUtil.height(260),
                        left: ResponsiveUtil.width(25),
                        child: Text(
                          "ANYTHING ON RENT",
                          style: TextStyle(
                            fontSize: ResponsiveUtil.fontSize(26),
                            fontFamily: "okra_extrabold",
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      /// **Location Update Button**
                      Positioned(
                        top: ResponsiveUtil.height(300),
                        left: ResponsiveUtil.width(25),
                        child: GestureDetector(
                          onTap: () async {
                            String? selectedCity = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationMapScreen()),
                            );
                            if (selectedCity != null) {
                              setState(() {
                                updatedCity = selectedCity;
                              });
                              String? id = GetStorage().read<String>('userId');
                              bool success = await authService.storeUserCity(
                                id!,
                                18.5204,
                                73.8567,
                                selectedCity,
                              );
                              if (success) {
                                print("✅ City successfully updated!");
                              } else {
                                print("❌ Failed to update city.");
                              }
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: ResponsiveUtil.fontSize(24),
                                color: Color(0xfff44343),
                              ),
                              SizedBox(width: ResponsiveUtil.width(5)),
                              Container(
                                width: ResponsiveUtil.width(140),
                                child: Text(
                                  updatedCity,
                                  style: TextStyle(
                                    fontSize: ResponsiveUtil.fontSize(20),
                                    fontFamily: "okra_Medium",
                                    color: Color(0xfff44343),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// **Add Post Button**
                      Positioned(
                        top: ResponsiveUtil.height(140),
                        left: 0,
                        right: 0,
                        child: AddPostButton(
                            SizeConfig.screenHeight, SizeConfig.screenWidth),
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveUtil.height(20)),

                  /// **Additional Sections**
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtil.width(20)),
                    child: Column(
                      children: [
                        /// **Slider Section**
                        sliderData(images,SizeConfig.screenHeight, SizeConfig.screenWidth),

                        SizedBox(height: ResponsiveUtil.height(30)),

                        /// **Tab Layout**
                        getAddGameTabLayout(SizeConfig.screenHeight,SizeConfig.screenWidth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),*/




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
                top: SizeConfig.screenHeight * 0.11),
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

  Widget sliderData(
      List<String> images, double parentHeight, double parentWidth)
  {
    return Column(
      children: [
        isLoading
            ? Center(
                child:
                    CircularProgressIndicator()) // Show loader while fetching
            : CarouselSlider.builder(
                itemCount: adsUrlsList.length,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  initialPage: 0,
                  height: MediaQuery.of(context).size.height * 0.2,
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
                          margin: EdgeInsets.all(16),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: isVideo
                                  ? VideoPlayerWidget(
                                      url: imgUrl) // Custom widget for video
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

  Widget AddPostButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CatProductService(onChanged: (String ) {  }, categoryId: '',)));
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: parentWidth * 0.62,
            right: parentWidth * 0.09,
            top: SizeConfig.screenHeight * 0.265),
        child: Container(
          height: parentHeight * 0.040,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xfff44343),
                Color(0xffFEA3A3),
              ],
            ),
            //   border: Border.all(width: 0.5, color: CommonColor.Black),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Center(
              child: Text(
            "Create Post +",
            style: TextStyle(
              fontFamily: "Montserrat-BoldItalic",
              fontSize: SizeConfig.blockSizeHorizontal * 3.1,
              color: CupertinoColors.white,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      ),
    );
  }

  Widget PopularCategories(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.03),
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
                            fontFamily: "okra_Medium",
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
          SizedBox(
            height: 15,
          ),
          /*    Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.05),
              child: Container(


                height: 100, // Set a fixed height for the GridView
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    physics:
                        AlwaysScrollableScrollPhysics(), // Disable scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Number of rows
                      crossAxisSpacing: 13, // Space between columns
                      mainAxisSpacing: 30, // Space between rows
                      childAspectRatio:
                          4 / 3, // Adjust the width-to-height ratio
                    ),
                    itemCount: catagriesItemList.length,
                    itemBuilder: (context, index) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(

                            width: constraints
                                .maxWidth, // Dynamically adjust width
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,

                                colors: [Color(0xffFFFFFF), Color(0xffF1F1F1)],
                              ),
                              border:

                                  Border.all(width: 0.4,  color: Colors.grey[400]!,),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
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
                          );
                        },
                      );
                    },
                  ),
                ),
              )),*/
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

          Container(
            height: 80,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Define the number of items
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
                          "filteredItems[index].name.toString()",
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
          ),
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
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.0),
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
            height: 20,
          ),
          Container(
            height: SizeConfig.screenHeight * 0.97,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                    padding:  EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Color(0xffEAEEFF),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceAround, // Align buttons to ends
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 58, vertical: 10),
                            decoration: BoxDecoration(
                              gradient: selectedIndex != 1
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xff1371f6),
                                        Color(0xffb8a1ff)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    )
                                  : null,
                              color: selectedIndex == 1
                                  ? Colors.transparent
                                  : null,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
                              "Product",
                              style: TextStyle(
                                  fontFamily: "Montserrat-BoldItalic",
                                  color: selectedIndex == 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 58, vertical: 10),
                            decoration: BoxDecoration(
                              gradient: selectedIndex == 1
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xff1371f6),
                                        Color(0xffb8a1ff)
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    )
                                  : null,
                              color: selectedIndex != 1
                                  ? Colors.transparent
                                  : null,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Text(
                              "Service",
                              style: TextStyle(
                                  color: selectedIndex == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat-BoldItalic",
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: selectedIndex == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
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
                                                builder: (context) =>
                                                    ChangeHome()));


                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.38, top: 5),
                                      child: Container(
                                        height: parentHeight * 0.03,
                                        width: parentWidth * 0.22,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff3684F0),
                                                width: 0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              " View All",
                                              style: TextStyle(
                                                fontFamily: "okra_Medium",
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.1,
                                                color: Color(0xff3684F0),
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/arrow.png'),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1.0,
                                  mainAxisSpacing: 0.0,
                                  childAspectRatio: 1.0, // Adjust as needed
                                ),
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 10.0,
                                        right: 5.0,
                                        top: 0.0,
                                        bottom: 30.0),

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
                                        border: Border.all(
                                            color: Colors.black38, width: 0.9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),

                                    // alignment: Alignment.center,

                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: SizeConfig.screenHeight *
                                                  0.19,
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

                                                  dotIncreasedColor:
                                                      Colors.black45,
                                                  indicatorBgPadding: 3.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: parentHeight * 0.125),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                    height:
                                                        parentHeight * 0.055,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 10,
                                                          top: 2),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'HD Camera (black & white) dfgdf',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "okra_Medium",
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 2),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  size: SizeConfig
                                                                          .screenHeight *
                                                                      0.019,
                                                                  color: Color(
                                                                          0xffffffff)
                                                                      .withOpacity(
                                                                          0.8),
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'park Street pune 004120',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.8),
                                                                      fontFamily:
                                                                          "Montserrat-Medium",
                                                                      fontSize:
                                                                          11,
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
                                                padding: EdgeInsets.only(
                                                    top: 0, left: 110),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff5095f1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(children: [
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
                                        SizedBox(height: 4),
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
                                                  NewService(lat: '', long: '', ProductAddress: '', BusinessOfficeAddress: '',)));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: parentWidth * 0.38, top: 3),
                                      child: Container(
                                        height: parentHeight * 0.03,
                                        width: parentWidth * 0.22,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff3684F0),
                                                width: 0.5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              " View All",
                                              style: TextStyle(
                                                fontFamily: "okra_Medium",
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.1,
                                                color: Color(0xff3684F0),
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/arrow.png'),
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
                                        .ellipsis, // Add ellipsis if text overflows
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filteredItemss
                                        .length, // Define the number of items
                                    itemBuilder: (context, index) {
                                      final product = filteredItemss[index];

                                      final productImages =
                                          product.images ?? [];

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
                                                  child: CarouselSlider.builder(
                                                    key: PageStorageKey(
                                                        'carouselKey'),
                                                    carouselController:
                                                        _controller,
                                                    itemCount:
                                                        productImages.length,
                                                    options: CarouselOptions(
                                                      onPageChanged:
                                                          (index, reason) {
                                                        setState(() {
                                                          currentIndex = index;
                                                        });
                                                      },
                                                      initialPage: 0,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .4,
                                                      viewportFraction: 1.0,
                                                      enableInfiniteScroll:
                                                          false,
                                                      autoPlay: false,
                                                      enlargeStrategy:
                                                          CenterPageEnlargeStrategy
                                                              .height,
                                                    ),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int itemIndex,
                                                            int index1) {
                                                      final imgUrl =
                                                          productImages[index1]
                                                                  .url ??
                                                              "";

                                                      return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                imgUrl),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
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
                                                        filteredItemss[index]
                                                            .name
                                                            .toString(),
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
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
class CustomImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Create a curve at the top of the image
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 100,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


/* FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "PET WORLD",
                  style: TextStyle(
                    fontFamily: "Montserrat-BoldItalic",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                  ),
                ),
              ),
            ),*/



/*
Padding(
padding:
EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.03,top: 0),
child: getAddGameTabLayout(
SizeConfig.screenHeight, SizeConfig.screenWidth),
),*/
