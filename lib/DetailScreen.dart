import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

import 'Common_File/common_color.dart';
import 'MyBehavior.dart';
import 'ResponseModule/getAllProductList.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'dummytwo.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'dart:ui' as ui;
import 'dart:ui';

class DetailScreen extends StatefulWidget {
  final Products product;

  const DetailScreen({required this.product});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  late Animation<double> _animation;
  late AnimationController _controllerss;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isVisible = true;



  final List<String> imageUrls = [
    'https://img.freepik.com/free-psd/shoes-sale-social-media-post-square-banner-template-design_505751-2862.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-vector/black-friday-sale-social-media-post-banner-home-appliance-product-instagram-post-banner-design_755018-930.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/drink-ad-nature-pear-juice_52683-34246.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-psd/ironing-machine-brand-product-social-media-banner_154386-123.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/free-vector/sports-drink-advertisement_52683-430.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid',
    'https://img.freepik.com/premium-vector/cosmetics-realistic-package-ads-template_1268-2880.jpg?uid=R160153524&ga=GA1.1.2033069531.1724674585&semt=ais_hybrid'
  ];


  final List<String> Price = [
    "100",
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
  // bool isOpen = false;

  @override
  void initState() {
    super.initState();

    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward(); // Start the animation

    // Define scaling animation from 0 to 1
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerss, curve: Curves.easeOutBack),
    );

    // Animation Controller
    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      upperBound: 2.0, // Loop exactly 2 times
    );

    _controllerss.forward().whenComplete(() {
      // Hide animation after 2 loops
      setState(() {
        _isVisible = false;
      });
    });
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controllerss.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productImages = widget.product.images ?? [];
    final double screenWidth = MediaQuery.of(context).size.width;

    return PageStorage(
      bucket: bucket,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Stack(
                children: [
                  Hero(
                    tag: widget.product.sId
                        .toString(), // Ensure tag matches in both screens
                    child: PageStorage(
                      bucket: bucket,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.41,
                            decoration: BoxDecoration(
                              color: Color(0xffF5F6FB),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            width: double.infinity, // Ensure a finite width
                            height: MediaQuery.of(context).size.height * 0.40,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CarouselSlider.builder(
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .4,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: false,
                                      autoPlay: false,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                    ),
                                    itemBuilder: (BuildContext context,
                                        int itemIndex, int index1) {
                                      final imgUrl =
                                          productImages[index1].url ?? "";

                                      return GestureDetector(
                                        onTap: () {
                                          // Show image in a dialog on tap
                                          showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                              child: Stack(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => Navigator.pop(context),
                                                    child: Container(
                                                      height: SizeConfig.screenHeight * 0.5,
                                                      width: screenWidth ,// 80% of the screen height

                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(2),
                                                        image: DecorationImage(
                                                          image: NetworkImage(imgUrl),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(

                                                    right: 16,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () => Navigator.pop(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(imgUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    for (int i = 0;
                                        i < productImages.length;
                                        i++)
                                      currentIndex == i
                                          ? Container(
                                              width: 25,
                                              height: 7,
                                              margin: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color(0xff675397),
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
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    productImages.length > 5
                                        ? 5
                                        : productImages
                                            .length, // Limit to 5 images
                                    (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _controller.animateToPage(index);
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: currentIndex == index
                                                      ? Color(0xffFE7F64)
                                                      : Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      productImages[index]
                                                              .url ??
                                                          ""),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 0,
                    left: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                      right: 20,
                      top: 35,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: CommonColor.grayText, width: 0.5),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.1), // Shadow color
                              blurRadius: 5, // Shadow blur
                              offset: Offset(0, 2), // Shadow position (x, y)
                            ),
                          ],
                        ),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      )),
                  Positioned(
                      left: 10,
                      top: 210,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                children: [
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
                                          SizeConfig.blockSizeHorizontal * 2.9,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                          ),
                        ),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.42),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: SizeConfig.screenWidth * 0.14,
                              height: 22,
                              decoration: BoxDecoration(
                                  color: Color(0xff5E9C73),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: SizeConfig.screenHeight * 0.019,
                                    color: CommonColor.white,
                                  ),
                                  Text(
                                    "4.5",
                                    /* filteredItems[index].rating.toString(),*/
                                    style: TextStyle(
                                      fontFamily: "Roboto-Regular",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.3,
                                      color: CommonColor.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 18, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "HD Camera (black & white) or all Color",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "okra_Medium",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      size: SizeConfig.screenHeight * 0.019,
                                      color: CommonColor.Blue),
                                  Flexible(
                                    child: Text(
                                      ' Park Street,pune banner 20023',
                                      style: TextStyle(
                                        color: CommonColor.Blue,
                                        fontFamily: "Montserrat-Medium",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(width: 66),
                                ],
                              ),
                              SizedBox(height: 5),
                              RichText(
                                  text: TextSpan(
                                      text: "Last updated on  ",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto-Regular',
                                          fontSize: 14),
                                      children: [
                                    TextSpan(
                                      text: "10 Jun '24",
                                      style: TextStyle(
                                          color: Color(0xffFE7F64),
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.underline,
                                          decorationColor: Color(0xffFE7F64),
                                          fontFamily: 'Roboto-Regular',
                                          fontSize: 15),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    )
                                  ])),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text("Share",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Montserrat-Medium",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(width: 9),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: CommonColor.grayText,
                                          width: 0.3),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.share,
                                        color: CommonColor.grayText,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18),
                              Padding(
                                padding:  EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xffFE7F64)
                                                  .withOpacity(0.3),
                                              width: 1.7),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Stack(
                                        alignment: Alignment
                                            .center, // Align content in the center
                                        children: [
                                          // Border Animation
                                          Visibility(
                                            visible: _isVisible,
                                            child: AnimatedBuilder(
                                              animation: _controllerss,
                                              builder: (context, child) {
                                                return CustomPaint(
                                                  painter: SnakeBorderPainter(
                                                      progress:
                                                          _controllerss.value %
                                                              1),
                                                  size: Size(150, 50), // Ensure the CustomPaint matches the Container
                                                );
                                              },
                                            ),
                                          ),
                                          // Text always visible
                                          ScaleTransition(
                                            scale: _scaleAnimation,
                                            child: Center(
                                                child:

                                                GradientText(
                                                  "TO RENT",
                                                    style: TextStyle(

                                                      fontFamily:
                                                      "poppins_Regular",
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                        2.9 ,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  colors: [
                                                    Color(0xffFD6848),

                                                    Color(0xffFF8E76),

                                                  ],
                                                ),


                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child:     Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Color(0xffFE7F64)
                                                    .withOpacity(0.3),
                                                width: 1.7),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Stack(
                                          alignment: Alignment
                                              .center, // Align content in the center
                                          children: [
                                            // Border Animation
                                            Visibility(
                                              visible: _isVisible,
                                              child: AnimatedBuilder(
                                                animation: _controllerss,
                                                builder: (context, child) {
                                                  return CustomPaint(
                                                    painter: SnakeBorderPainter(
                                                        progress:
                                                        _controllerss.value %
                                                            1),
                                                    size: Size(150, 50), // Ensure the CustomPaint matches the Container
                                                  );
                                                },
                                              ),
                                            ),
                                            // Text always visible
                                            ScaleTransition(
                                              scale: _scaleAnimation,
                                              child: Center(
                                                child:

                                                GradientText(
                                                  "TO SELL",
                                                  style: TextStyle(

                                                    fontFamily:
                                                    "poppins_Regular",
                                                    fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                        2.9 ,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                  colors: [
                                                    Color(0xffFD6848),

                                                    Color(0xffFF8E76),

                                                  ],
                                                ),


                                                /* Text("TO RENT",
                                                    style: TextStyle(
                                                      color: CommonColor.Black,
                                                      fontFamily:
                                                          "poppins_Regular",
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          2.6,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ))
                                            */
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 1),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffF5F6FB),
                              ),
                              child: Container(
                                height: 129,
                                margin: EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "EXCLUSIVE PRICE",
                                        style: TextStyle(
                                          color: CommonColor.Blue,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Roboto-Regular',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: Price.length,
                                        itemBuilder: (context, index) {
                                          return IntrinsicWidth(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment
                                                                .bottomRight,
                                                            end: Alignment
                                                                .bottomLeft,
                                                            colors: [
                                                              Color(0xffFfffff),
                                                              Color(0xff8db1fd),
                                                            ]),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff675397),
                                                            width: 0.4),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    14))),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.0),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 7, top: 4),
                                                    child: Text(
                                                      "Price",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "okra_Regular",
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 23),
                                                    child: Container(
                                                      height: 85,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xff675397),
                                                              width: 0.4),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(14),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          14),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      14))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "₹" +
                                                                      Price[
                                                                          index],
                                                                  style:
                                                                      TextStyle(
                                                                    color: CommonColor
                                                                        .Black,
                                                                    fontFamily:
                                                                        "okra_Medium",
                                                                    fontSize:
                                                                        19,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 8),
                                                                Text(
                                                                  Labels[index],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              "Up to Last Updated",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontFamily:
                                                                    "okra_Regular",
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: SizeConfig.screenHeight * 0.0005,
                          color: CommonColor.grays,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 9, top: 13),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                //isOpen = !isOpen; // Toggle the dropdown state
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                // : Color(0xffF1E7FB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 366,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "About This Item",
                                          style: TextStyle(
                                            color: Color(0xff675397),
                                            fontFamily: "okra_Medium",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        /*  Icon(
                                          isOpen
                                              ? Icons.arrow_drop_up
                                              : Icons.arrow_drop_down,
                                          color: Color(0xff675397),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffF5F6FB),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Text(
                                          " Model :  Honda 12056 "
                                          "This is the detailed information about this item. "
                                          "You can customize this text as needed."
                                          "A product description is a piece of marketing copy that explains a product's features and benefits, and why it's worth buying."
                                          "You can customize this text as needed",
                                          style: TextStyle(
                                            fontFamily: "poppins_Regular",
                                            color: Color(0xff7D7B7B),
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.5,
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
                        SizedBox(height: 40),



            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 100.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 10 / 9,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.7,
                ),
                items:
                imageUrls.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child:  Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),   SizedBox(height: 30),

                        Stack(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 18, left: 15, right: 15),
                              child: Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomCenter,
                                    stops: [0.2, 0.9],
                                    colors: [
                                      Color(0xffFFFfff),
                                      Color(0xffffe9e9),
                                    ],
                                  ),
                                  border: Border.all(
                                      color: Color(0xffFFA194), width: 0.9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text("SELLER DETALIS",
                                          style: TextStyle(
                                            color: Color(0xffFF553E),
                                            fontFamily: "okra_extrabold",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    Image(
                                        image: AssetImage(
                                            'assets/images/seller.png'),
                                        height: 30),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 60, left: 20, right: 20),
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeConfig.screenHeight * 0.015),
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
                                          radius: 25.0,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                              radius: 20.0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(
                                                  'assets/images/profiless.png')
                                              // Profile image
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 25, left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Text("Username",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Roboto_Regular",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, left: 16),
                                      child: Container(
                                        height: 45,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                color: Color(0xffF8C5C2),
                                                width: 0.5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.chat,
                                                color: Color(0xffFE7F64),
                                                size: 20,
                                              ),
                                              Text(
                                                "Chat",
                                                style: TextStyle(
                                                  color: Color(0xffFE7F64),
                                                  fontFamily: "okra_Medium",
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2.8,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 13, top: 5),
                                      child: Container(
                                        height: 45,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                color: Color(0xffF8C5C2),
                                                width: 0.5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 3),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: Color(0xffFE7F64),
                                                size: 20,
                                              ),
                                              Text(
                                                "Contact",
                                                style: TextStyle(
                                                  color: Color(0xffFE7F64),
                                                  fontFamily: "okra_Medium",
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2.8,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.20,
                                  left: SizeConfig.screenWidth * 0.3),
                              child: Container(
                                height: 40,
                                width: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.3),
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xfff3f3f3),
                                      Color(0xffffffff)
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "View Details",
                                    style: TextStyle(
                                      color: CommonColor.Blue,
                                      fontFamily: "okra_Medium",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
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
          Color(0xffFD6848),
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
