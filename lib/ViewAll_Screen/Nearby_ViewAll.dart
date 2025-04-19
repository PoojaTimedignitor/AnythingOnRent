import 'dart:ui';

import 'package:anything/change_home.dart';
import 'package:flutter/material.dart';
import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../Common_File/new_responsive_helper.dart';
import '../SearchCatagries.dart';
import '../fff.dart';
import 'RatingBased_ViewAll.dart';
import 'RecentlyAdded_ViewAll.dart';
import 'Trending_ViewAll.dart';

class NearbyViewAll extends StatefulWidget {
  const NearbyViewAll({super.key});

  @override
  State<NearbyViewAll> createState() => _NearbyViewAllState();
}

class _NearbyViewAllState extends State<NearbyViewAll> {

  bool isBookMarked = false;

  bool isTapped = false;

  // List<bool> isBookmarkedList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   isBookmarkedList = List.generate(imageList.length, (index) => false);
  // }
  //
  // void toggleMarked(int index) {
  //   setState(() {
  //     isBookmarkedList[index] = !isBookmarkedList[index];
  //   });
  // }



  void toggleMarked() {
    /// new add for Favorite button
    setState(() {
      isBookMarked = !isBookMarked;
    });
  }

  List<String> imageList = [
    "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg",
    "https://pune.accordequips.com/images/products/15ccb1ae241836.png",
    "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg",
    "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg",
    "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg","https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg",
    "https://pune.accordequips.com/images/products/15ccb1ae241836.png",
    "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg",
    "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg",
    "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg",
  ];

  final List<String> imageNames = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 3',
    'Item 4',
  ];


  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    return  SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
        body:
            Column(
              children: [
                Row(
                  children: [
                     IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    HomeSearchBar(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
                  SizedBox(width: 10,),
                   AddPostButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ],
                ),


                Expanded(
                  child: Row(
                    children: [
                      /// LEFT COLUMN - 30% WIDTH
                     SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.15,
                       width: responsive.width(responsive.isMobile ? 80 : responsive.isTablet ? 370 : 420),                      /// new change
                       child: ListView.builder(
                         itemCount: imageList.length,
                         itemBuilder: (context, index) {
                           return GestureDetector(
                             onTap: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (_) => const ChangeHome()                           //YourNextPage(imageUrl: imageList[index]),
                                 ),
                               );
                             },
                             child: Column(
                               children: [
                                 Container(
                                   margin: responsive.getMargin(all: 0).copyWith(top: responsive.isMobile ? 8 : 4 , bottom: responsive.isMobile ? 8 : 4 , left: responsive.isMobile ? 8 : 4 , right: responsive.isMobile ? 8 : 4 , ),
                                   //margin: const EdgeInsets.all(8),
                                   height: 50,          //40,
                                   decoration: BoxDecoration(
                                     color: Colors.black38,
                                     borderRadius: BorderRadius.circular(10),
                                     image: DecorationImage(
                                       image: NetworkImage(imageList[index]),
                                       fit: BoxFit.cover,
                                     ),
                                     boxShadow: [
                                       BoxShadow(
                                         color: const Color(0xFF5D4037).withOpacity(0.8),
                                         blurRadius: 4,
                                         spreadRadius: 2,
                                         offset: const Offset(0, 3),
                                       ),
                                     ],
                                   ),
                                 ),
                                 Text(
                                   imageNames[index],
                                   style: const TextStyle(fontSize: 12),
                                   overflow: TextOverflow.ellipsis,
                                 ),

                                 const SizedBox(height: 8,),
                               ],
                             ),

                           );
                         },
                       ),
                     ),
                      /// RIGHT COLUMN - 70% WIDTH

                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 50,
                        width: 2,
                        color: Colors.green,
                      ),

                      Expanded(
                        child: Padding(
                         // padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          padding: responsive.getPadding(all: 0).copyWith(left: responsive.isMobile ? 10 : 30, top: responsive.isMobile ? 3 : 5, right: responsive.isMobile ? 5 : 3),              /// new add responsive padding
                          child: ListView.builder(
                            itemCount: imageList.length,
                            itemBuilder: (context, index) {
                              return
                                Stack(
                                    children:[
                                      Container(
                                        height: 200,
                                        margin: const EdgeInsets.symmetric(vertical: 7,),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.orange.shade100.withOpacity(0.2),
                                          //     blurRadius: 6,
                                          //     spreadRadius: 2,
                                          //     offset: const Offset(0, 2),
                                          //   ),
                                          // ],
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          imageList[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),



                                      Positioned(
                                        top: responsive.isMobile
                                            ? 160
                                            : responsive.isTablet
                                            ? 0
                                            : 0,
                                        left: responsive.isMobile
                                            ? 0
                                            : responsive.isTablet
                                            ? 0
                                            : 0,
                                        right: responsive.isMobile
                                            ? 0
                                            : responsive.isTablet
                                            ? 290
                                            : 275,
                                        bottom: responsive.isMobile
                                            ? 7
                                            : responsive.isTablet
                                            ? 0
                                            : 0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                responsive.width(15)),
                                            topLeft: Radius.circular(
                                                responsive.width(0)),
                                            topRight: Radius.circular(
                                                responsive.width(0)),
                                            bottomRight: Radius.circular(
                                                responsive.width(15)),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                               // color: Colors.black.withOpacity(0.4),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black87.withOpacity(0.2),
                                                      Colors.black45.withOpacity(0.4),
                                                     // Colors.black38.withOpacity(0.1),
                                                      Colors.black87.withOpacity(0.2),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                padding: EdgeInsets.only(left: 6, right: 6),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text('Product Name',  style:
                                                        TextStyle(
                                                          fontSize: responsive.fontSize(
                                                              responsive.isMobile
                                                                  ? 10
                                                                  : 9), // responsive.fontSize(12),
                                                          // color: const Color(0xff3684F0),
                                                          color: Colors
                                                              .white,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                        ),
                                                          maxLines: 1,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,),
                                                        Text('₹10000/day', style: TextStyle(
                                                          fontSize: responsive.fontSize(
                                                              responsive.isMobile
                                                                  ? 10
                                                                  : 9), // responsive.fontSize(12),
                                                          // color: const Color(0xff3684F0),
                                                          color: Colors
                                                              .white,
                                                          fontWeight:
                                                          FontWeight
                                                              .w900,
                                                        ),
                                                          maxLines: 1,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,)
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: responsive.height(responsive
                                                              .isMobile
                                                              ? 16
                                                              : responsive.isTablet
                                                              ? 17
                                                              : 18),

                                                          /// new change
                                                          width: responsive.width(responsive
                                                              .isMobile
                                                              ? 60
                                                              : responsive.isTablet
                                                              ? 60
                                                              : 60),
                                                          padding: const EdgeInsets
                                                              .only(
                                                              left:
                                                              3,
                                                              bottom:
                                                              0),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors
                                                                .white,
                                                            borderRadius:
                                                            BorderRadius.circular(responsive.width(30)),
                                                            border:
                                                            Border.all(
                                                              color: Colors
                                                                  .orange
                                                                  .shade400,
                                                              width:
                                                              1,
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                Colors.orange.shade100.withOpacity(0.2),
                                                                blurRadius:
                                                                6,
                                                                spreadRadius:
                                                                2,
                                                                offset:
                                                                const Offset(0, 2),
                                                              ),
                                                            ],
                                                          ),
                                                          child:
                                                          Center(
                                                            child: Text(
                                                              "Pet World",
                                                              style:
                                                              TextStyle(
                                                                fontSize: responsive.fontSize(responsive.isMobile
                                                                    ? 9
                                                                    : 8), // responsive.fontSize(12),
                                                                // color: const Color(0xff3684F0),
                                                                color:
                                                                const Color(0xFF1976D2),
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              maxLines:
                                                              1,
                                                              overflow:
                                                              TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'API 1',
                                                          style: TextStyle(
                                                            //fontSize: 8,
                                                            fontSize: responsive
                                                                .fontSize(responsive
                                                                .isMobile
                                                                ? 10
                                                                : 7), // responsive.fontSize(12),
                                                            // color: const Color(0xff3684F0),
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),

                                                      ],
                                                    ),

                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'API 3',
                                                              style: TextStyle(
                                                                //fontSize: 8,
                                                                fontSize: responsive
                                                                    .fontSize(responsive
                                                                    .isMobile
                                                                    ? 8
                                                                    : 7), // responsive.fontSize(12),
                                                                // color: const Color(0xff3684F0),
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            const SizedBox(width: 12,),
                                                            Text(
                                                              'API 3',
                                                              style: TextStyle(
                                                                //fontSize: 8,
                                                                fontSize: responsive
                                                                    .fontSize(responsive
                                                                    .isMobile
                                                                    ? 8
                                                                    : 7), // responsive.fontSize(12),
                                                                // color: const Color(0xff3684F0),
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),

                                                            const SizedBox(width: 70,),
                                                            Text(
                                                              '1 day ago',
                                                              style: TextStyle(
                                                                //fontSize: 8,
                                                                fontSize: responsive
                                                                    .fontSize(responsive
                                                                    .isMobile
                                                                    ? 8
                                                                    : 7), // responsive.fontSize(12),
                                                                // color: const Color(0xff3684F0),
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          // crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .location_on,
                                                                size: responsive.width(responsive.isMobile
                                                                    ? 14
                                                                    : 11),
                                                                // color: const Color(0xff3684F0),
                                                                color: Colors
                                                                    .blue),
                                                            SizedBox(
                                                                width: responsive
                                                                    .width(2)), // Small spacing
                                                            Text(
                                                              "Pune, India",
                                                              style:
                                                              TextStyle(
                                                                fontSize: responsive.fontSize(responsive.isMobile
                                                                    ? 10
                                                                    : 9), // responsive.fontSize(12),
                                                                // color: const Color(0xff3684F0),
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                FontWeight.w500,
                                                              ),
                                                              maxLines:
                                                              1,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                              )

                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: responsive.isMobile ? 12 : 0,
                                        left: responsive.isMobile ? 0 : 0,
                                        right: responsive.isMobile ? 380 : 0,
                                        bottom: responsive.isMobile ? 200 : 0,
                                        child:
                                        // IconButton(
                                        //   onPressed: () => toggleMarked(index),
                                        //   icon: Icon(
                                        //     isBookmarkedList[index] ? Icons.bookmark : Icons.bookmark_border_sharp,
                                        //     color: isBookmarkedList[index] ? const Color(0xFFF9A825) : Colors.white,
                                        //   ),
                                        // ),

                                        IconButton(
                                            onPressed: toggleMarked,
                                            icon: Icon(
                                              isBookMarked
                                                  ? Icons.bookmark
                                                  : Icons
                                                  .bookmark_border_sharp,
                                              //  size: 20,
                                              color: isBookMarked
                                                  ? const Color(
                                                  0xFFF9A825)
                                                  : Colors.white,
                                            )),
                                      ),

                                    ]
                                );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget AddPostButton(double parentHeight, double parentWidth) {

    final responsive = ResponsiveHelper(context);

    return  GestureDetector(
      onTap: () {
        setState(() {
          isTapped = true;
        });

        // Reset back to original after delay (e.g., 500ms)
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              isTapped = false;
            });
          }
        });

        // Navigate after a little longer delay
        Future.delayed(const Duration(milliseconds: 700), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComingSoonScreen()),
          );
        });
      },

      child: Container(
        padding: responsive.getPadding(all: 0).copyWith(left: 5, right: 5, top: 7),
        margin: responsive.getMargin(all: 0).copyWith(left: 0, right: 0),
        height: responsive.height(
          responsive.isMobile ? 50 : responsive.isTablet ? 80 : 100,
        ),
        width: responsive.width(
          responsive.isMobile ? 110 : responsive.isTablet ? 400 : 450,
        ),
        child: Stack(
          children: [
            // Orange Gradient Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: responsive.getPadding(all: 0).copyWith(left: 0, right: 2),
                  height: responsive.height(
                      responsive.isMobile ? 30 : responsive.isTablet ? 50 : 60),
                  width: responsive.width(
                      responsive.isMobile ? 80 : responsive.isTablet ? 160 : 180),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFBC02D), Color(0xFFE65100)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),

            // Glassy Text Overlay with Animation
           /* AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              top: responsive.height(
                  isTapped ? (responsive.isMobile ? 0 : 2) : (responsive.isMobile ? 5 : 4)),
              left: responsive.width(
                  isTapped ? (responsive.isMobile ? 0 : 0) : (responsive.isMobile ? 5 : 180)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.blue.withOpacity(0.4),
                      ),
                    ),
                    Container(
                      color: Colors.black54.withOpacity(0.4),
                      padding: responsive.getPadding(all: 0).copyWith(
                        top: 5,
                        left: 8,
                        right: 7,
                        bottom: responsive.isMobile ? 9 : 10,
                      ),
                      child: Center(
                        child: Text(
                          'Create Post +',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            responsive.fontSize(responsive.isMobile ? 11.3 : 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/

            // Glassy Text Overlay with Animation
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              top: responsive.height(
                  isTapped ? (responsive.isMobile ? 0 : 2) : (responsive.isMobile ? 5 : 4)),
              left: responsive.width(
                  isTapped ? (responsive.isMobile ? 0 : 0) : (responsive.isMobile ? 5 : 180)),
              child: AnimatedScale(
                scale: isTapped ? 0.95 : 1.0, // subtle press scale
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: isTapped ? 6 : 3, // stronger blur on tap
                          sigmaY: isTapped ? 6 : 3,
                        ),
                        child: Container(
                          color: Colors.blue.withOpacity(isTapped ? 0.5 : 0.4),
                        ),
                      ),
                      Container(
                        color: Colors.black54.withOpacity(isTapped ? 0.5 : 0.4),
                        padding: responsive.getPadding(all: 0).copyWith(
                          top: 5,
                          left: 8,
                          right: 7,
                          bottom: responsive.isMobile ? 9 : 10,
                        ),
                        child: Center(
                          child: Text(
                            'Create Post +',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.fontSize(
                                  responsive.isMobile ? 11.5 : 12),
                              color: Colors.black87.withOpacity(isTapped ? 1 : 0.9),
                            ),
                          ),
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
     /* GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AnimatedCreatePost()),
        );
      },
      child: Container(
        padding: responsive.getPadding(all: 0).copyWith(left: 5, right: 5, top: 7 ),
        margin: responsive.getMargin(all: 0).copyWith(left: 0, right: 0),

        //color :  Color(0xFFFFEBEE),
        height: responsive.height(
          responsive.isMobile ? 50 : responsive.isTablet ? 80 : 100,
        ),
        //width: double.infinity,
        width: responsive.width(
          responsive.isMobile ? 110 : responsive.isTablet ? 400 : 450,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: responsive.getPadding(all: 0).copyWith(left: 0, right: 2),
                //  margin: responsive.getMargin(all: 0).copyWith(left: 10, right: 10),
                  height: responsive.height(responsive.isMobile ? 30 : responsive.isTablet ? 50 : 60),
                  width: responsive.width(responsive.isMobile ? 80 : responsive.isTablet ? 160 : 180),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFBC02D), Color(0xFFE65100)],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),

            /// Positioned Glass Effect and Text
            Positioned(
              top: responsive.height(responsive.isMobile ? 5 : 4),
              left: responsive.width(responsive.isMobile ? 5 : 180),
             // bottom: responsive.height(responsive.isMobile ? 2 : 6),
              //right: responsive.width(responsive.isMobile ? 4 : 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.blue.withOpacity(0.4),
                      ),
                    ),
                    Container(
                      color: Colors.black54.withOpacity(0.4),
                    //  margin: responsive.getMargin(all: 5),
                      padding: responsive.getPadding(all: 0).copyWith(
                        top: 5,
                        left: 8,
                        right: 7,
                        bottom: responsive.isMobile ? 9 : 10,
                      ),
                      child: Center(
                        child: Text(
                          'Create Post +',
                          style: TextStyle(
                            //color:  Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.fontSize(
                              responsive.isMobile ? 11.3 : 16,
                            ),
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
      ),
    );*/
  }


  Widget HomeSearchBar(double parentHeight, double parentWidth) {
    final responsive = ResponsiveHelper(context);

    bool _isTapped = false;

    /// addd here ResponsiveHelper

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecentSearchesScreen()),
        );
      },
      child: Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // height: SizeConfig.screenHeight * .053,
            height: responsive.height(responsive.isMobile
                ?  35               //35
                : responsive.isTablet
                ? 30
                : 25),

            ///  Add new change
            width: responsive.width(responsive.isMobile
                ? 200
                : responsive.isTablet
                ? 315
                : 280),

            /// new change
            // width: SizeConfig.screenWidth * .95,
            child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Colors.black.withOpacity(0.6),
                  // border: Border.all(color: Colors.black26, width: 0.5),
                  borderRadius: BorderRadius.circular(20),

                  /// new add
                  border: Border.all(
                    color: Colors.orange.shade400,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade400.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],

                  ///
                ),
                child: Row(
                  children: [
                    //SizedBox(width: 10),
                    SizedBox(
                      width: responsive.width(10),
                    ),



                    const Icon(Icons.search_rounded, color: Colors.white70, size: 20,),

                    Text(
                      " Search Product",
                      style: TextStyle(
                        fontFamily: "Roboto_Regular",
                        //fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        fontSize: responsive
                            .fontSize(responsive.isMobile ? 14 : 8),

                        /// new change
                        color: CommonColor.SearchBar,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

}






class CreatePostButton extends StatefulWidget {
  const CreatePostButton({super.key});

  @override
  State<CreatePostButton> createState() => _CreatePostButtonState();
}

class _CreatePostButtonState extends State<CreatePostButton> {
  bool snapped = false;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);


    final double mobileTop = responsive.height(5);
    final double mobileLeft = responsive.width(5);
    final double desktopTop = responsive.height(4);
    final double desktopLeft = responsive.width(180);

    return SafeArea(
      child: GestureDetector(
        onTap: () async {
          setState(() => snapped = true);
      
          await Future.delayed(const Duration(milliseconds: 200));
      
          setState(() => snapped = false);
      
          // Navigate to next screen after animation
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageRotator()),
            );
          });
        },
        child: Container(
          padding: responsive.getPadding(all: 0).copyWith(left: 5, right: 5, top: 7),
          margin: responsive.getMargin(all: 0).copyWith(left: 0, right: 0),
          height: responsive.height(
            responsive.isMobile ? 50 : responsive.isTablet ? 80 : 100,
          ),
          width: responsive.width(
            responsive.isMobile ? 110 : responsive.isTablet ? 400 : 450,
          ),
          child: Stack(
            children: [
              /// Background gradient container
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: responsive.getPadding(all: 0).copyWith(left: 0, right: 2),
                    height: responsive.height(
                        responsive.isMobile ? 30 : responsive.isTablet ? 50 : 60),
                    width: responsive.width(
                        responsive.isMobile ? 80 : responsive.isTablet ? 160 : 180),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFBC02D), Color(0xFFE65100)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
      
              /// Animated Positioned glass effect container
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: snapped ? mobileTop : desktopTop,
                left: snapped ? mobileLeft : desktopLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          color: Colors.blue.withOpacity(0.4),
                        ),
                      ),
                      Container(
                        color: Colors.black54.withOpacity(0.4),
                        padding: responsive.getPadding(all: 0).copyWith(
                          top: 5,
                          left: 8,
                          right: 7,
                          bottom: responsive.isMobile ? 9 : 10,
                        ),
                        child: Center(
                          child: Text(
                            'Create Post +',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.fontSize(
                                responsive.isMobile ? 11.3 : 16,
                              ),
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
        ),
      ),
    );
  }
}





class AnimatedCreatePost extends StatefulWidget {
  const AnimatedCreatePost({super.key});

  @override
  State<AnimatedCreatePost> createState() => _AnimatedCreatePostState();
}

class _AnimatedCreatePostState extends State<AnimatedCreatePost> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isTapped = true;
          });

          // Reset back to original after delay (e.g., 500ms)
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              setState(() {
                isTapped = false;
              });
            }
          });

          // Navigate after a little longer delay
          Future.delayed(const Duration(milliseconds: 700), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageRotator()),
            );
          });
        },

        child: Container(
          padding: responsive.getPadding(all: 0).copyWith(left: 5, right: 5, top: 7),
          margin: responsive.getMargin(all: 0).copyWith(left: 0, right: 0),
          height: responsive.height(
            responsive.isMobile ? 50 : responsive.isTablet ? 80 : 100,
          ),
          width: responsive.width(
            responsive.isMobile ? 110 : responsive.isTablet ? 400 : 450,
          ),
          child: Stack(
            children: [
              // Orange Gradient Pill
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: responsive.getPadding(all: 0).copyWith(left: 0, right: 2),
                    height: responsive.height(
                        responsive.isMobile ? 30 : responsive.isTablet ? 50 : 60),
                    width: responsive.width(
                        responsive.isMobile ? 80 : responsive.isTablet ? 160 : 180),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFBC02D), Color(0xFFE65100)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
      
              // Glassy Text Overlay with Animation
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                top: responsive.height(
                    isTapped ? (responsive.isMobile ? 0 : 2) : (responsive.isMobile ? 5 : 4)),
                left: responsive.width(
                    isTapped ? (responsive.isMobile ? 0 : 0) : (responsive.isMobile ? 5 : 180)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          color: Colors.blue.withOpacity(0.4),
                        ),
                      ),
                      Container(
                        color: Colors.black54.withOpacity(0.4),
                        padding: responsive.getPadding(all: 0).copyWith(
                          top: 5,
                          left: 8,
                          right: 7,
                          bottom: responsive.isMobile ? 9 : 10,
                        ),
                        child: Center(
                          child: Text(
                            'Create Post +',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                              responsive.fontSize(responsive.isMobile ? 11.3 : 16),
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
        ),
      ),
    );
  }
}





class AnimatedCreatePostA extends StatefulWidget {
  const AnimatedCreatePostA({super.key});

  @override
  State<AnimatedCreatePostA> createState() => _AnimatedCreatePostAState();
}

class _AnimatedCreatePostAState extends State<AnimatedCreatePostA> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // from right to left
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleTap() {
    setState(() {
      isTapped = true;
    });
    _controller.forward(from: 0);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isTapped = false;
        });
        _controller.reverse();
      }
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImageRotator()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return SafeArea(
      child: GestureDetector(
        onTap: handleTap,
        child: Container(
          padding: responsive.getPadding(all: 0).copyWith(left: 5, right: 5, top: 7),
          margin: responsive.getMargin(all: 0).copyWith(left: 0, right: 0),
          height: responsive.height(
              responsive.isMobile ? 50 : responsive.isTablet ? 80 : 100),
          width: responsive.width(
              responsive.isMobile ? 110 : responsive.isTablet ? 400 : 450),
          child: Stack(
            children: [
              // Orange Gradient Pill
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: responsive.getPadding(all: 0).copyWith(left: 0, right: 2),
                    height: responsive.height(
                        responsive.isMobile ? 30 : responsive.isTablet ? 50 : 60),
                    width: responsive.width(
                        responsive.isMobile ? 80 : responsive.isTablet ? 160 : 180),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFBC02D), Color(0xFFE65100)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),

              // Slide + Fade Glassy Text Overlay
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    top: responsive.height(
                        isTapped ? (responsive.isMobile ? 0 : 2) : (responsive.isMobile ? 5 : 4)),
                    left: responsive.width(
                        responsive.isMobile ? 0 : (isTapped ? 0 : 180)),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: Container(
                                  color: Colors.blue.withOpacity(0.4),
                                ),
                              ),
                              Container(
                                color: Colors.black54.withOpacity(0.4),
                                padding: responsive.getPadding(all: 0).copyWith(
                                  top: 5,
                                  left: 8,
                                  right: 7,
                                  bottom: responsive.isMobile ? 9 : 10,
                                ),
                                child: Center(
                                  child: Text(
                                    'Create Post +',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.fontSize(
                                          responsive.isMobile ? 11.3 : 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}











// ListView.builder(
//   itemCount: imageList.length,
//   itemBuilder: (context, index) {
//     return Stack(
//       children: [
//         Container(
//           height: 200,
//           margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.orange.shade100.withOpacity(0.2),
//                 blurRadius: 6,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           clipBehavior: Clip.hardEdge,
//           child: Image.network(
//             imageList[index],
//             fit: BoxFit.cover,
//           ),
//         ),
//
//         // Continue your Positioned widgets here (the glass info container, bookmark, etc.)
//         // Keep everything exactly as you had it earlier inside the ListView.builder
//         // ...
//       ],
//     );
//   },
// ),