import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

import 'Common_File/common_color.dart';
import 'ResponseModule/getAllProductList.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailScreen extends StatefulWidget {
  final Data1 product;

  const DetailScreen({required this.product});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();

  final List<String> Price = [
    "100",
    "500",
    "345",
    "5000",
  ];
  final List<String> Labels = ["/Per Hour", "/Per Day", "/Per Week", "/Per Month"];

  @override
  Widget build(BuildContext context) {
    final productImages = widget.product.images ?? [];
    return PageStorage(
      bucket: bucket,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Hero(
              tag: widget.product.sId
                  .toString(), // Ensure tag matches in both screens
              child: PageStorage(
                bucket: bucket,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.39,
                      decoration: BoxDecoration(
                        color: Color(0xffF5F6FB),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Container(
                      width: double.infinity, // Ensure a finite width
                      height: MediaQuery.of(context).size.height * 0.38,
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
                                height: MediaQuery.of(context).size.height * .4,
                                viewportFraction: 1.0,
                                enableInfiniteScroll: false,
                                autoPlay: false,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                              ),
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int index1) {
                                final imgUrl = productImages[index1].url ?? "";

                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(imgUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (int i = 0; i < productImages.length; i++)
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
                                  : productImages.length, // Limit to 5 images
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
                                      borderRadius: BorderRadius.circular(8),
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
                                                productImages[index].url ?? ""),
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
            Padding(
              padding:
                  EdgeInsets.only(top: SizeConfig.screenHeight * 0.45, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(left: 18),
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
                                color: Colors.blue),
                            Flexible(
                              child: Text(
                                ' Park Street,pune banner 20023',
                                style: TextStyle(
                                  color: Colors.blue.withOpacity(0.8),
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
                                        decoration: TextDecoration.underline,
                                        decorationColor: Color(0xffFE7F64),
                                        fontFamily: 'Roboto-Regular',
                                        fontSize: 15),
                                    recognizer: TapGestureRecognizer()..onTap = () {},
                                  )
                                ])),
                      ],
                    ),
                  ),


                  Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Container(

                      width: double
                          .infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffF5F6FB),
                      ),

                      child: Container(
                        height: 140,
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
                                      padding:  EdgeInsets.only(left: 10),
                                      child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                              
                                          borderRadius: BorderRadius.circular(13),
                                        ),
                                        child: Container(
                              
                              width: 150,
                                          margin: EdgeInsets.symmetric(horizontal: 0.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                             mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Get",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "okra_Regular",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "₹" + Price[index],
                                                      style: TextStyle(
                                                        color: CommonColor.Black,
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ), SizedBox(width: 8),
                                                    Text(
                                                      Labels[index],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                                SizedBox(height: 5),
                                                Text(
                                                  "Up to Last Updated",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: "okra_Regular",
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                               /* Text(
                                                "Up to Last Updated",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "okra_Regular",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),*/
                                              ],
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
                      )

                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 18),                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFFFF1EE),
                          borderRadius: BorderRadius.circular(10)),
                      height: SizeConfig.screenHeight * 0.05,
                      width: 360,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                "About This item",
                                style: TextStyle(
                                  color: Color(0xffFE7F64),
                                  fontFamily: "okra_Medium",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(right: 13),
                              child: Center(child: Icon(Icons.arrow_drop_down,color: Color(0xffFE7F64))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
