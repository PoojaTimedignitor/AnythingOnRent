import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../change_home.dart';

class RecentlyaddedViewall extends StatefulWidget {
  const RecentlyaddedViewall({super.key});

  @override
  State<RecentlyaddedViewall> createState() => _RecentlyaddedViewallState();
}

class _RecentlyaddedViewallState extends State<RecentlyaddedViewall> {

  List<String> imageList = [
    "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg",
    "https://pune.accordequips.com/images/products/15ccb1ae241836.png",
    "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg",
    "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg",
    "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Full Width Image List'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:

      Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: ListView.builder(
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return
                  //   Stack(
                  //     children: [
                  //       Container(
                  //         height: 300,
                  //         width: double.infinity,
                  //         color: Colors.white70,
                  //       ),
                  //       Align(
                  //         alignment: Alignment.bottomCenter,
                  //         child: Container(
                  //           height: 50,
                  //           width: double.infinity,
                  //           decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black26,
                  //     blurRadius: 5,  //6,
                  //     spreadRadius: 10,  //1,
                  //     offset: Offset(0, 2),
                  //   ),
                  // ],
                  //             gradient: LinearGradient(
                  //               begin: Alignment.bottomCenter,
                  //               end: Alignment.topCenter,
                  //               colors: [
                  //              //   Colors.black.withOpacity(0.5), // Darkest at bottom
                  //                 Colors.black.withOpacity(0.0), // Fades upward
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   );

                    Stack(
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.white70,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 100, // larger height to show curvature
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  spreadRadius: 20,
                                  offset: Offset(0, 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );

                },
              ),
            ),
          ),
        ],
      ),

    );
  }
}
