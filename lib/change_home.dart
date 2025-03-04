import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'Admin/UserFeedback.dart';
import 'Admin/helpCentre.dart';
import 'Common_File/ResponsiveUtil.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'ConstantData/Constant_data.dart';
import 'MyBehavior.dart';
import 'ProductConfirmation.dart';
import 'SearchCatagries.dart';
import 'SideBar/My Collection.dart';
import 'SideBar/My Ratings.dart';
import 'SideBar/My Transaction History.dart';
import 'SideBar/MyFevorites.dart';
import 'SideBar/MyProfileDetails.dart';
import 'SideBar/chat.dart';
import 'addProductService.dart';
import 'location_map.dart';
import 'model/dio_client.dart';

class ChangeHome extends StatefulWidget {
  const ChangeHome({super.key});

  @override
  State<ChangeHome> createState() => _ChangeHomeState();
}

class _ChangeHomeState extends State<ChangeHome> {
  String? profileImage = GetStorage().read(ConstantData.UserProfileImage);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  String updatedCity = "No city selected";
  final ApiClients authService = ApiClients();
  BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Color(0xffaa4f7e), Color(0xffff937a)], // Default Gradient
    ),
  );



  void _changeBackground(int index) {
    setState(() {
      _backgroundDecoration = BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: index == 0
              ? [Color(0xffaa4f7e), Color(0xffff937a)]
              : [Color(0xffe4b4fb), Color(0xfffddfdf)],
        ),
      );
    });
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
                              builder: (context) => Myprofiledetails(option: () {  },)),
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
                                  child: Text(

                                      "Due for renewal",
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

                                  child: Text(

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
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
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
                  child: ListView(
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
                              child: Icon(Icons.dehaze_rounded, color: Colors.black),
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
                                        color: Colors.black,
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
                                        color: CupertinoColors.black,
                                      ),
                                      SizedBox(width: ResponsiveUtil.width(3)),
                                      Expanded(
                                        child: Text(
                                          "Opposite Sassoon Hospital, Station Road, Pune-411001",
                                          style: TextStyle(
                                            fontSize: ResponsiveUtil.fontSize(14),
                                            fontFamily: 'Poppins_Bold',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                            color: CupertinoColors.black,
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


                            SizedBox(width: ResponsiveUtil.width(10)), // Spacing before icon
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
                          child:
                          Row(
                            children: [
                              // Product Button
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () => _changeBackground(0), // Change BG on tap
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtil.height(9),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: selectedIndex == 0
                                          ? LinearGradient(
                                        colors: [Color(0xff632883), Color(0xff8d42a3)],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                      )
                                          : null,
                                      color: selectedIndex != 0 ? Colors.transparent : null,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Product",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-BoldItalic",
                                        color: selectedIndex == 0 ? Colors.white : Colors.black,
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
                                  onTap: () => _changeBackground(1), // Change BG on tap
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtil.height(9),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: selectedIndex == 1
                                          ? LinearGradient(
                                        colors: [
                                          Color(0xff435bf4),
                                          Color(0xff435bf4),
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                      )
                                          : null,
                                      color: selectedIndex != 1 ? Colors.transparent : null,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Service",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-BoldItalic",
                                        color: selectedIndex == 1 ? Colors.white : Colors.black,
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
                        padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                        child: Text(
                          "     ANYTHING ON RENT",
                          style: TextStyle(
                            fontFamily: "okra_extrabold",
                            fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.w200,
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
                            print("jjjjjjjj  $id");
                            bool success =
                            await authService.storeUserCity(
                              id!, // User ID
                              18.5204, // Latitude
                              73.8567, // Longitude
                              selectedCity, // City
                            );

                            if (success) {
                              print(
                                  "✅ City successfully updated in backend!");
                            } else {
                              print(
                                  "❌ Failed to update city in backend.");
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
                              top: SizeConfig.screenHeight * 0.0, left: 30),
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


                      HomeSearchBar(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),


                    ],
                  ),
                ),
              ],
            ),
          ],
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
            padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * .05,top: 10),
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
    return GestureDetector(
      onTap: () {
       /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => CreateProductService()));*/
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: parentWidth * 0.62,
            right: parentWidth * 0.09),
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


}
