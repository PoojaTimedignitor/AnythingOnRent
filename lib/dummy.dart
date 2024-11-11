/*
import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
   // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          height: SizeConfig.screenHeight * 0.90,
          child: getAddGameTabLayout(
              SizeConfig.screenHeight, SizeConfig.screenWidth)),
    );
  }

  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.03,
            right: parentWidth * 0.04,
            left: parentWidth * 0.04),
        child: Column(children: [
          // give the tab bar a height [can change hheight to preferred height]
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffFFE5E5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: CommonColor.bottomsheet, width: 0.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,

                  //labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                  indicator: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/back.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10)


                      ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.green.shade800,
                  tabs: [
                    Tab(
                      child: Container(
                        width: 150,
                        child: Center(
                            child: Row(
                          children: [
                            Image(
                                image:
                                    AssetImage('assets/images/catone.png'),
                                height: 72,
                                width: 50),
                            Text(
                              "Product",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto_Regular",
                                fontSize:
                                    SizeConfig.blockSizeHorizontal * 3.2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 150,
                        child: Center(
                            child: Row(
                          children: [
                            Image(
                                image: AssetImage('assets/images/service.png'),
                                height: 72,
                                width: 50),
                            Text("Service"),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // tab bar view here
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.02),
            child: TabBarView(
              controller: _tabController,
              children: [
                Text("APPS"),

                // first tab bar view widget

                // second tab bar view widget
                Padding(
                  padding: EdgeInsets.only(top: parentHeight * 0.0),
                  child: SizedBox(
                    height: parentHeight,
                    child: ListView.builder(
                        itemCount: 7,
                        padding: const EdgeInsets.only(bottom: 20, top: 5),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(top: parentHeight * 0.03),
                            child: Container(
                              height: parentHeight * 0.23,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade50,
                                    offset: const Offset(-5, 0),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade50,
                                    offset: const Offset(5, 0),
                                  )
                                ],
                              ),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentWidth * 0.01),
                                    child: Container(
                                        height: parentHeight * 0.17,
                                        width: parentWidth * 0.30,
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/logo.png"),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: parentHeight * 0.01),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: parentWidth * 0.05,
                                                  top: parentHeight * 0.03),
                                              child: Text("Masjit Name",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.3,
                                                    fontFamily:
                                                        'Roboto_Bold',
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color:
                                                        CommonColor.Black,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: parentHeight * 0.03,
                                                  left: parentWidth * 0.04,
                                                  right: parentWidth * 0.0),
                                              child: Container(
                                                  height:
                                                      parentHeight * 0.04,
                                                  width:
                                                      parentHeight * 0.12,
                                                  decoration: BoxDecoration(
                                                    gradient:  LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          CommonColor.Black,
                                                          CommonColor.Black
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(10),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "JOIN",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Roboto_Regular",
                                                          fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              4.3,
                                                          color: CommonColor
                                                              .bottomsheet),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      parentHeight * 0.02,
                                                  top:
                                                      parentHeight * 0.002),
                                              child: Text("Location :",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.0,
                                                    fontFamily:
                                                        'Roboto_Bold',
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    color:
                                                        CommonColor.Black,
                                                  )),
                                            ),
                                            */
/* Padding(
                                              padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                              child: Text("05:30",style: TextStyle(
                                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                fontFamily: 'Roboto_Bold',
                                                fontWeight: FontWeight.w600,
                                                color: CommonColor.BLACK_COLOR,)),
                                            )*//*

                                          ],
                                        ),
                                        Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      parentHeight * 0.02,
                                                  top: parentHeight * 0.01),
                                              child: Text("FAZAR",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.0,
                                                    fontFamily:
                                                        'Roboto_Bold',
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color:
                                                        CommonColor.Black,
                                                  )),
                                            ),
                                            */
/* Padding(
                                              padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                              child: Text("05:30",style: TextStyle(
                                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                fontFamily: 'Roboto_Bold',
                                                fontWeight: FontWeight.w600,
                                                color: CommonColor.BLACK_COLOR,)),
                                            )*//*

                                          ],
                                        ),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: parentHeight * 0.0,
                                                  top: parentHeight * 0.01),
                                              child: Text("AZAN :",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4.0,
                                                    fontFamily:
                                                        'Roboto_Bold',
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color:
                                                        CommonColor.Black,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: parentWidth * 0.02,
                                                  top: parentHeight * 0.01),
                                              child: Text("05:30",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        CommonColor.Black,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right:
                                                      parentHeight * 0.01,
                                                  top: parentHeight * 0.01),
                                              child: Text("JAMA'AT :",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.blockSizeHorizontal *
                                                        4.0,
                                                    fontFamily:
                                                        'Roboto_Bold',
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color:
                                                        CommonColor.Black,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: parentWidth * 0.0,
                                                  top: parentHeight * 0.01),
                                              child: Text("05:30",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                    fontFamily:
                                                        'Roboto_Bold', fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        CommonColor.Black),

                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ))
        ]));
  }
}
*/
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class ImageSliders extends StatefulWidget {
  const ImageSliders({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ImageSliders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImageSlider in Flutter"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 250,
        width: double.infinity,
        child: AnotherCarousel(
          images: const [
            NetworkImage(
                "https://media.istockphoto.com/id/1269776313/photo/suburban-house.jpg?s=1024x1024&w=is&k=20&c=xIwaYa1oKX9jnEnlsObNYDrljAkEsjOLlE66Eg2fDco="),
            NetworkImage(
                "https://media.istockphoto.com/id/507832549/photo/couple-standing-on-balcony-of-modern-house.jpg?s=2048x2048&w=is&k=20&c=7ooit4W_g24NDUGnLDWs9Dlh0F8T6dRbtX8RBBgQiuE="),
            NetworkImage(
                "https://media.istockphoto.com/id/1436217023/photo/exterior-of-a-blue-suburban-home.jpg?s=2048x2048&w=is&k=20&c=Z9Wc1NpUagwfdZbtHCyVEF9JnLXDIsPyIrw48-UXFb0="),
            // we have display image from netwrok as well
            NetworkImage(
                "https://media.istockphoto.com/id/1132628728/photo/couple-in-front-of-residential-home-smiling.jpg?s=2048x2048&w=is&k=20&c=wqxgUhQQAqthoi-h80nHksGOhklcUywyrkCDwXPXxEc=")
          ],
          dotSize: 6,
          dotSpacing:17,
          dotIncreasedColor:Colors.red,
          indicatorBgPadding: 5.0,
        ),
      ),
    );
  }
}