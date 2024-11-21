import 'dart:io';

import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/hsdfgshd.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'All_Product_List.dart';
import 'CatagrioesList.dart';
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
  String updatedText = "Original Text";
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _pickImagesFromGallery() async {
    if (_selectedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You can only add up to 5 images.')),
      );
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        // Add selected images to the list, limit to 5
        _selectedImages.addAll(
          pickedFiles.map((file) => File(file.path)).take(5 - _selectedImages.length),
        );
      });
    }
  }


  void _loadSavedText() {
    String? savedText = box.read('updatedText');  // Retrieve saved text
    if (savedText != null) {
      setState(() {
        updatedText = savedText;  // Update the UI with the saved text
      });
    }
  }

  // Function to update text and save it using GetStorage
  void updateText(String newText) {
    box.write('updatedText', newText);  // Save the new text
    setState(() {
      updatedText = newText;  // Update the state to show the new text
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _loadSavedText();
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        //  borderRadius: BorderRadius.circular(15)
        ),
        child: ScrollConfiguration(
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
                        Expanded(
                          child: Container(
                                   height: SizeConfig.screenHeight*0.77,
                          
                              child: Padding(
                                padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.0),
                                child: getAddGameTabLayout(
                                    SizeConfig.screenHeight, SizeConfig.screenWidth),
                              )),
                        ),
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

                          Color(0xffC0B5E8),
                          Color(0xff9584D6),
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
                              color: Colors.black,
                              fontFamily: "Montserrat-Medium",
                              fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                              fontWeight: FontWeight.w600,
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
             height: SizeConfig.screenHeight*0.6,
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
                                        hintText: 'HD cameras capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand',
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
                            height: SizeConfig.screenHeight * 0.14,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImagePickerCarousel()));
                                  },
                                  child: Text(
                                    "    Select Categories",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "okra_Medium",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    // Navigate to the second screen and await the result
                                    final String? result = await showModalBottomSheet<String>(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      context: context,
                                      backgroundColor: Colors.white,
                                      elevation: 10,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      builder: (BuildContext bc) {
                                        return CatagriesList();
                                      },
                                    );

                                    // If a result is received (i.e., category was selected), update the text
                                    if (result != null) {
                                      updateText(result);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10, top: 7),
                                    child: Container(
                                      height: 60,
                                  width: SizeConfig.screenWidth*0.9,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF5F6FB) ,
                                        borderRadius: BorderRadius.all(Radius.circular(7)),
                                      ),child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text((updatedText),style: TextStyle(color: Color(0xff7D7B7B), fontFamily: "Roboto_Regular",

                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,),),
                                      ),
                                    ),
                                  ),
                                )

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
                                  "    Add Product Images",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: 13,left: 20),
                                      child: Container(
                                          width: parentWidth * 0.38,
                                          // padding: EdgeInsets.all(20), //padding of outer Container
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(10),

                                            color: CommonColor.Blue, //color of dotted/dash line
                                            strokeWidth: 1, //thickness of dash/dots
                                            dashPattern: [4, 5],
                                            //dash patterns, 10 is dash width, 6 is space width
                                            child: GestureDetector(
                                              onTap: () {
                                                _pickImagesFromGallery();
                                               // _showFrontGallaryDialogBox(context);
                                              },
                                              child:  Container(
                                                //inner container
                                                height: parentHeight *
                                                    0.14, //height of inner container
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: parentHeight * 0.01),
                                                      child: Image(
                                                          image: AssetImage(
                                                              'assets/images/uploadpic.png'),
                                                          height: parentHeight * 0.04),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      height: 26,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: CommonColor.Blue),
                                                        borderRadius:
                                                        BorderRadius.circular(7),
                                                      ),
                                                      child: Center(
                                                        child: Text("Browser file",
                                                            style: TextStyle(
                                                                fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    2.5,
                                                                fontFamily:
                                                                'Roboto_Regular',
                                                                fontWeight:
                                                                FontWeight.w400,
                                                                //overflow: TextOverflow.ellipsis,
                                                                color: CommonColor.Blue)),
                                                      ),
                                                    ),
                                                  ],
                                                ), //width to 100% match to parent container.
                                                // color:Colors.yellow //background color of inner container
                                              )

                                            ),
                                          )),
                                    ),
                                    if (_selectedImages.isNotEmpty)

                                    Padding(
                                      padding:  EdgeInsets.only(top: parentHeight*0.02,left: parentWidth*0.05),
                                      child: Container(
                                        height: 120,
                                        width: 170,
                                        child:    Stack(
                                          children: [
                                            Container(
                                          
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                Radius.circular(10)
                                                ),
                                                child:  AnotherCarousel(
                                                  images: _selectedImages.map((image) {
                                                    return ClipRRect(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      child: Image.file(
                                                        image,
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(context).size.width,
                                                      ),
                                                    );
                                                  }).toList(),
                                                  dotSize: 6,
                                                  dotSpacing: 10,
                                                  dotColor: Colors.white70,
                                                  dotIncreasedColor:
                                                  Colors.black45,
                                                  indicatorBgPadding: 5.0,
                                                ),
                                              ),
                                            ),
                                        /*    Padding(
                                                padding: EdgeInsets.only(
                                                    top: 67, left: 111),
                                                child: Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Container(
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff5095f1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          0),
                                                    ),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                                        children: [
                                                          Icon(
                                                            Icons.location_on,
                                                            size: SizeConfig
                                                                .screenHeight *
                                                                0.019,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            '1.2 Km   ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                              "Montserrat-Regular",
                                                              fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                                  2.5,
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.w600,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ]),
                                                  ),
                                                )),*/
                                          ],
                                        )
                                      ),
                                    ),
                                    if (_selectedImages.isEmpty)
                                      Center(
                                        child: Text(
                                          'No images selected',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                  ],
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
