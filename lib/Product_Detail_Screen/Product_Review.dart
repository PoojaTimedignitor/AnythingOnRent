/*
import 'dart:ui';

import 'package:flutter/material.dart';

import '../Common_File/new_responsive_helper.dart';
import 'Nearby_Product_Detail.dart';

class ProductReview extends StatefulWidget {
  const ProductReview({super.key});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {


  List<String> imageList = [
    "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg",
    "https://pune.accordequips.com/images/products/15ccb1ae241836.png",
    "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg",
    "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg",
    "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg",
  ];


  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 0, bottom: 0, right: 0),
                      child: Container(
                        width: responsive.width(responsive.isMobile
                            ? 290
                            : responsive.isTablet
                            ? 230
                            : 300),

                        /// new change
                        // width : 290,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          /// border responsive
                        ),
                        child: Column(
                          children: [
                            Container(
                              height:
                              responsive.height(responsive.isMobile
                                  ? 240
                                  : responsive.isTablet
                                  ? 250
                                  : 255),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        Stack(children: [
                                          Container(
                                            height: responsive.height(
                                                responsive.isMobile
                                                    ? 220
                                                    : responsive.isTablet
                                                    ? 240
                                                    : 230),
                                            // height: 220,                   /// Background Image height
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20)),

                                            child: ClipRRect(
                                              borderRadius:
                                              const BorderRadius.only(
                                                bottomLeft:
                                                Radius.circular(20),
                                                topLeft:
                                                Radius.circular(20),
                                                topRight:
                                                Radius.circular(20),
                                                bottomRight:
                                                Radius.circular(20),
                                              ),
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
                                                      "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg"),
                                                ],
                                                // autoplay: true,
                                                autoplay: false,
                                                dotSize: 5,
                                                dotSpacing: 10,
                                                dotColor: Colors.white,
                                                dotIncreasedColor:
                                                Colors.black45,
                                                indicatorBgPadding: 3.0,
                                                // animationDuration: Duration(milliseconds: 100),
                                                animationDuration:
                                                const Duration(
                                                    milliseconds: 0),
                                              ),
                                            ),
                                          ),
                                        ]
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );

                    /// Stack
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Common_File/new_responsive_helper.dart';

class ProductReview extends StatefulWidget {
  const ProductReview({super.key});

  @override
  State<ProductReview> createState() => _ProductReviewState();
}

class _ProductReviewState extends State<ProductReview> {

  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  List<String> imageList = [
    "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg",
    "https://pune.accordequips.com/images/products/15ccb1ae241836.png",
    "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg",
    "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg",
    "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    final borderRadius = BorderRadius.circular(20);


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: responsive.height(300),
                margin: responsive.getMargin(all: 0).copyWith(left: responsive.isMobile ? 10 : 4 , right: responsive.isMobile ? 10 : 4 , ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,          //imageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: responsive.width(responsive.isMobile ? 400 : 320),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(responsive.width(20)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(responsive.width(20)),
                        child: CarouselSlider.builder(
                          itemCount: imageList.length,
                          itemBuilder: (context, carouselIndex, realIndex) {
                            return GestureDetector(
                              onTap: () {
                                // Add navigation if needed
                              },
                              child: Image.network(
                                imageList[carouselIndex],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: responsive.height(250),
                            viewportFraction: 1.0,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            autoPlayInterval: Duration(seconds: 4),
                            autoPlayAnimationDuration:
                            Duration(milliseconds: 800),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                height: 350,
                margin: responsive.getMargin(all: 0).copyWith(left: responsive.isMobile ? 4 : 4, right: responsive.isMobile ? 4 : 4, ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[400],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Carousel Slider
                    Container(
                      height: responsive.height(290),
                      margin: responsive.getMargin(all: 0).copyWith(left: responsive.isMobile ? 10 : 4, right: responsive.isMobile ? 10 : 4,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(responsive.width(30)),
                        // color: Colors.red,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1, // Just to wrap Carousel
                        itemBuilder: (context, index) {
                          return Container(
                            width: responsive.width(responsive.isMobile ? 400 : 320),
                            decoration: BoxDecoration(
                             // color: Colors.pink,
                              borderRadius: BorderRadius.circular(responsive.width(20)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(responsive.width(20)),
                              child: CarouselSlider.builder(
                                itemCount: imageList.length,
                                itemBuilder: (context, carouselIndex, realIndex) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate or interact
                                    },
                                    child: Image.network(
                                      imageList[carouselIndex],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: responsive.height(250),
                                  viewportFraction: 1.0,
                                  autoPlay: false,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  autoPlayInterval: const Duration(seconds: 4),
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),




                    // Thumbnail List
                    Container(
                      height: responsive.height(60),
                      margin: responsive.getMargin(all: 0).copyWith(
                        left: responsive.isMobile ? 10 : 4,
                        right: responsive.isMobile ? 10 : 4,
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: responsive.width(80),
                            margin: EdgeInsets.symmetric(horizontal: responsive.width(5)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(responsive.width(10)),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(responsive.width(10)),
                              child: Image.network(
                                imageList[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),


              Container(
                margin: responsive.getMargin(all: 0).copyWith(left: responsive.isMobile ? 20 : 4 , right: responsive.isMobile ? 20 : 4 , top: responsive.isMobile ? 20 : 4 , ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Name",
                      style: GoogleFonts.merriweather(
                        fontSize: 14,
                       fontWeight: FontWeight.w600
                      ),
                    ),
                  //  const Text('Product Name'),
                    const Row(
                     // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text('Price'),
                          Text('Rent\n Sale')
                        ]
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
                            child:
                            Text(
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
                        Row(
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
                                    .black,
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
              ),

              Container(
                margin: responsive.getMargin(all: 0).copyWith(left: responsive.isMobile ? 15 : 4 , right: responsive.isMobile ? 20 : 4 , top: responsive.isMobile ? 20 : 4 , ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,  // Align RichText to the left
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Product Name\n',
                              style: GoogleFonts.merriweather(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: '₹ Price',
                              style: TextStyle(color: Colors.green[600], fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: responsive.height(
                            responsive.isMobile
                                ? 16
                                : responsive.isTablet
                                ? 17
                                : 18,
                          ),
                          width: responsive.width(responsive.isMobile ? 60 : 60),
                          padding: const EdgeInsets.only(left: 3, bottom: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(responsive.width(30)),
                            border: Border.all(
                              color: Colors.orange.shade400,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.shade100.withOpacity(0.2),
                                blurRadius: 6,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Pet World",
                              style: TextStyle(
                                fontSize: responsive.fontSize(responsive.isMobile ? 9 : 8),
                                color: const Color(0xFF1976D2),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Row(
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
                                    .black,
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

                    const Row(
                      children: [

                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}





