import 'dart:io';

import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:get_storage/get_storage.dart';

import '../ConstantData/Constant_data.dart';

class Myprofiledetails extends StatefulWidget {
  const Myprofiledetails({super.key});

  @override
  State<Myprofiledetails> createState() => _MyprofiledetailsState();
}

class _MyprofiledetailsState extends State<Myprofiledetails> {
  late final String firstname;
  late final String phoneNumber;
  late final String email;
  late final String profileImage;
@override
  void initState() {
  setState(() {
    print("Saved Mobile: ${GetStorage().read(ConstantData.UserProfileImage)}");

    firstname = GetStorage().read(ConstantData.UserFirstName) ?? "Guest";
    phoneNumber = GetStorage().read(ConstantData.UserMobile) ?? "Guest";
    email = GetStorage().read(ConstantData.Useremail) ?? "Guest";
     profileImage = GetStorage().read(ConstantData.UserProfileImage);

   // profileImage = GetStorage().read(ConstantData.UserProfileImage)?['image'] ;
  });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Details",
          style: TextStyle(
            fontFamily: "Montserrat-Medium",
            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
            color: CommonColor.TextBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  height: 300,
                  width: 400,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 240,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anythingsAdss.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 270),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anthingsAds.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: 250,
                  width: 400,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 290),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anyone.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 310),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anytwo.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Color(0xfff1f2fd),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                  //  borderRadius: BorderRadius.circular(15)
                  ),
              child: AllDetalisContaine(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
          )
        ],
      ),
    );
  }

  Widget AllDetalisContaine(double parentWidth, double parentHeight) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.33),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centers horizontally
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centers vertically
              children: [
                Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Shadow color
                          blurRadius: 5, // Shadow blur
                          offset: Offset(0, 2), // Shadow position (x, y)
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 32.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage: (profileImage != null && profileImage != "Guest")
                            ? NetworkImage(profileImage) // Use the NetworkImage if profileImage is not null and not "Guest"
                            : AssetImage('assets/images/profiless.png') as ImageProvider,
                       // Profile image
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width:
                        10), // Spacer between the CircleAvatar and "Edit" button
                Padding(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width * 0.22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      // Center the text inside the container
                      child: Text(
                        "Edit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat-Medium",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text("Listing ID:",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 16,
                  letterSpacing: 0.9,
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(height: 5),
          Center(
            child: Text("AB2345",
                style: TextStyle(
                  color: Color(0xff3684F0),
                  fontFamily: "okra_Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10,right: 10),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.9,

              decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Row

                    Row(
                      children: [
                        Flexible(
                          flex: 1, // Adjusts space for the label
                          child: Text('Name: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "okra_Medium",
                                fontSize: 15,

                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        SizedBox(width: 90),
                        Flexible(
                          flex: 2, // Adjusts space for the value
                          child: Text(
                            "$firstname", // Replace with actual user name
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Phone Row
                    Row(
                      children: [
                        Text('Phone Number: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: 15,
                              letterSpacing: 0.9,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(width: 15),
                        Flexible(
                          flex: 2, // Value takes up 2 parts
                          child: Text(
                            "$phoneNumber", // Replace with actual phone number
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Email Row
                    Row(
                      children: [
                        Flexible(
                          flex: 1, // Label takes up 1 part
                          child: Text('Email: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "okra_Medium",
                                fontSize: 15,
                                letterSpacing: 0.9,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        SizedBox(width: 90),
                        Flexible(
                          flex: 2, // Value takes up 2 parts
                          child: Container(
                            child: Text(
                              '$email', // Replace with actual email
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat-Medium",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Address Row
                    Row(
                      children: [
                        Flexible(
                          flex: 1, // Label takes up 1 part
                          child: Text('Address: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "okra_Medium",
                                fontSize: 15,
                                letterSpacing: 0.9,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        SizedBox(width: 70),
                        Flexible(
                          flex: 2, // Value takes up 2 parts
                          child: Text(
                            '123 Main Street, City, Country', // Replace with actual address
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
