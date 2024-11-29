import 'dart:io';

import 'package:anything/City_Create.dart';
import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainHome.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'CatagrioesList.dart';
import 'MyBehavior.dart';
import 'hsdfgshd.dart';

class CreateProductService extends StatefulWidget {
  const CreateProductService({super.key});

  @override
  State<CreateProductService> createState() => _CreateProductServiceState();
}

class _CreateProductServiceState extends State<CreateProductService>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  final _productcurrentAddFocus = FocusNode();
  final _productDiscriptionFocus = FocusNode();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productCurrentAddressController =
      TextEditingController();

  TextEditingController productPerHourController = TextEditingController();
  TextEditingController productPerDayController = TextEditingController();
  TextEditingController productPerWeekController = TextEditingController();
  TextEditingController productPerMonthController = TextEditingController();
  TextEditingController productDiscriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productRatingController = TextEditingController();
  late TabController _tabController;
  String updatedTexts = "Original Text";
  String productType = "Product";
  String updatedCitys = "Choose City";
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  int quantity = 0;

  bool perDay = false;
  bool perHour = false;
  bool perMonth = false;
  bool perWeek = false;

  void _loadSavedImages() {
    List<dynamic>? savedImages = box.read('selectedImages');
    if (savedImages != null) {
      setState(() {
        _selectedImages = savedImages.map((path) => File(path)).toList();
      });
    }
  }

  void _saveImagePath(List<File> images) {
    List<String> paths = images.map((image) => image.path).toList();
    box.write('selectedImages', paths); // Save paths to GetStorage
  }

  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: SizeConfig.screenHeight *
            0.7, // Adjust this value to position it exactly where you want
        left: 2,
        right: 2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the snack bar after some time
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  Future<void> _pickImagesFromGallery() async {
    if (_selectedImages.length >= 5) {
      showTopSnackBar(context, 'You can only add up to 5 images.');
      return;
    }

    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        // Add selected images to the list, limit to 5
        _selectedImages.addAll(
          pickedFiles
              .map((file) => File(file.path))
              .take(5 - _selectedImages.length),
        );
      });
      _saveImagePath(_selectedImages); // Save image paths to GetStorage
    }
  }

  void updateText(String newText) {
    box.write('updatedTextCat', newText); // Save the new text
    setState(() {
      updatedTexts = newText; // Update the state to show the new text
    });
  }

  void _loadSavedTextCat() {
    String? savedTextCat = box.read('updatedTextCat'); // Retrieve saved text
    if (savedTextCat != null) {
      setState(() {
        updatedTexts = savedTextCat; // Update the U I with the saved text
      });
    }
  }

  void _loadSavedTextCity() {
    String? savedTextCity =
        box.read('updatedTextCit  y'); // Retrieve saved text
    if (savedTextCity != null) {
      setState(() {
        updatedCitys = savedTextCity; // Update the UI with the saved text
      });
    }
  }

  void updateTextCity(String newText) {
    box.write('updatedTextCity', newText); // Save the new text
    setState(() {
      updatedCitys = newText; // Update the state to show the new text
    });
  }

  // Function to update text and save it using GetStorage

  void _updateQuantity(int change) {
    setState(() {
      quantity += change;
      if (quantity < 0) quantity = 0; // Prevent negative quantity

      box.write('quantity', quantity);
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _loadSavedTextCat();
    _loadSavedTextCity();
    _loadSavedImages();

    quantity = box.read<int>('quantity') ?? 0;
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
                    height: SizeConfig.screenHeight * 0.23,
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
                                  color: CommonColor.showBottombar
                                      .withOpacity(0.2),
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
                              fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 13, right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffF1E7FB),
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.1,
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
                                      width:
                                          08), // Add some space between the avatar and the column
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        padding:
                                            EdgeInsets.only(left: 9, top: 2),
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
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
                    ),
                  ),
                  ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                            height: SizeConfig.screenHeight * 0.77,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.screenHeight * 0.04),
                              child: getAddGameTabLayout(
                                  SizeConfig.screenHeight,
                                  SizeConfig.screenWidth),
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
        child: Column(
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
                            () {
                              print(
                                  "Rendering productType: $productType"); // Debug print
                              return productType.isNotEmpty
                                  ? productType
                                  : 'Unknown Type';
                            }(),
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
              height: SizeConfig.screenHeight * 0.6,
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
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,

                                      keyboardType: TextInputType.text,
                                      controller: productNameController,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText:
                                            'Ex.HD Camera (black & white)',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffebd7fb),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
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
                                        hintText:
                                            'HD cameras capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black12, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImagePickerCarousel()));
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
                                    final String? result =
                                        await showModalBottomSheet<String>(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 7),
                                    child: Container(
                                      height: 60,
                                      width: SizeConfig.screenWidth * 0.9,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF5F6FB),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          (updatedTexts),
                                          style: TextStyle(
                                            color: Color(0xff7D7B7B),
                                            fontFamily: "Roboto_Regular",
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.5,
                                          ),
                                        ),
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
                                      padding:
                                          EdgeInsets.only(top: 13, left: 20),
                                      child: Container(
                                          width: parentWidth * 0.36,
                                          // padding: EdgeInsets.all(20), //padding of outer Container
                                          child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(10),

                                            color: CommonColor
                                                .Blue, //color of dotted/dash line
                                            strokeWidth:
                                                1, //thickness of dash/dots
                                            dashPattern: [4, 5],
                                            //dash patterns, 10 is dash width, 6 is space width
                                            child: GestureDetector(
                                                onTap: () {
                                                  _pickImagesFromGallery();
                                                  // _showFrontGallaryDialogBox(context);
                                                },
                                                child: Container(
                                                  //inner container
                                                  height: parentHeight *
                                                      0.14, //height of inner container
                                                  width: double.infinity,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: parentHeight *
                                                                0.01),
                                                        child: Image(
                                                            image: AssetImage(
                                                                'assets/images/uploadpic.png'),
                                                            height:
                                                                parentHeight *
                                                                    0.04),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        height: 26,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: CommonColor
                                                                  .Blue),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                              "Browser file",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          2.5,
                                                                  fontFamily:
                                                                      'Roboto_Regular',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  //overflow: TextOverflow.ellipsis,
                                                                  color:
                                                                      CommonColor
                                                                          .Blue)),
                                                        ),
                                                      ),
                                                    ],
                                                  ), //width to 100% match to parent container.
                                                  // color:Colors.yellow //background color of inner container
                                                )),
                                          )),
                                    ),
                                    if (_selectedImages.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: parentHeight * 0.02,
                                            left: parentWidth * 0.05),
                                        child: Container(
                                            height: 120,
                                            width: 170,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    child: AnotherCarousel(
                                                      images: _selectedImages
                                                          .map((image) {
                                                        return ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.file(
                                                            image,
                                                            fit: BoxFit.cover,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
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
                                            )),
                                      ),
                                    SizedBox(width: 17),
                                    if (_selectedImages.isEmpty)
                                      Center(
                                        child: Container(
                                          child: Text(
                                            'No images selected',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
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
                            height: SizeConfig.screenHeight * 0.14,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 12),
                                Text(
                                  "    City",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    // Navigate to the second screen and await the result
                                    final String? result =
                                        await showModalBottomSheet<String>(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      context: context,
                                      backgroundColor: Colors.white,
                                      elevation: 10,
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      builder: (BuildContext bc) {
                                        return CreateCity();
                                      },
                                    );

                                    // If a result is received (i.e., category was selected), update the text
                                    if (result != null) {
                                      updateTextCity(result);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 7),
                                    child: Container(
                                      height: 60,
                                      width: SizeConfig.screenWidth * 0.9,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF5F6FB),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          (updatedCitys),
                                          style: TextStyle(
                                            color: Color(0xff7D7B7B),
                                            fontFamily: "Roboto_Regular",
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                                  "    Current Product Adddress ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      focusNode: _productcurrentAddFocus,
                                      keyboardType: TextInputType.text,
                                      controller:
                                          productCurrentAddressController,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Current Product Address',
                                        contentPadding: EdgeInsets.all(10.0),
                                        hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          color: Color(0xff7D7B7B),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.5,
                                        ),
                                        fillColor: Color(0xffF5F6FB),
                                        hoverColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffebd7fb),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 22),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            height: SizeConfig.screenHeight * 0.08,
                            width: SizeConfig.screenWidth * 0.94,
                            child: Row(
                              children: [
                                Text(
                                  "    Product Exact Quantity",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "okra_Medium",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 21),
                                Container(
                                    height: 43,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF1E7FB),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              if (quantity > 0) {
                                                _updateQuantity(-1);
                                              }
                                            });
                                          },
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.white),
                                            child: Text(quantity.toString())),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              _updateQuantity(1);
                                            });
                                          },
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Stack(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: parentHeight * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  height: SizeConfig.screenHeight * 0.36,
                                  width: SizeConfig.screenWidth * 0.94,
                                ),
                              ),
                              SafeArea(
                                child: DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Color(0xff9584D6)),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: ButtonsTabBar(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomLeft,
                                                    colors: [
                                                      Color(0xffF1E7FB),
                                                      Color(0xffC0B5E8),
                                                    ],
                                                  )),
                                              buttonMargin:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              unselectedDecoration:
                                                  BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              unselectedBorderColor:
                                                  Color(0xffFE7F64),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              labelStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              tabs: [
                                                Tab(
                                                  child: Container(
                                                    height: 40,
                                                    width: 165,
                                                    child: Center(
                                                      child: Text(
                                                        "To Rent",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "okra-Medium",
                                                          fontSize: SizeConfig
                                                                  .blockSizeHorizontal *
                                                              3.6,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Tab(
                                                  child: Container(
                                                    height: 40,
                                                    width: 165,
                                                    padding: EdgeInsets.only(
                                                        left: 28, right: 20),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Center(
                                                        child: Text(
                                                          "To Sell",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "okra-Medium",
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                3.6,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                      ),

                                      // Remove fixed height here and use an Expanded widget
                                      Container(
                                        height: SizeConfig.screenHeight * 0.4,
                                        child: TabBarView(
                                          children: [
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 20,
                                                        top: 14),
                                                    child: Container(
                                                      height: 180,
                                                      width: 500,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffF1E7FB),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    'Per Hour'),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            15,
                                                                        top: 3),
                                                                    child: TextFormField(
                                                                        textAlign: TextAlign.start,

                                                                        // focusNode: _productNameFocus,
                                                                        keyboardType: TextInputType.number,
                                                                        controller: productPerHourController,
                                                                        autocorrect: true,
                                                                        textInputAction: TextInputAction.next,
                                                                        decoration: InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '₹ 1000',
                                                                          contentPadding: EdgeInsets.symmetric(
                                                                              vertical: 5,
                                                                              horizontal: 15),
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Roboto_Regular",
                                                                            color:
                                                                                Color(0xff7D7B7B),
                                                                            fontSize:
                                                                                SizeConfig.blockSizeHorizontal * 3.5,
                                                                          ),
                                                                          fillColor:
                                                                              Color(0xffF5F6FB),
                                                                          hoverColor:
                                                                              Colors.white,
                                                                          filled:
                                                                              true,
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child:
                                                                      Checkbox(
                                                                    value:
                                                                        perHour,
                                                                    onChanged:
                                                                        (bool?
                                                                            value) {
                                                                      setState(
                                                                          () {
                                                                        perHour =
                                                                            value!;
                                                                      });
                                                                    },
                                                                    visualDensity:
                                                                        VisualDensity
                                                                            .compact, // Optional: Adjusts checkbox size/density
                                                                    materialTapTargetSize:
                                                                        MaterialTapTargetSize
                                                                            .shrinkWrap,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 2),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    'Per Day '),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            24,
                                                                        right:
                                                                            15,
                                                                        top: 5),
                                                                    child: TextFormField(
                                                                        textAlign: TextAlign.start,

                                                                        // focusNode: _productNameFocus,
                                                                        keyboardType: TextInputType.number,
                                                                        controller: productPerDayController,
                                                                        autocorrect: true,
                                                                        textInputAction: TextInputAction.next,
                                                                        decoration: InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '₹ 1000',
                                                                          contentPadding: EdgeInsets.symmetric(
                                                                              vertical: 5,
                                                                              horizontal: 15),
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Roboto_Regular",
                                                                            color:
                                                                                Color(0xff7D7B7B),
                                                                            fontSize:
                                                                                SizeConfig.blockSizeHorizontal * 3.5,
                                                                          ),
                                                                          fillColor:
                                                                              Color(0xffF5F6FB),
                                                                          hoverColor:
                                                                              Colors.white,
                                                                          filled:
                                                                              true,
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value: perDay,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      perDay =
                                                                          value!;
                                                                    });
                                                                  },
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact, // Optional: Adjusts checkbox size/density
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    'Per Week'),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            17,
                                                                        right:
                                                                            15,
                                                                        top: 3),
                                                                    child: TextFormField(
                                                                        textAlign: TextAlign.start,

                                                                        // focusNode: _productNameFocus,
                                                                        keyboardType: TextInputType.number,
                                                                        controller: productPerWeekController,
                                                                        autocorrect: true,
                                                                        textInputAction: TextInputAction.next,
                                                                        decoration: InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '₹ 1000',
                                                                          contentPadding: EdgeInsets.symmetric(
                                                                              vertical: 5,
                                                                              horizontal: 15),
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Roboto_Regular",
                                                                            color:
                                                                                Color(0xff7D7B7B),
                                                                            fontSize:
                                                                                SizeConfig.blockSizeHorizontal * 3.5,
                                                                          ),
                                                                          fillColor:
                                                                              Color(0xffF5F6FB),
                                                                          hoverColor:
                                                                              Colors.white,
                                                                          filled:
                                                                              true,
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value:
                                                                      perWeek,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      perWeek =
                                                                          value!;
                                                                    });
                                                                  },
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact, // Optional: Adjusts checkbox size/density
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 5),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    'Per Month'),
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            13,
                                                                        right:
                                                                            15,
                                                                        top: 3),
                                                                    child: TextFormField(
                                                                        textAlign: TextAlign.start,

                                                                        // focusNode: _productNameFocus,
                                                                        keyboardType: TextInputType.number,
                                                                        controller: productPerMonthController,
                                                                        autocorrect: true,
                                                                        textInputAction: TextInputAction.next,
                                                                        decoration: InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          hintText:
                                                                              '₹ 1000',
                                                                          contentPadding: EdgeInsets.symmetric(
                                                                              vertical: 5,
                                                                              horizontal: 15),
                                                                          hintStyle:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                "Roboto_Regular",
                                                                            color:
                                                                                Color(0xff7D7B7B),
                                                                            fontSize:
                                                                                SizeConfig.blockSizeHorizontal * 3.5,
                                                                          ),
                                                                          fillColor:
                                                                              Color(0xffF5F6FB),
                                                                          hoverColor:
                                                                              Colors.white,
                                                                          filled:
                                                                              true,
                                                                          enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide.none,
                                                                              borderRadius: BorderRadius.circular(8.0)),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        )),
                                                                  ),
                                                                ),
                                                                Checkbox(
                                                                  value:
                                                                      perMonth,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      perMonth =
                                                                          value!;
                                                                    });
                                                                  },
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact, // Optional: Adjusts checkbox size/density
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                ),
                                                              ],
                                                            ),

                                                            /*  ElevatedButton(
                                                               onPressed: () {
                                                                 // Logic for what to do with selected checkboxes
                                                                 print('Per Day: $perDay');
                                                                 print('Per Hour: $perHour');
                                                                 print('Per Month: $perMonth');
                                                                 print('Per Week: $perWeek');
                                                               }, child: Container(),

                                                             ),*/
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Price",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "okra-Medium",
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                3.9,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        /*  Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 10, right: 10, top: 7),
                                                          child: Container(
                                                            height: 50,
                                                            width: SizeConfig.screenWidth * 0.3,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xffF5F6FB),
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(7)),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                               "Lowest Prise",
                                                                style: TextStyle(
                                                                  color: Color(0xff7D7B7B),
                                                                  fontFamily: "Roboto_Regular",
                                                                  fontSize:
                                                                  SizeConfig.blockSizeHorizontal *
                                                                      3.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),*/
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 40,
                                                                    top: 10),
                                                            child:
                                                                TextFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 2,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:

                                                                        productPriceController,
                                                                    autocorrect:
                                                                        true,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      hintText:
                                                                          '  Lowest Price',
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              1.0),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Roboto_Regular",
                                                                        color: Color(
                                                                            0xff7D7B7B),
                                                                        fontSize:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                3.5,
                                                                      ),
                                                                      fillColor:
                                                                          Color(
                                                                              0xffF5F6FB),
                                                                      hoverColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide
                                                                              .none,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0)),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Color(0xffebd7fb),
                                                                            width: 1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "rating",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "okra-Medium",
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                3.9,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        /*  Padding(
                                                          padding: EdgeInsets.only(
                                                              left: 10, right: 10, top: 7),
                                                          child: Container(
                                                            height: 50,
                                                            width: SizeConfig.screenWidth * 0.3,
                                                            decoration: BoxDecoration(
                                                              color: Color(0xffF5F6FB),
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(7)),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                               "Lowest Prise",
                                                                style: TextStyle(
                                                                  color: Color(0xff7D7B7B),
                                                                  fontFamily: "Roboto_Regular",
                                                                  fontSize:
                                                                  SizeConfig.blockSizeHorizontal *
                                                                      3.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),*/
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 40,
                                                                    top: 10),
                                                            child:
                                                                TextFormField(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    maxLines: 2,
                                                                    
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    controller:
                                                                        productRatingController,
                                                                    autocorrect:
                                                                        true,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      hintText:
                                                                          '  rating',
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              1.0),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Roboto_Regular",
                                                                        color: Color(
                                                                            0xff7D7B7B),
                                                                        fontSize:
                                                                            SizeConfig.blockSizeHorizontal *
                                                                                3.5,
                                                                      ),
                                                                      fillColor:
                                                                          Color(
                                                                              0xffF5F6FB),
                                                                      hoverColor:
                                                                          Colors
                                                                              .white,
                                                                      filled:
                                                                          true,
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide
                                                                              .none,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.0)),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                            color:
                                                                                Color(0xffebd7fb),
                                                                            width: 1),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                    )),
                                                          ),
                                                        ),
                                                      ],
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
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            double? rating =
                                double.tryParse(productRatingController.text);
                            int qty = quantity;
                            print("Quantity: $quantity");
                            print(
                                "productNameController: ${productNameController.text}");
                            print("updatedTexts: ${updatedTexts}");
                            print("_selectedImage: ${_selectedImages}");

                            if (rating != null && qty > 0) {
                              ApiClients()
                                  .PostCreateProductApi(
                                productNameController.text,
                                productDiscriptionController.text,
                                updatedTexts,
                                quantity,
                                _selectedImages,
                                rating, // Pass the rating as double
                                productCurrentAddressController.text,
                                productPriceController.text,
                              )
                                  .then((value) {
                                //  if (value.isEmpty) return;

                                print("type.. ${value['data']?['type']}");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainHome()));
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KYCVerifyScreen()));

                                /*  if (value['success'] == true) {
                                if (value['success']) {
                                  setState(() {
                                    productType = value['data']?['type']; // Update the type from the response
                                  });
                                  */ /*  Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()));*/ /*
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KYCVerifyScreen()));


                                }
                              }*/
                                if (value['success'] == true) {
                                  setState(() {
                                    productType =
                                        value['data']?['type'] ?? 'Unknown';
                                  });
                                } else {
                                  print(
                                      "Error: ${value['error'] ?? 'Failed to create product'}");
                                }

                                // }
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.screenHeight * 0.03,
                                left: parentWidth * 0.04,
                                right: parentWidth * 0.04),
                            child: Container(
                                width: parentWidth * 0.9,
                                height: parentHeight * 0.06,
                                decoration: BoxDecoration(
                                  /*  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        offset: Offset(1,1)),
                                  ],*/
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xffC0B5E8),
                                      Color(0xff9584D6),
                                    ],
                                  ),
                                  /*   border: Border.all(
                                            width: 1, color: CommonColor.APP_BAR_COLOR),*/ //Border.
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  "Add Product",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Roboto-Regular',
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4.2),
                                ))),
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
