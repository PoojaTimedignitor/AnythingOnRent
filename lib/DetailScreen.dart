
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;

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

  @override
  Widget build(BuildContext context) {
    // Access the images directly from the product parameter
    final productImages = widget.product.images ?? []; // Default to empty list if null

    return PageStorage(
      bucket: bucket,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Hero(
              tag: widget.product.sId.toString(), // Ensure tag matches in both screens
              child: PageStorage(
                bucket: bucket,

                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f2fd),
                          borderRadius: BorderRadius.circular(40),

                        ),
                      ),
                      Container(


                        width: double.infinity,  // Ensure a finite width
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child:
                              CarouselSlider.builder(
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
                                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                                ),
                                itemBuilder:
                                    (BuildContext context, int itemIndex, int index1) {
                                      final imgUrl = productImages[index1].url ?? "";

                                  return Container(


                                      height: MediaQuery.of(context).size.height * 0.3,

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
                            Row  (
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
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xff6a83da),
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
                                productImages.length > 5 ? 5 : productImages.length, // Limit to 5 images
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
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white, // सफेद पृष्ठभूमि
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
                                            borderRadius: BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: NetworkImage(productImages[index].url ?? ""),
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
          ],
        ),
      ),
    );
  }
}