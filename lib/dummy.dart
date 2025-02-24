/*import 'package:flutter/material.dart';

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
}*/






import 'package:anything/MyBehavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class DashBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  List<String> tabName = [
    "sort",
    "Fast Delivery",
    "Rating 4.0+",
    "New Arrivals",
    "Pure Veg",
    "Cuisines",
    "More",
  ];

  List<String> category = [
    "Pizza",
    "Biryani",
    "Shake",
    "Burger",
    "Chicken",
    "Sandwich",
    "Noodles",
    "Frid Rice",
    "Thali",
    "Cake",
    "Panner",
    "Dosa",
    "Ice Cream",
    "Rolls",
    "Paratha",
    "Chaat",
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: Colors.pink,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),

                //appbar dynamic Create
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 25.sp,
                        color: Colors.pink,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Office",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 15.sp,
                                ),
                              ),
                            ],
                          ),
                          const Text("Dharmapuri")
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey[300]!)),
                        child: const Center(child: Icon(Icons.g_translate)),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiaLO5Z4Ga_OJMvDSNnn2b_UT6iMUvWU2Btg&usqp=CAU",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //search box
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.grey[300]!)),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          const Flexible(
                            child: TextField(
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: "Restaurant name or dish name",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.pink,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const VerticalDivider(),
                          const Icon(
                            Icons.keyboard_voice_outlined,
                            color: Colors.pink,
                          ),
                          SizedBox(
                            width: 10.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  child: ListView.builder(
                    itemCount: tabName.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Container(
                          child: index == 0
                              ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border:
                                Border.all(color: Colors.grey[300]!)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5.w,
                                ),
                                Icon(
                                  Icons.tune,
                                  size: 10.sp,
                                ),
                                Text(
                                  "sort",
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 10.sp,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          )
                              : index == 5 || index == 6
                              ? Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: Colors.grey[300]!)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "${tabName[index]}",
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.angleDown,
                                  size: 10.sp,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                              ],
                            ),
                          )
                              : Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10.r),
                                border: Border.all(
                                    color: Colors.grey[300]!)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              child: Center(
                                  child: Text("${tabName[index]}")),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                  child: Text(
                                    "OFFERS FOR YOU",
                                    style: TextStyle(color: Colors.grey[500]!),
                                  )),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        Container(
                          height: 100.h,
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GestureDetector(
                                  onTap: () {
                                    if (index != 1) {}
                                  },
                                  child: Container(
                                    height: 80.h,
                                    width: 150.w,
                                    child: Image.asset(
                                      "assets/images/onboardingthree.png",
                                      height: 70.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                  child: Text(
                                    "WHAT'S ON YOUR MIND?",
                                    style: TextStyle(color: Colors.grey[500]!),
                                  )),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        Container(
                          height: 180.h,
                          child: GridView.count(
                            scrollDirection: Axis.horizontal,
                            crossAxisCount: 2,
                            children: List.generate(
                                16,
                                    (index) => Column(
                                  children: [
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                      height: 50.h,
                                      child: Image.asset(
                                        "assets/images/home.jpeg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text("${category[index]}")
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(child: Divider()),
                              SizedBox(
                                width: 10.w,
                              ),
                              Center(
                                  child: Text(
                                    "392 RESTAURANT",
                                    style: TextStyle(color: Colors.grey[500]!),
                                  )),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: 2,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10.r)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              height: 155.h,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topRight:
                                                    Radius.circular(10.r),
                                                    topLeft:
                                                    Radius.circular(10.r),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/home.jpeg",
                                                    fit: BoxFit.fill,
                                                  ))),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    const Icon(
                                                      Icons.alarm,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    const Text(
                                                        "35-40 min ● 1 km"),
                                                    const Spacer(),
                                                    const Text("₹ 150 for one"),
                                                    SizedBox(
                                                      width: 5.w,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Positioned(
                                          top: 10.h,
                                          right: 10.w,
                                          child: Icon(
                                            Icons.favorite_outline,
                                            color: Colors.red,
                                            size: 20.sp,
                                          )),
                                      Positioned(
                                          bottom: 90.h,
                                          left: 10.w,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "The New Restaurant",
                                                  style: TextStyle(
                                                      fontSize: 20.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "SouthIndian ● North Indian ● Chinese",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 70.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10.r),
                                                          color: Colors.green),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.w),
                                                        child: const Text(
                                                          "4.0★",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                      Positioned(
                                          left: 10.w,
                                          bottom: 40.h,
                                          child: Container(
                                            height: 40.h,
                                            width: 317.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10.r),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.indigo,
                                                  Colors.indigoAccent
                                                ],
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                const Icon(
                                                  Icons.percent,
                                                  color: Colors.white,
                                                ),
                                                const Text(
                                                  "50% OFF up to 100",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 135.w,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.indigo,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(5.sp),
                                                    child: const Text(
                                                      "+1",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                )
                                              ],
                                            ),
                                          ))
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
  }
}








/*
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
}*/


/*
import 'package:flutter/material.dart';

class MyProfileWidget extends StatefulWidget {
  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  bool isExpanded = false; // Initially closed

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded; // Toggle expanded state
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      " My Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "okra_Medium",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Image(
                      image: AssetImage(isExpanded
                          ? 'assets/images/minus.png'
                          : 'assets/images/add.png'),
                      height: 15,
                      color: Color(0xfff44343),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),


        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Name: John Doe"),
                  Text("Email: john@example.com"),
                  Text("Phone: +91 9876543210"),
                ],
              ),
            ),
          ),
      ],
    );
  }
}*/


