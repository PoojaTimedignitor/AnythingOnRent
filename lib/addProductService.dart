import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainScreen/forget_pass_OTP_verify.dart';
import 'package:flutter/material.dart';

class CreateProductService extends StatefulWidget {
  const CreateProductService({super.key});

  @override
  State<CreateProductService> createState() => _CreateProductServiceState();
}

class _CreateProductServiceState extends State<CreateProductService>  with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.0),
                  child: Image(
                    image: AssetImage('assets/images/createone.png'),
                    height: SizeConfig.screenHeight * 0.240,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.screenHeight * 0.0,
                      left: SizeConfig.screenWidth * 0.02),
                  child: Image(
                    image: AssetImage('assets/images/createtwo.png'),
                    height: SizeConfig.screenHeight * 0.2,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.screenHeight*0.11,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.4),
                                  child: Container(
                                    color: CommonColor.showBottombar.withOpacity(0.2),
                                    height: SizeConfig.screenHeight * 0.004,
                                    width: SizeConfig.screenHeight * 0.1,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.25),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.screenHeight * 0.01),
                                    child: Icon(
                                      Icons.close,
                                      size: SizeConfig.screenHeight * .03,
                                      color: CommonColor.Black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Row(
                            //  crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundImage:
                                  AssetImage("assets/images/profile.png"),
                                ),

                                SizedBox(
                                    width: 10,
                                    height:
                                    5), // Add some space between the avatar and the column
                                Text(
                                  "  Hii, Aaysha",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Roboto_Normal",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2),
                                // Adds space between the icon and text
                              ],
                            ),
                          ),
                        ],
                      ) ,

                    ),
                    Container(
                        height: SizeConfig.screenHeight * 0.90,
                        child: getAddGameTabLayout(
                            SizeConfig.screenHeight, SizeConfig.screenWidth)),


                   /* SizedBox(height: 550),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            context: context,
                            backgroundColor: Colors.white,
                            elevation: 10,
                            isScrollControlled: true,
                            isDismissible: true,
                            builder: (BuildContext bc) {
                              return OTPVerify();
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.03),
                        child: Center(
                          child: Container(
                              width: SizeConfig.screenWidth * 0.9,
                              height: SizeConfig.screenHeight * 0.06,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26.withOpacity(0.1),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      offset: Offset(0, 2)),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xffFEBA69),
                                    Color(0xffFE7F64),
                                  ],
                                ),
                                *//*   border: Border.all(
                                            width: 1, color: CommonColor.APP_BAR_COLOR),*//* //Border.
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                "Add Product",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Roboto-Regular',
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.3),
                              ))),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.0,
            right: parentWidth * 0.04,
            left: parentWidth * 0.04),
        child: Column(children: [
          // give the tab bar a height [can change hheight to preferred height]
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xffFFE5E5),
                borderRadius: BorderRadius.circular(10),
               // border: Border.all(color: CommonColor.bottomsheet, width: 0.2),
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
                                                Padding(
                                                  padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                                  child: Text("05:30",style: TextStyle(
                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight: FontWeight.w600,
                                                    color: CommonColor.Black,)),
                                                )

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
                                                Padding(
                                                  padding:EdgeInsets.only(right: parentWidth*0.1,top: parentHeight*0.02),
                                                  child: Text("05:30",style: TextStyle(
                                                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                                    fontFamily: 'Roboto_Bold',
                                                    fontWeight: FontWeight.w600,
                                                    color: CommonColor.Black,)),
                                                )

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
