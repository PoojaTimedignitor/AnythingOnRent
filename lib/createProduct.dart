import 'dart:io';
import 'dart:ui';

import 'package:anything/secoundData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'MyBehavior.dart';
import 'createPostCity.dart';
import 'dummyData.dart';
import 'package:get_storage/get_storage.dart';


import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({super.key});

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations = [];
  TextEditingController PerHourController = TextEditingController();
  TextEditingController PerDayController = TextEditingController();
  TextEditingController PerWeekController = TextEditingController();
  TextEditingController PerMonthController = TextEditingController();
  TextEditingController sellController = TextEditingController();
  TextEditingController productDiscriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productRatingController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productCurrentAddressController =
      TextEditingController();
  late PageController _pageController;

  final List<String> ribbons = ["CREATE PRODUCT", "CREATE BUSINESS PROFILE"];
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  int currentIndex = 0;
  String updatedCitys = "Choose City";

  void updateCitys(String newCity) {
    setState(() {
      updatedCitys = newCity;
      GetStorage().write('selectedCity', newCity);
    });
  }



  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    for (int i = 0; i < ribbons.length; i++) {
      _animations.add(Tween<Offset>(
        begin: Offset(1, 0), // Slide from right
        end: Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 * i, // Delay each ribbon slightly
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ));
    }

    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<int> _getReplaceIndex() async {
    int selectedIndex = -1;

    await showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Replace Image",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "okra_Medium",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Scrollable container for displaying images
                    Container(
                      height: 400,
                      width: 200, // Set the height for the scrollable container
                      child: ListView.builder(
                        itemCount: _selectedImages.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  selectedIndex =
                                      index; // Set the selected index
                                  await _pickImageForReplacement(selectedIndex);
                                  Navigator.pop(context); // Pick new image
                                  setState(
                                      () {}); // Refresh the dialog to show updated image
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 180,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image:
                                            FileImage(_selectedImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 99,
                                left: 164,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      // Remove the image when cancel icon is pressed
                                      _selectedImages.removeAt(index);
                                    });
                                    Navigator.pop(context); // Close the dialog
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    return selectedIndex; // Return the selected index
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
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      if (_selectedImages.length + pickedFiles.length <= 5) {
        setState(() {
          // Add the picked images as SelectedImage objects
          _selectedImages.addAll(
            pickedFiles.map((file) => File(file.path)),
          );
        });
      } else {
        showTopSnackBar(context, 'You can only add up to 5 images.');
      }
    }
  }

  Future<void> _pickImageForReplacement(int index) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImages[index] = File(pickedFile.path);
      });

      _getReplaceIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: SizeConfig.screenHeight * 0.42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/estione.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Back Button
                  Container(
                    height: 180,
                    child: Stack(
                      children: [
                        // Back Button (Top-Left)
                        Positioned(
                          left: SizeConfig.screenWidth * 0.05,
                          top: SizeConfig.screenHeight *
                              0.06, // Adjusted to fit inside container
                          child: Container(
                            height: SizeConfig.screenHeight * 0.05,
                            width: SizeConfig.screenHeight * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: CommonColor.grayText, width: 0.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: SizeConfig.screenHeight * 0.025,
                              ),
                            ),
                          ),
                        ),

                        // Ribbons (Top-Right)
                        Positioned(
                          top: 80,
                          right: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(ribbons.length, (index) {
                              return SlideTransition(
                                position: _animations[index],
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            Duration(milliseconds: 500),
                                        pageBuilder: (_, __, ___) =>
                                            SecondScreen(
                                                ribbonText: ribbons[index]),
                                        transitionsBuilder:
                                            (_, animation, __, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: RibbonShape(
                                      text: ribbons[index], isHero: true),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.22,
                        left: SizeConfig.screenWidth * 0.03),
                    child: SizedBox(
                        height: SizeConfig.screenHeight * 0.2,
                        child: AllInformationWidget(
                            SizeConfig.screenWidth, SizeConfig.screenHeight)),
                  ),
                ],
              ),
              Container(
                //  height: 600,
                child:
                    DataInfo(SizeConfig.screenHeight, SizeConfig.screenWidth),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget DataInfo(double parentHeight, double parentWidth) {
    return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text(
            "    Product Name",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: productNameController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Ex.HD Camera (black & white)',
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 14, bottom: 12),
                  hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    color: Color(0xffa1a1a1),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
          SizedBox(height: 15),
          Text(
            "    Product Description",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 2,
                keyboardType: TextInputType.text,
                controller: productNameController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Ex.HD Camera (black & white)',
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 14, bottom: 12),
                  hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    color: Color(0xffa1a1a1),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),  SizedBox(height: 15),
          Text(
            "    Add Product Images",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "okra_Medium",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(children: [
            Padding(
              padding: EdgeInsets.only(top: 13, left: 20),
              child: Container(
                width: parentWidth * 0.36,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  color: CommonColor.Blue,
                  strokeWidth: 1,
                  dashPattern: [4, 5],
                  child: GestureDetector(
                    onTap: () {
                      _pickImagesFromGallery();
                    },
                    child: Container(
                      height: parentHeight * 0.14,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: parentHeight * 0.01),
                            child: Image(
                              image: AssetImage('assets/images/uploadpic.png'),
                              height: parentHeight * 0.04,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 26,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: CommonColor.Blue),

                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Text(
                                "Browser file",
                                style: TextStyle(
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 2.5,
                                  fontFamily: 'Roboto_Regular',
                                  fontWeight: FontWeight.w400,
                                  color: CommonColor.Blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (_selectedImages.isNotEmpty)
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: parentHeight * 0.018,
                      left: parentWidth * 0.05,
                    ),
                    child: Container(
                      height: 122,
                      width: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: AnotherCarousel(
                          images: _selectedImages.map((image) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    child: Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child:
                                              /*Container(

                                                                        height: SizeConfig.screenHeight * 0.5,
                                                                        width: SizeConfig.screenWidth ,// 80% of the screen height

                                                                        decoration: BoxDecoration(
                                                                          color: Colors.transparent,
                                                                          borderRadius:
                                                                          BorderRadius.circular(12),
                                                                          image: DecorationImage(
                                                                            image: FileImage(image),
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),*/

                                              SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.5,
                                            child: PageView.builder(
                                              controller: _pageController,
                                              itemCount: _selectedImages.length,
                                              onPageChanged: (index) {
                                                setState(() {
                                                  currentIndex = index;
                                                });
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height:
                                                      SizeConfig.screenHeight *
                                                          0.5,
                                                  width: SizeConfig
                                                      .screenWidth, // 80% of the screen height
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          _selectedImages[
                                                              index]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),

                                        if (currentIndex > 0)
                                          Positioned(
                                            top: 180,
                                            left: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: IconButton(
                                                icon: Icon(Icons.arrow_back,
                                                    color: Colors.white,
                                                    size: 30),
                                                onPressed: () {
                                                  if (currentIndex > 0) {
                                                    setState(() {
                                                      currentIndex--;
                                                    });
                                                    _pageController
                                                        .animateToPage(
                                                      currentIndex,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeInOut,
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        // Forward Arrow
                                        if (currentIndex <
                                            _selectedImages.length - 1)
                                          Positioned(
                                            top: 180,
                                            right: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: IconButton(
                                                icon: Icon(Icons.arrow_forward,
                                                    color: Colors.white,
                                                    size: 30),
                                                onPressed: () {
                                                  if (currentIndex <
                                                      _selectedImages.length -
                                                          1) {
                                                    setState(() {
                                                      currentIndex++;
                                                    });
                                                    _pageController
                                                        .animateToPage(
                                                      currentIndex,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeInOut,
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),

                                        Positioned(
                                          right: 16,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            );
                          }).toList(),
                          dotSize: 6,
                          dotSpacing: 10,
                          dotColor: Colors.white70,
                          dotIncreasedColor: Colors.black45,
                          indicatorBgPadding: 5.0,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      int replaceIndex = await _getReplaceIndex();
                      if (replaceIndex != -1) {
                        //_pickImageForReplacement(replaceIndex);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: parentWidth * 0.17),
                      child: Container(
                        height: parentHeight * 0.04,
                        width: parentWidth * 0.22,
                        decoration: BoxDecoration(
                            color: Color(0xffF5F6FB),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            " Replace",
                            style: TextStyle(
                              fontFamily: "okra_Medium",
                              fontSize: SizeConfig.blockSizeHorizontal * 3.1,
                              color: Color(0xff3684F0),
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

          ]),
          SizedBox(height: 20),
          Text





            (
            "    City",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap:  () async {
              final String? result =
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CreateCityCreatePost()));

              if (result != null) {
                updateCitys(result);
              }
            }
            ,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: 7),
              child: Container(
                height: 50,
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(color: Color(0xff943bf4), width: 0.5),

                  borderRadius: BorderRadius.all(
                      Radius.circular(7)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    (updatedCitys),
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontFamily: "okra_Medium",
                      fontSize: SizeConfig
                          .blockSizeHorizontal *
                          3.8,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            "    Product Current Address",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: productNameController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Ex.HD Camera (black & white)',
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 14, bottom: 12),
                  hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    color: Color(0xffa1a1a1),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
          SizedBox(height: 12),
          Text(
            "    Product Name",
            style: TextStyle(
              color: Color(0xff521875),
              fontFamily: "okra_Medium",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: productNameController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Ex.HD Camera (black & white)',
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 14, bottom: 12),
                  hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    color: Color(0xffa1a1a1),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
          SizedBox(height: 12),
          Text(
            "    Product Name",
            style: TextStyle(
              color: Color(0xff521875),
              fontFamily: "okra_Medium",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: productNameController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Ex.HD Camera (black & white)',
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 14, bottom: 12),
                  hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    color: Color(0xffa1a1a1),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff943bf4), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
        ]);
  }
}

class AllInformationWidget extends StatefulWidget {
  final double parentHeight;
  final double parentWidth;

  AllInformationWidget(this.parentHeight, this.parentWidth);

  @override
  _AllInformationWidgetState createState() => _AllInformationWidgetState();
}

class _AllInformationWidgetState extends State<AllInformationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _animation;
  String text = "PET WORLD";
  TextEditingController productNameController = TextEditingController();

  late Animation<double> _scaleAnimation;
  late AnimationController _controllerss;
  late AnimationController _scaleController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-0.1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Smooth effect
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    repeatAnimation();

    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerss, curve: Curves.easeOutBack),
    );

    _controllerss = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      upperBound: 2.0, // Loop exactly 2 times
    );


    _controllerss.repeat().whenComplete(() {
      setState(() {
        _isVisible = false;
      });
    });
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);


    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );
  }


  void repeatAnimation() async {
    while (mounted) {
      await _controller.forward();
      await Future.delayed(Duration(milliseconds: 800));
      await _controller.reverse();
      await Future.delayed(Duration(milliseconds: 800));
    }
  }



  @override
  void dispose() {
    _controller.dispose();
    _controllerss.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: "Montserrat-BoldItalic",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    double textWidth = textPainter.width + 30;
    double textHeight = textPainter.height + 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Create Product",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat-Bold",
            fontSize: SizeConfig.blockSizeHorizontal * 5.9,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.004),
        Text(
          "Hi, Aayshaaa",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat_Medium',
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.005),
        Text(
          "Generating ideas for new product",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Montserrat-Medium",
            fontSize: SizeConfig.blockSizeHorizontal * 3.7,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _controllerss,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SnakeBorderPainter(progress: _controllerss.value),
                    child: Container(
                      width: textWidth,
                      height: textHeight,
                    ),
                  );
                },
              ),
            ),
            Container(
              width: textWidth,
              height: textHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff632883), Color(0xff8d42a3)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: "Montserrat-BoldItalic",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SnakeBorderPainter extends CustomPainter {
  final double progress;
  SnakeBorderPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height),
        [
          Color(0xffe8a33e),
          Color(0xffe8a33e),
        ],
      );

    // Define path for rounded rectangle
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(10),
      ));

    // Animate the path using dash effect
    final PathMetrics pathMetrics = path.computeMetrics();
    for (var metric in pathMetrics) {
      final double pathLength = metric.length;
      final double start = (progress * pathLength) % pathLength;
      final double end = start + pathLength * 0.9;

      final Path extractPath = metric.extractPath(start, end);
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(SnakeBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
