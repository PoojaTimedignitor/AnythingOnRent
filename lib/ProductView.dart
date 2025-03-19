import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';


class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int currentIndex = 0;
  final cs.CarouselSliderController _controller = cs.CarouselSliderController();
  final List<String> images = [
    'https://images.pexels.com/photos/2244746/pexels-photo-2244746.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/3757226/pexels-photo-3757226.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/13065690/pexels-photo-13065690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/372810/pexels-photo-372810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/4489702/pexels-photo-4489702.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.04,left: SizeConfig.screenWidth*0.05),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    Expanded(
                      child: Center(
                        child:  Text(
                          "All Product List",
                          style: TextStyle(
                            fontFamily: "Montserrat-Medium",
                            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            color: CommonColor.TextBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        )

                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),

            ],
          ),
          SingleChildScrollView(
              child: ProductBigView(MediaQuery.of(context).size.height,
                  MediaQuery.of(context).size.width)),
        ],
      ),
    );
  }

  Widget ProductBigView(double parentWidth, double parentHeight) {
    return Padding(
      padding: EdgeInsets.only(top: parentWidth * 0.1, left: 23),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50, top: 80),
            child: Align(
              alignment: Alignment.topRight,
              child: CustomPaint(
                size: const Size(50, 50),    // Size of the triangle container
                painter: TrianglePainter(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 130),
            child: Container(
              width: parentWidth * 0.39,
              height: parentHeight * 0.7,
              decoration: const BoxDecoration(
                  color: Color(0xffE9F2FF),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.3, left: parentWidth * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "HD Camera (black & white)",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat-Medium',
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),

                    const SizedBox(height: 7),

                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Color(0xff5678ED),
                        ),
                        Text(
                          "Park Street, Kolkata, 700021",
                          style: TextStyle(
                              fontSize: 13,
                              //fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff5678ED)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Last updated on 10 Jun '24",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat-Medium',
                          fontWeight: FontWeight.w600,
                          color: Color(0xff414141)),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        Container(
                            height: 30,
                            width: 80,

                            decoration: BoxDecoration(
                                color: Color(0xffFFEDEC),
                                border: Border.all(color: Colors.grey, width: 0.3),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),child: Row(

                          children: [

                          ],
                        )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: parentWidth * 0.36,
            height: parentHeight * 0.6,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                    spreadRadius: 1, // How much the shadow spreads
                    blurRadius: 2, // How much the shadow blurs
                    offset: Offset(0, 0), // Offset in (x, y) directions
                  ),
                ],
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                // Carousel Slider
                CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: images.length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    initialPage: 0,
                    height: MediaQuery.of(context).size.height * .18,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  itemBuilder:
                      (BuildContext context, int itemIndex, int index1) {
                    final img = images.isNotEmpty
                        ? NetworkImage("${images[index1]}")
                        : const NetworkImage("");

                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        image: DecorationImage(
                          image: img,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),

                // Indicators for Slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (i) {
                    return Container(
                      width: 7,
                      height: 7,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? Colors.green
                            : Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 10),

                // Small Containers with Tap Functionality
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length > 5 ? 5 : images.length, // Limit to 5 images
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          // Tap to change slider image
                          _controller.animateToPage(index);
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: currentIndex == index
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(images[index]),
                              fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xffE9F2FF) // Triangle color
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0); // Top center
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.close(); // Connect back to the top center

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}