/*
import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

class Estimation extends StatefulWidget {
  const Estimation({super.key});

  @override
  State<Estimation> createState() => _EstimationState();
}

class _EstimationState extends State<Estimation> {
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

          height: MediaQuery.of(context).size.height *1.2,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                top: _startAnimation ? 0 : -screenHeight * 0.4,
                left: 0,
                right: 0,
                child: Container(

                   height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F5FF),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80.0),
                    ),
                  ),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black, size: 23)),
                            Text(
                              "ESTIMATION",
                              style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 0.0,
                                fontFamily: "okra_Medium",
                                fontSize:
                                SizeConfig.blockSizeHorizontal * 4.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Image(image: AssetImage('assets/images/more.png'),height:13,color: Colors.transparent,)

                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                SizeConfig.screenHeight * 0.015,top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.1), // Shadow color
                                    blurRadius: 5, // Shadow blur
                                    offset: Offset(0,
                                        2), // Shadow position (x, y)
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 23.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 17.0,
                                    backgroundColor:
                                    Colors.transparent,
                                    backgroundImage: AssetImage(
                                        'assets/images/profiless.png')
                                  // Profile image
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          // Name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Listing ID:",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "okra_Medium",
                                        fontSize: 14,
                                        letterSpacing: 0.9,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text("  AB2345",
                                      style: TextStyle(
                                        color: Color(0xff3684F0),
                                        fontFamily: "okra_Regular",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                              Text(
                                  "Hi, John Doe",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Roboto_Regular",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),

                      Padding(
                        padding:  EdgeInsets.only(right: 5),
                        child: Padding(
                          padding:  EdgeInsets.all(14.0),
                          child:  Container(
                            width:250,
                            child: Text(
                              "Customize your product effortlessly and preview it instantly before confirming your choice",
                              style: TextStyle(
                                color: CommonColor.grayText,
                                fontFamily: "Montserrat-Medium",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 10,top: 150),
                child:   AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  left: _startAnimation ? 0 : -MediaQuery.of(context).size.width,
                  child: Container(

                    height: MediaQuery.of(context).size.height * 0.2,

                    width: MediaQuery.of(context).size.width *0.25,

                    child: Image(image: AssetImage('assets/images/estimation.png'),height: 100),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                bottom: _startAnimation ? 0 : -screenHeight * 0.5,
                left: 0,
                right: 0,
                child:Container(
                  height: MediaQuery.of(context).size.height * 0.5,

                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F5FF),
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),child:Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}*/




import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

class Estimation extends StatefulWidget {
  const Estimation({super.key});

  @override
  State<Estimation> createState() => _EstimationState();
}

class _EstimationState extends State<Estimation> {
  bool _startAnimation = false;
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _startAnimation = true;
      });
    });
  }
  int currentIndex = 0;

  final List<String> Price = [
    "11,400",
    "500",
    "345",
    "5000",
  ];
  final List<String> Labels = [
    "/Per Hour",
    "/Per Day",
    "/Per Week",
    "/Per Month"
  ];
  bool isDropdownOpenRent = false;

  bool isSelectedRent = false;


  final List<String> images = [
    'https://img.freepik.com/free-psd/shoes-sale-social-media-post-square-banner-template-design_505751-2862.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-vector/black-friday-sale-social-media-post-banner-home-appliance-product-instagram-post-banner-design_755018-930.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/drink-ad-nature-pear-juice_52683-34246.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-psd/ironing-machine-brand-product-social-media-banner_154386-123.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/sports-drink-advertisement_52683-430.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
  ];
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          ProductBigView(MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width),
        ],
      ),
    );
  }

  Widget ProductBigView(double parentWidth, double parentHeight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  SingleChildScrollView(
      child: SizedBox(

        height: MediaQuery.of(context).size.height *1.6,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [

            AnimatedPositioned(

              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: _startAnimation ? 0 : - screenHeight * 0.4,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3F5FF),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70.0),
                  ),
                ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back,
                                  color: Colors.black, size: 23)),
                          Text(
                            "ESTIMATION",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.0,
                              fontFamily: "okra_Medium",
                              fontSize:
                              SizeConfig.blockSizeHorizontal * 4.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Image(image: AssetImage('assets/images/more.png'),height:13,color: Colors.transparent)
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                              SizeConfig.screenHeight * 0.015,top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.1), // Shadow color
                                  blurRadius: 5, // Shadow blur
                                  offset: Offset(0,
                                      2), // Shadow position (x, y)
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 23.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 17.0,
                                  backgroundColor:
                                  Colors.transparent,
                                  backgroundImage: AssetImage(
                                      'assets/images/profiless.png')
                                // Profile image
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        // Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Listing ID:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "okra_Medium",
                                      fontSize: 14,
                                      letterSpacing: 0.9,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Text("  AB2345",
                                    style: TextStyle(
                                      color: Color(0xff3684F0),
                                      fontFamily: "okra_Regular",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            Text(
                                "Hi, John Doe",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Roboto_Regular",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                )
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(right: 2),
                      child: Padding(
                        padding:  EdgeInsets.all(14.0),
                        child:  Container(
                          width:250,
                          child: Text(
                            "Customize your product effortlessly and preview it instantly before confirming your choice",
                            style: TextStyle(
                              color: CommonColor.grayText,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              ),

            ),
            Padding(
              padding:  EdgeInsets.only(left: 10,top: 150),
              child:   AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                left: _startAnimation ? 0 : -MediaQuery.of(context).size.width,
                child: Container(

                  height: MediaQuery.of(context).size.height * 0.2,

                  width: MediaQuery.of(context).size.width *0.25,

                  child: Image(image: AssetImage('assets/images/estimation.png'),height: 100),
                ),
              ),
            ),
            AnimatedPositioned(
            /*  duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              right: _startAnimation ? 0 : -MediaQuery.of(context).size.width,
              top: 310,*/

              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              bottom: _startAnimation ? 0 : -screenHeight * 0.5,
              left: 0,
              right: 0,

              child: Container(
                height: MediaQuery.of(context).size.height *1.23 ,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3F5FF),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),child: Padding(
                padding:  EdgeInsets.only(top: 20,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Total Product Details",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 353,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),

                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Ensure text aligns at the top
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 22,left: 5),
                                    child: Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.12,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(4),

                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.13,
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/home.jpeg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),



                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Padding(
                                    padding:
                                    EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: parentWidth*0.20),
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                              color: Color(0xff3684F0),
                                              fontFamily:
                                              "okra_Medium",
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                            overflow: TextOverflow
                                                .ellipsis,

                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(top: 7,left: 2),
                                          child: Container(
                                             width: 180,
                                            child: Text(
                                             "HD Camera (black & White)",
                                              style: TextStyle(
                                                color: CommonColor
                                                    .Black,
                                                fontFamily:
                                                "okra_Medium",
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:  EdgeInsets.only(top: 7),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Icon(
                                                Icons
                                                    .location_on,
                                                size: SizeConfig
                                                    .screenHeight *
                                                    0.017,
                                                color: Color(
                                                    0xff3684F0),
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  ' MG ROAD, PUNE',
                                                  style:
                                                  TextStyle(
                                                    color: Color(
                                                        0xff3684F0),
                                                    fontFamily:
                                                    "okra_Regular",
                                                    fontSize:
                                                    SizeConfig.blockSizeHorizontal *
                                                        3.0,
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
                                        ),

                                        Padding(
                                          padding:  EdgeInsets.only(top: 3),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Icon(
                                                Icons
                                                    .phone,
                                                size: SizeConfig
                                                    .screenHeight *
                                                    0.017,
                                                color: CommonColor.grayText,
                                              ),
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  ' +919878765676',
                                                  style:
                                                  TextStyle(
                                                    color: CommonColor.grayText,
                                                    fontFamily: "Montserrat-Medium",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
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




                                ]),
                          ),


                          SizedBox(height: 40),

                          Container(
                            height: parentHeight*0.5,
                            width: parentWidth*0.43,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1)),
                            ],
                                borderRadius: BorderRadius.all(Radius.circular(10)),

                            ),child:  Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: 10),
                                  child: Align(
                                  alignment: Alignment.topCenter,
                                    child: Text(
                                    "CHOOSE TENURE FOR LISTENING",
                                    style: TextStyle(
                                        color: Color(0xfff44343),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto-Regular',
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            4.2),
                                                              ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(

                                        color: Color(0xffF3F5FF),
                                        borderRadius: BorderRadius.circular(7)),
                                    width: SizeConfig.screenWidth * 0.94,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isDropdownOpenRent =
                                          !isDropdownOpenRent;
                                          isSelectedRent =
                                          !isSelectedRent; // Toggle the selected state
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 13,
                                                    vertical: 10),
                                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 18,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Color(
                                                              0xff624ffa), // Outer circle color
                                                          width: 01,
                                                        ),
                                                      ),
                                                      child: isSelectedRent ||
                                                          isDropdownOpenRent
                                                          ? Center(
                                                        child: Container(
                                                          width:
                                                          10, // Inner circle size
                                                          height: 10,
                                                          decoration:
                                                          BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            color: Color(
                                                                0xff624ffa), // Inner circle color
                                                          ),
                                                        ),
                                                      )
                                                          : null,
                                                    ),

                                                    Text(
                                                      "32 Days",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          "Montserrat-BoldItalic",
                                                          color:
                                                          Color(0xff624ffa),
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                   /* SizedBox(
                                                        width:
                                                        10),*/
                                                    Padding(
                                                      padding:  EdgeInsets.only(right: 12),
                                                      child: Text(
                                                        "48 INR",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            "Montserrat-BoldItalic",
                                                            color:
                                                            Color(0xff624ffa),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),



                                                    // Dropdown Icon

                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(

                                        color: Color(0xffF3F5FF),
                                        borderRadius: BorderRadius.circular(7)),
                                    width: SizeConfig.screenWidth * 0.94,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isDropdownOpenRent =
                                          !isDropdownOpenRent;
                                          isSelectedRent =
                                          !isSelectedRent; // Toggle the selected state
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 13,
                                                    vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 18,
                                                      height: 18,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Color(
                                                              0xff624ffa), // Outer circle color
                                                          width: 01,
                                                        ),
                                                      ),
                                                      child: isSelectedRent ||
                                                          isDropdownOpenRent
                                                          ? Center(
                                                        child: Container(
                                                          width:
                                                          10, // Inner circle size
                                                          height: 10,
                                                          decoration:
                                                          BoxDecoration(
                                                            shape: BoxShape
                                                                .circle,
                                                            color: Color(
                                                                0xff624ffa), // Inner circle color
                                                          ),
                                                        ),
                                                      )
                                                          : null,
                                                    ),

                                                    Text(
                                                      "32 Days",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          "Montserrat-BoldItalic",
                                                          color:
                                                          Color(0xff624ffa),
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    /* SizedBox(
                                                        width:
                                                        10),*/
                                                    Padding(
                                                      padding:  EdgeInsets.only(right: 12),
                                                      child: Text(
                                                        "48 INR",
                                                        style: TextStyle(
                                                            fontFamily:
                                                            "Montserrat-BoldItalic",
                                                            color:
                                                            Color(0xff624ffa),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),



                                                    // Dropdown Icon

                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


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
            ),
          ],
        ),
      ),
    );


  }
}