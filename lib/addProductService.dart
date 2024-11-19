import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:anything/pupularCatagoriesViewAll.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import 'All_Product_List.dart';
import 'MyBehavior.dart';


class CreateProductService extends StatefulWidget {
  const CreateProductService({super.key});

  @override
  State<CreateProductService> createState() => _CreateProductServiceState();
}

class _CreateProductServiceState extends State<CreateProductService>  with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  final _productNameFocus = FocusNode();
  final _productDiscriptionFocus = FocusNode();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDiscriptionController = TextEditingController();
  late TabController _tabController;
  final formKey = GlobalKey<FormState>();

  var chosenValue;
  List<String> gameList = [
    "Aadhaar Card",
    "PAN Card",
    "Driving License",
    "Passport",
    "Post Office ID card"
  ];
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
        decoration: BoxDecoration(
          color: Color(0xffF5F6FB),
          borderRadius: BorderRadius.circular(15)
        ),
        child:   ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: SizeConfig.screenHeight*0.23,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Center(
                          child: Text(
                            "  Create Product / Service",
                            style: TextStyle(
                              fontFamily: "Montserrat-Medium",
                              fontSize:
                              SizeConfig.blockSizeHorizontal * 4.4,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding:  EdgeInsets.only(left: 13,right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF1E7FB),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: SizeConfig.screenHeight*0.1,


                            child: Padding(
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
                                      width:08 ), // Add some space between the avatar and the column
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 12),
                                      Text(
                                        "  Hii, Aaysha",
                                        style: TextStyle(
                                          color: Color(0xff675397),
                                          fontFamily: "okra_Medium",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      Padding(
                                        padding:  EdgeInsets.only(left: 9,top: 2),
                                        child: Container(
                                          height: 38,
                                          width: 270,

                                          child: Text(
                                            "Generating ideas for new products or services",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "okra_Regular",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  // Adds space between the icon and text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) ,

                  ),
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
         height: SizeConfig.screenHeight*0.77,

                            child: Padding(
                              padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.0),
                              child: getAddGameTabLayout(
                                  SizeConfig.screenHeight, SizeConfig.screenWidth),
                            )),
                      ],
                    ),
                  ),



                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: 
        
        Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 0, bottom: 20, right: 0),
                child: ButtonsTabBar(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xffFEBA69),
                          Color(0xffFE7F64),
                        ],
                      )),
                  buttonMargin: EdgeInsets.symmetric(horizontal: 18),
                  unselectedDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  unselectedBorderColor: Color(0xffFE7F64),
                  physics: NeverScrollableScrollPhysics(),
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 40,
                        width: 165,
                        child: Center(
                          child: Text(
                            "Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat-Medium",
                              fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 40,
                        width: 165,
                        padding: EdgeInsets.only(left: 28, right: 20),
                        child: Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "Service",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat-Medium",
                                fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            // Remove fixed height here and use an Expanded widget
            Container(
             height: SizeConfig.screenHeight*0.9,
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.16,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "    Product Name",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      focusNode: _productNameFocus,
                                      keyboardType: TextInputType.text,
                                      controller: productNameController,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Ex.HD Camera (black & white)',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black12, width: 1),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 27),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.28,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "    Product Description",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 6,
                                      focusNode: _productDiscriptionFocus,
                                      keyboardType: TextInputType.text,
                                      controller: productDiscriptionController,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'HD cameras capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black12, width: 1),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 27),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.28,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "    Product Description",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                         Padding(
                padding: EdgeInsets.only(right: 20),
                child: Form(
                  key: formKey,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.only(right: 10, left: 10),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 0.8),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 0.8),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black45, width: 0.8),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 0.8, color: Colors.red),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    elevation: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select game';
                      } else {
                        return null;
                      }
                    },
                    isExpanded: true,
                    hint: Text(
                      "Select anyone",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                          fontFamily: 'Poppins_Medium',
                          fontWeight: FontWeight.w400,
                          color: Colors.black45),
                    ),
                    iconSize: 30,
                    iconEnabledColor: Colors.black87,
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      size: 15,
                    ),
                    value: chosenValue,
                    items:
                        gameList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                              fontFamily: 'Poppins_Medium',
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        chosenValue = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 26),
                              ],
                            ),
                          ),
                        ),
                    
                        SizedBox(height: 27),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.28,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "    Product Description",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 6,
                                      focusNode: _productDiscriptionFocus,
                                      keyboardType: TextInputType.text,
                                      controller: productDiscriptionController,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Product description here...',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black12, width: 1),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                    
                        SizedBox(height: 27),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.28,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "    Product Description",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 6,
                                      focusNode: _productDiscriptionFocus,
                                      keyboardType: TextInputType.text,
                                      controller: productDiscriptionController,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Product description here...',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black12, width: 1),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('Service Tab'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}
