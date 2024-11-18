import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Common_File/common_color.dart';

import 'MyBehavior.dart';

class AllProductList extends StatefulWidget {
  const AllProductList({super.key});

  @override
  State<AllProductList> createState() => _AllProductListState();
}

class _AllProductListState extends State<AllProductList> {



  @override
  Widget build(BuildContext context) {
   // ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: Color(0xfff69c9c),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 10,),

                //appbar dynamic Create



                //search box
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: [
                        SizedBox(height: 10,),
                      /*  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(child: Text("CURATED COLLECTIONS",style: TextStyle(color: Colors.grey[500]!),)),
                              SizedBox(
                                width: 10.w,

                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                        ),*/
                       /* Container(
                          height: 120.h,
                          child: ListView.builder(
                            itemCount: 2,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal:10.w),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Stack(
                                      children: [
                                        Container(
                                            height:120.h,width: 100.w,
                                            child: Image.asset("assets/images/img_dining${index+1}.jpeg",fit: BoxFit.fill,)),
                                        Positioned(
                                            left: 5.w,
                                            bottom: 20.h,
                                            child: Text("Collection 1",style: TextStyle(fontSize:18,color: Colors.white),))
                                      ],
                                    )),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h,),*/
                       /* Row(
                          children: [
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: Colors.grey[300]!)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(5.h),
                                child: Row(children: [
                                  Text("Explore More",style: TextStyle(color: Colors.pink),),Icon(Icons.arrow_forward,color: Colors.pink,)
                                ],),
                              ),
                            ),
                            Spacer()
                          ],
                        ),*/

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Divider()),
                              SizedBox(
                                width: 10,
                              ),
                              Center(child: Text("POPULAR RESTAURANT AROUND YOU",style: TextStyle(color: Colors.grey[500]!),)),
                              SizedBox(
                                width: 10,

                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: 12,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical, itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11,vertical: 10),
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7)
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height:150,width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(7),
                                                  topRight: Radius.circular(7),
                                                ),
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
                                                  dotSpacing: 10,
                                                  dotColor: Colors.white70,
                                                  dotIncreasedColor: Colors.black45,
                                                  indicatorBgPadding: 5.0,
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    'HD Camera (black & white) dfgdf',
                                                   style: TextStyle(
                                                      color: Colors.black,
                                                      letterSpacing: 0.0,
                                                      fontFamily: "okra_medium",
                                                      fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                                                      fontWeight: FontWeight.w500,
                                                    ),overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Spacer(),
                                                /*  Container(
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
                                                        color: Colors.green[900]!
                                                    ),
                                                    child: Padding(
                                                      padding:  EdgeInsets.symmetric(horizontal:5.w),
                                                      child: Text("4.9★",style: TextStyle(color: Colors.white),),
                                                    ),
                                                  )*/
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: SizeConfig.screenHeight *
                                                        0.019,
                                                    color: Color(0xff3684F0),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      ' Park Street,pune banner 20023',
                                                      style: TextStyle(
                                                        color: Color(0xff3684F0),
                                                        letterSpacing: 0.0,
                                                        fontFamily: "okra_Regular",
                                                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                height: 33,
                                                decoration:
                                                BoxDecoration(
                                                  color: Color(
                                                      0xfff8e8e8),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      4),
                                                ),
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                    children: [

                                                      Text(
                                                        '   Posted By:  ',
                                                        style:
                                                        TextStyle(
                                                          fontFamily:
                                                          "Montserrat-Regular",
                                                          fontSize:
                                                          SizeConfig.blockSizeHorizontal * 3.0,
                                                          color:
                                                          Colors.black87,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      Text(
                                                        'Aaysha',
                                                        style:
                                                        TextStyle(
                                                          fontFamily:
                                                          "Montserrat-Regular",
                                                          fontSize:
                                                          SizeConfig.blockSizeHorizontal * 3.1,
                                                          color:
                                                          Color(0xffC56262),
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(width: 163),
                                                      Container(
                                                        width: SizeConfig.screenWidth *
                                                            0.14,
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green[900]!,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                        child: Padding(
                                                          padding:  EdgeInsets.only(left: 7),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                size: SizeConfig
                                                                    .screenHeight *
                                                                    0.018,
                                                                color:   CommonColor.white,
                                                              ),
                                                              Text(
                                                                "  4.5",
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  "Roboto-Regular",
                                                                  fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                      3.1,
                                                                  color:
                                                                  CommonColor.white,
                                                                  fontWeight:
                                                                  FontWeight.w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),



                                                    ]),
                                              ),
                                              //Text("Kothi Compound ,Rajkot"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: IconButton(
                                            color: Colors.white,
                                            onPressed: (){},icon: Icon(Icons.favorite_outline,color: Colors.pink,),),
                                        )
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 120,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200]!,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Center(child:Row(
                                              // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: SizeConfig
                                                        .screenHeight *
                                                        0.019,
                                                    color: Colors.black87,
                                                  ),
                                                  Text(
                                                    '1.2 Km   ',
                                                    style: TextStyle(
                                                      fontFamily:
                                                      "Montserrat-Regular",
                                                      fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                          2.9,
                                                      color: Colors.black87,
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ]),),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                        )
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );





    /*Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/backk.png",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/images/backkone.png",
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.15,
                left: SizeConfig.screenWidth * 0.015,
                right: SizeConfig.screenWidth * 0.015),
            child: Container(
                height: SizeConfig.screenHeight * 0.8,
                width: SizeConfig.screenWidth * 0.98,
                *//*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(color: CommonColor.grayText, width: 0.5)),*//*
                child: AllProduct(
                    SizeConfig.screenHeight, SizeConfig.screenWidth)),
          ),
          // Main content

          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/allpro.png",
                height: SizeConfig.screenHeight * 0.13,
              ),
            ),
          ),
        ],
      ),
    );*/
  }

  /*Widget AllProduct(double parentHeight, double parentWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text widget at the top
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: Text(
            "  All Product List",
            style: TextStyle(
              fontFamily: "Montserrat-Medium",
              fontSize: SizeConfig.blockSizeHorizontal * 4.1,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // GridView.builder below the text
        Expanded(
          child: Container(
            padding:
                EdgeInsets.only(top: 02.0, bottom: 16.0, left: 5, right: 5),
            // Set height to fit the horizontal list
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10, // Define the number of items
                itemBuilder: (context, index) {
                  return Container(
                    width: parentWidth * 0.55,
                    height: parentHeight * 0.18,

                    // Set width for each item
                    margin: EdgeInsets.symmetric(vertical: 9.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    *//*  border:
                          Border.all(color: CommonColor.grayText, width: 0.1),*//*
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff535353).withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 0,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: SizeConfig.screenHeight * 0.16,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CommonColor.Black, width: 0.1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                child: AnotherCarousel(
                                  images: const [
                                    NetworkImage(
                                        "https://sb.kaleidousercontent.com/67418/960x550/3e324c0328/individuals-removed.png"),
                                    NetworkImage(
                                        "https://media.istockphoto.com/id/507832549/photo/couple-standing-on-balcony-of-modern-house.jpg?s=2048x2048&w=is&k=20&c=7ooit4W_g24NDUGnLDWs9Dlh0F8T6dRbtX8RBBgQiuE="),
                                    NetworkImage(
                                        "https://media.istockphoto.com/id/1436217023/photo/exterior-of-a-blue-suburban-home.jpg?s=2048x2048&w=is&k=20&c=Z9Wc1NpUagwfdZbtHCyVEF9JnLXDIsPyIrw48-UXFb0="),
                                    // we have display image from netwrok as well
                                    NetworkImage(
                                        "https://media.istockphoto.com/id/1132628728/photo/couple-in-front-of-residential-home-smiling.jpg?s=2048x2048&w=is&k=20&c=wqxgUhQQAqthoi-h80nHksGOhklcUywyrkCDwXPXxEc=")
                                  ],
                                  dotSize: 6,
                                  dotSpacing: 10,
                                  dotColor: Colors.white70,
                                  dotIncreasedColor: Colors.black45,
                                  indicatorBgPadding: 5.0,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: SizeConfig.screenWidth * 0.52,
                           //   color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' HD Camera (black & white) dfgdf',
                                        style: TextStyle(
                                          fontFamily: "Montserrat-Regular",
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.8,
                                          color: CommonColor.Black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size:
                                                SizeConfig.screenHeight * 0.02,
                                            color: Color(0xff3684F0),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ' Park Street,pune banner 20023',
                                              style: TextStyle(
                                                fontFamily:
                                                    "Montserrat-Regular",
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.0,
                                                color: Color(0xff3684F0),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 28,
                                        decoration:
                                        BoxDecoration(
                                          color: Color(
                                              0xfff8e8e8),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              4),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                            children: [

                                              Text(
                                                '   Posted By:  ',
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  "Montserrat-Regular",
                                                  fontSize:
                                                  SizeConfig.blockSizeHorizontal * 2.8,
                                                  color:
                                                  Colors.black87,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Aaysha',
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  "Montserrat-Regular",
                                                  fontSize:
                                                  SizeConfig.blockSizeHorizontal * 2.8,
                                                  color:
                                                  Color(0xffC56262),
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              SizedBox(width: 45),
                                              Container(
                                                width: SizeConfig.screenWidth *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffffffff),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: SizeConfig
                                                          .screenHeight *
                                                          0.016,
                                                      color: Color(0xffFFB905),
                                                    ),
                                                    Text(
                                                      "  4.5",
                                                      style: TextStyle(
                                                        fontFamily:
                                                        "Roboto-Regular",
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            2.5,
                                                        color:
                                                        CommonColor.Black,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ]),
                                      ),
                                      SizedBox(height: 13),
                                      Row(
                                        children: [
                                          // color: Color(0xff3684F0),

                                          Text(
                                            " Share",
                                            style: TextStyle(
                                              color: CommonColor.grayText,
                                              fontFamily: "Roboto_Regular",
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 17),
                                          Image(
                                              image: AssetImage(
                                                  'assets/images/share.png'),
                                              height: 15),


                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }*/
}
