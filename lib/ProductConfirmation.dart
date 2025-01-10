import 'package:anything/estimation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

class ProductConfigurations extends StatefulWidget {
  const ProductConfigurations({super.key});

  @override
  State<ProductConfigurations> createState() => _ProductConfigurationsState();
}

class _ProductConfigurationsState extends State<ProductConfigurations> {
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
    return  SingleChildScrollView(
      child: SizedBox(
      
        height: MediaQuery.of(context).size.height *1.1,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
      
            AnimatedPositioned(

              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              left: _startAnimation ? 0 : -MediaQuery.of(context).size.width,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.31,
                width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xfff3e8ff),
                      Color(0xfff3e8ff)
                    ],
                  ),

                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Padding(
                       padding: EdgeInsets.only(left: 8, top: 28),
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
                             "   PRODUCT CONFIGURATION",
                             style: TextStyle(
                               color: Colors.black,
                               letterSpacing: 0.0,
                               fontFamily: "okra_Medium",
                               fontSize:
                               SizeConfig.blockSizeHorizontal * 4.5,
                               fontWeight: FontWeight.w400,
                             ),
                           ),
                           PopupMenuButton<String>(
                             offset: Offset.zero,

                             icon: Image(
                               image: AssetImage('assets/images/more.png'),
                               height: 15,
                               color: Colors.black,
                             ),
                             color:Colors.white,
                             onSelected: (value) {
                               if (value == 'edit') {

                                 print('Edit selected');
                               } else if (value == 'delete') {

                                 print('Delete selected');
                               }
                             },
                             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                               PopupMenuItem<String>(
                                 value: 'edit',
                                 child: Row(
                                   children: [
                                     Icon(Icons.edit, color: Colors.blue,size: 20),
                                     SizedBox(width: 8),
                                     Text('Edit', style:TextStyle(
                                       color: Color(
                                           0xff000000),
                                       letterSpacing:
                                       0.2,
                                       fontFamily:
                                       "okra_Regular",
                                       fontSize:
                                       SizeConfig.blockSizeHorizontal *
                                           3.7,
                                       fontWeight:
                                       FontWeight
                                           .w400,
                                     ),

                                     ),

                                   ],
                                 ),
                               ),
                               PopupMenuItem<String>(
                                 value: 'delete',
                                 child: Row(
                                   children: [
                                     Icon(Icons.delete, color: Colors.red,size: 20,),
                                     SizedBox(width: 6),
                                     Text('Delete',style:TextStyle(
                                       color: Color(
                                           0xff000000),
                                       letterSpacing:
                                       0.2,
                                       fontFamily:
                                       "okra_Regular",
                                       fontSize:
                                       SizeConfig.blockSizeHorizontal *
                                           3.7,
                                       fontWeight:
                                       FontWeight
                                           .w400,
                                     ),),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),

                     Padding(
                       padding:  EdgeInsets.only(top: 10,left: 20,right: 20),
                       child: Container(
                         height: 145,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                           color: Colors.white,),
                         child: Column(
                           children: [
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
                                 Padding(
                                   padding:  EdgeInsets.only(top: 20),
                                   child: Column(
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
                                                 fontFamily: "okra_Medium",
                                                 fontSize: 14,
                                                 fontWeight: FontWeight.w400,
                                               )),
                                         ],
                                       ),
                                       Text(
                                         "Hi, John Doe",
                                           style: TextStyle(
                                             color: Colors.black,
                                             fontFamily: "okra_Medium",
                                             fontSize: 14,
                                             fontWeight: FontWeight.w400,
                                           )
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                             Padding(
                               padding:  EdgeInsets.only(right: 5),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Padding(
                                     padding:  EdgeInsets.only(left: 70,top: 10),
                                     child: Container(
                                       width:250,
                                       child: Text(
                                         "Customize your product effortlessly and preview it instantly before confirming your choice",
                                         style: TextStyle(
                                           color: CommonColor.Black,
                                           fontFamily: "Montserrat-Medium",
                                           fontSize: 13,
                                           fontWeight: FontWeight.w500,
                                         ),
                                       ),
                                     ),
                                   ),
                                   // Image(image: AssetImage('assets/images/config.png'),height: 100,width: 80,)
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
      
            ),
      
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              right: _startAnimation ? 0 : -MediaQuery.of(context).size.width,
              top: 310,
              child: Container(
                height: MediaQuery.of(context).size.height *0.75 ,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3F5FF),
                 // border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.all(
                 Radius.circular(10)),
                ),child: Padding(
                padding:  EdgeInsets.only(top: 20,right: 5),
                child: Padding(
                  padding:  EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                
                
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text(
                          "CONFIRM PRODUCT",
                          style: TextStyle(
                              letterSpacing: 3,
                              fontSize: SizeConfig
                                  .blockSizeHorizontal *
                                  4.2 ,
                              color: Colors.grey[500]!),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        child: Row(
                          children: [
                            // Left Horizontal Divider
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                                thickness: 1,
                              ),
                            ),
                            SizedBox(width: 10),


                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 5), Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey[400],
                            ),
                            SizedBox(width: 10),


                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),


                      Padding(
                        padding:  EdgeInsets.only(left: 10,top: 10),
                        child: Container(
                
                
                          width: SizeConfig.screenWidth * 0.90,
                
                          child: GradientText(
                            "3D camera capture",
                            style: TextStyle(
                
                              fontFamily: "Roboto-Bold",
                              fontSize: SizeConfig
                                  .blockSizeHorizontal *
                                  4.8 ,
                              fontWeight:
                              FontWeight.w600,
                              letterSpacing: 0.5
                            ),
                            colors: [
                              Color(0xff3033E9),
                              Colors.purple,
                
                              Colors.purple,
                
                
                            ],
                          ),
                        ),
                      ),
                
                
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: SizeConfig.screenWidth * 0.80,
                
                          child: Text(
                            "HD camera capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand, capture images and videos in 3840x2160 pixels. This results in better image quality and clarity. ",
                            style: TextStyle(
                              color: CommonColor.grayText,
                              fontFamily: "Roboto-Light",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),maxLines:3,overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                
                
                      Container(
                        height: 130,
                        width: 350,
                
                
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                          child:   Stack(
                            children: [
                              // Carousel Slider
                              CarouselSlider.builder(
                                itemCount: images.length,
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  initialPage: 0,
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: false,
                                  autoPlay: true,
                                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                                ),
                                itemBuilder: (BuildContext context, int itemIndex, int index1) {
                                  final img = images.isNotEmpty ? images[index1] : "";
                
                                  return Container(
                                    margin: EdgeInsets.all(14),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(img), // Fixed URL issue
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                
                              // Indicator Row
                              Positioned(
                                bottom: 0, // Adjust position as needed
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0; i < images.length; i++)
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        width: currentIndex == i ? 25 : 7,
                                        height: 7,
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: currentIndex == i
                                                ? [Color(0xff6a83da), Color(0xff665365B7)]
                                                : [Color(0xff7F9ED4), Color(0xff999999)],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                
                        ),
                      ),
                

                      Container(
                        width: SizeConfig.screenWidth * 0.90,
                
                        child: Padding(
                          padding:  EdgeInsets.all(11.0),
                          child: Text(
                            "Pune ",
                            style: TextStyle(
                              color: CommonColor.grayText,
                              fontFamily: "Roboto-Light",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),maxLines: 1,overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),



                      Container(
                        width: SizeConfig.screenWidth * 0.90,
                
                        child: Padding(
                          padding:  EdgeInsets.all(11.0),
                          child: Text(
                            "Pune, Maharastra",
                            style: TextStyle(
                              color: CommonColor.grayText,
                              fontFamily: "Roboto-Light",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),maxLines: 1,overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                
                
                

                      Container(
                        width: SizeConfig.screenWidth * 0.90,
                
                        child: Padding(
                          padding:  EdgeInsets.all(11.0),
                          child: Text(
                            "+916534524365 ",
                            style: TextStyle(
                              color: CommonColor.grayText,
                              fontFamily: "Roboto-Light",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),maxLines: 1,overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                

                      Padding(
                        padding:  EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text(
                              "Total Quantity  :",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(


                              child: Padding(
                                padding:  EdgeInsets.all(11.0),
                                child: Text(
                                  "12",
                                  style: TextStyle(
                                    color: CommonColor.grayText,
                                    fontFamily: "Roboto-Light",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),maxLines: 1,overflow: TextOverflow.ellipsis,
                                ),
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
                                  builder: (context) => Estimation()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                
                              left: parentWidth * 0.04,
                              right: parentWidth * 0.04),
                          child: Container(
                              width: parentWidth * 0.35,
                              height: parentHeight * 0.12,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                          offset: Offset(1,1)),
                                    ],
                                gradient: LinearGradient(
                
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xff8d4fd6),
                                    Color(0xffbd6dd6)
                                  ],
                                ),
                
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                    "Confirm Product",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto-Regular',
                                        fontSize:
                                        SizeConfig.blockSizeHorizontal *
                                            4.2),
                                  ))),
                        ),
                      ),
                
                
                    ],
                  ),
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