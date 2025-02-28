import 'dart:io';
import 'dart:ui';

import 'package:anything/mm.dart';
import 'package:anything/secoundData.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'Common_File/ResponsiveUtil.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'MyBehavior.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dummyData.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'location_map.dart';

class NewService extends StatefulWidget {
  final String lat;
  final String long;
  String ProductAddress;
  String BusinessOfficeAddress;
  NewService(
      {super.key,
      required this.lat,
      required this.long,
      required this.ProductAddress,
      required this.BusinessOfficeAddress});

  @override
  State<NewService> createState() => _NewServiceState();
}

class _NewServiceState extends State<NewService> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerzoom;
  bool showTextField = false;
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

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessContactController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessGSTINController = TextEditingController();
  TextEditingController businessStartedController = TextEditingController();

  late PageController _pageController;
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  List<String> selectedDays = [];
  bool isDropdownOpen = false;
  final List<String> ribbons = ["CREATE PRODUCT", "CREATE BUSINESS PROFILE"];
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  final box = GetStorage();
  int currentIndex = 0;
  String updatedCitys = "Choose City";
  bool isDropdownOpenRent = false;
  bool isDropdownOpenSell = false;
  String? selectedCategory;
  bool isSelectedRent = false;
  bool isSelectedSell = false;
  bool perDay = false;
  bool perHour = false;
  bool perMonth = false;
  bool perWeek = false;
  int quantity = 0;

  void updateCitys(String newCity) {
    setState(() {
      updatedCitys = newCity;
      GetStorage().write('selectedCity', newCity);
    });
  }

  void _toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
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
        begin: Offset(1, 0),
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.2 * i,
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ));
    }

    _controller.forward();

    _controllerzoom = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 1.0,
      upperBound: 1.07,
    )..repeat(reverse: true);
  }

  void _updateQuantity(int change) {
    setState(() {
      quantity += change;
      if (quantity < 0) quantity = 0;
      box.write('quantity', quantity);
    });
  }

  void launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerzoom.dispose();
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

  File? _selectedImage;

  Future<void> _pickSingleImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Only 1 image
      });
    } else {
      print("❌ No Image Selected");
    }
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

  void _showDropdown(BuildContext context) async {
    List<String> tempSelectedDays = List.from(selectedDays); // ✅ Temporary list

    List<String>? result = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            // ✅ Dialog state update
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 200, // ✅ Dropdown ka size chhota kiya
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Select Days",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    Divider(),
                    Column(
                      children: days.map((day) {
                        return CheckboxListTile(
                          title: Text(day, style: TextStyle(fontSize: 12)),
                          value: tempSelectedDays.contains(day),
                          onChanged: (bool? value) {
                            setDialogState(() {
                              // ✅ Update inside dialog
                              if (value == true) {
                                tempSelectedDays.add(day);
                              } else {
                                tempSelectedDays.remove(day);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pop(
                            context, tempSelectedDays), // ✅ Return updated list
                        child: Text("Done",
                            style: TextStyle(color: Colors.purple)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedDays = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        'assets/images/servicess.jpg',
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
                          left: SizeConfig.screenWidth * 0.01,
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
        children: [
          SizedBox(height: 17),
          Text(
            "   Service Name",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffff979d).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 1,
                keyboardType: TextInputType.text,
                controller: productNameController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Volt Tech Solutions',
                  contentPadding:
                      EdgeInsets.only(left: 10, top: 14, bottom: 12),
                  hintStyle: TextStyle(
                    fontFamily: "Roboto_Regular",
                    color: Color(0xffa1a1a1),
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffd5abff), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 17),
          Text(
            "    Service Description",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 10, top: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffff979d).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  keyboardType: TextInputType.text,
                  controller: productDiscriptionController,
                  autocorrect: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Volt Tech Solutions',
                    contentPadding:
                        EdgeInsets.only(left: 10, top: 10, bottom: 12),
                    hintStyle: TextStyle(
                      fontFamily: "Roboto_Regular",
                      color: Color(0xffa1a1a1),
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                    ),
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      /*  borderSide:
                          BorderSide(color: Color(0xff943bf4), width: 0.5),*/
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffd5abff), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
            ),
          ),
          SizedBox(height: 15),
          Text(
            "    Add Service Images",
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
                  color: Color(0xfff12935),
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
                              image: AssetImage(
                                  'assets/images/upload_service.png'),
                              height: parentHeight * 0.04,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 26,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xfff12935)),
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
                                  color: Color(0xfff12935),
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
          SizedBox(height: 28),
          Text(
            "     City",
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "okra_Medium",
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Stack(
            children: [
              widget.ProductAddress.isEmpty
                  ? GestureDetector(
                      onTap: () async {
                        final selectedAddress = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationMapScreen()),
                        );

                        if (selectedAddress != null) {
                          setState(() {
                            widget.ProductAddress = selectedAddress;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.01,
                            left: parentWidth * 0.03,
                            right: parentWidth * 0.03),
                        child: Container(
                          height: parentHeight * 0.0603,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            /* border: Border.all(
                                color: Color(0xffd5abff).withOpacity(0.5)),*/

                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffff979d).withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/images/location.png'),
                                  color: Colors.black45,
                                  height: 18,
                                ),
                                Text(
                                  "    Select City",
                                  style: TextStyle(
                                    color: Color(0xff7D7B7B),
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.8,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Roboto-Regular',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        final selectedAddress = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationMapScreen()),
                        );

                        if (selectedAddress != null) {
                          setState(() {
                            widget.ProductAddress = selectedAddress;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.01,
                            left: parentWidth * 0.03,
                            right: parentWidth * 0.04),
                        child: Container(
                          decoration: BoxDecoration(
                            //   color: Color(0xffFFF0F0),
                            border: Border.all(
                                color: Color(0xffd5abff).withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 20, bottom: 10, left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/images/location.png'),
                                  color: Color(0xff7F96F0),
                                  height: 18,
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    widget.ProductAddress,
                                    style: TextStyle(
                                      color: Color(0xff7F96F0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Roboto-Medium',
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          ),
          SizedBox(
            height: parentHeight * 0.025,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => bbbttt(
                          )));
                },
                child: Text(
                  "   Select Availability",
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: "okra_Medium",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Stack(
                children: [
                  GestureDetector(
                    onTap: _toggleDropdown,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedDays.isEmpty
                                ? "Select Days"
                                : selectedDays
                                    .join(", "), // ✅ Selected days show
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                    ),
                  ),


                  if (isDropdownOpen)
                    Positioned(
                      top: 50,
                      left: 0,
                      width: 250,
                      child: Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: days.map((day) {
                              return CheckboxListTile(
                                title:
                                    Text(day, style: TextStyle(fontSize: 14)),
                                value: selectedDays.contains(day),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedDays.add(day);
                                    } else {
                                      selectedDays.remove(day);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: parentHeight * 0.030,
          ),
          Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 13, right: 13, top: 22, bottom: 20),
                child: IntrinsicHeight(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff632883).withOpacity(0.8),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                            animation: _controllerzoom,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _controllerzoom.value,
                                child: child,
                              );
                            },
                            child: Container(
                                height: 57,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xfff6f3ff),
                                      Color(0xffae94f3)
                                    ],
                                    center: Alignment.center,
                                    radius: 0.6,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xffFE7F64).withOpacity(0.5),
                                        blurRadius: 9,
                                        spreadRadius: 0,
                                        offset: Offset(0, 1)),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/warning.png'),
                                            height: 20,
                                            color: Colors.blueAccent,
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            width: SizeConfig.screenWidth * 0.7,
                                            child: Text(
                                                "On our platform, you can both sell and rent your products",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "Montserrat-Italic",
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12),
                                                maxLines: 2),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.94,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDropdownOpenRent = !isDropdownOpenRent;
                                  isSelectedRent = !isSelectedRent;
                                });
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xff624ffa),
                                                width: 01,
                                              ),
                                            ),
                                            child: isSelectedRent ||
                                                    isDropdownOpenRent
                                                ? Center(
                                                    child: Container(
                                                      width:
                                                          10, // Inner circle size
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color:
                                                            Color(0xff624ffa),
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "To Rent",
                                            style: TextStyle(
                                                fontFamily:
                                                    "Montserrat-BoldItalic",
                                                color: Color(0xff624ffa),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Spacer(),
                                          // Dropdown Icon
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isDropdownOpenRent =
                                                    !isDropdownOpenRent; // Toggle dropdown state
                                              });
                                            },
                                            child: Icon(
                                                isDropdownOpenRent
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                size: 28,
                                                color: Color(0xff624ffa)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isDropdownOpenRent)
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                perHour = !perHour;
                                              });
                                            },
                                            child: SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: perHour,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        perHour = value!;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  Text("Per Hour"),
                                                  if (perHour)
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 15),
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.start,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              PerHourController,
                                                          autocorrect: true,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            hintText: '₹ 1000',
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            5,
                                                                        horizontal:
                                                                            15),
                                                            hintStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  "Roboto_Regular",
                                                              color: Color(
                                                                  0xffacacac),
                                                              fontSize:
                                                                  14, // ✅ Adjust size if needed
                                                            ),
                                                            fillColor: Color(
                                                                0xffF5F6FB),
                                                            hoverColor:
                                                                Colors.white,
                                                            filled: true,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffebd7fb),
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                perDay = !perDay;
                                              });
                                            },
                                            child: SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: perDay,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        perDay = value!;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  Text("Per Day"),
                                                  if (perDay)
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 27,
                                                          right: 15,
                                                        ),
                                                        child: TextFormField(
                                                            textAlign:
                                                                TextAlign.start,

                                                            // focusNode: _productNameFocus,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                PerDayController,
                                                            autocorrect: true,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              hintText:
                                                                  '₹ 1000',
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          15),
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    "Roboto_Regular",
                                                                color: Color(
                                                                    0xffacacac),
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3.5,
                                                              ),
                                                              fillColor: Color(
                                                                  0xffF5F6FB),
                                                              hoverColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xffebd7fb),
                                                                    width: 1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                perWeek = !perWeek;
                                              });
                                            },
                                            child: SizedBox(
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: perWeek,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        perWeek = value!;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  Text("Per Week"),
                                                  if (perWeek)
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 16,
                                                          right: 15,
                                                        ),
                                                        child: TextFormField(
                                                            textAlign:
                                                                TextAlign.start,

                                                            // focusNode: _productNameFocus,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                PerWeekController,
                                                            autocorrect: true,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              hintText:
                                                                  '₹ 1000',
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          15),
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    "Roboto_Regular",
                                                                color: Color(
                                                                    0xffacacac),
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3.5,
                                                              ),
                                                              fillColor: Color(
                                                                  0xffF5F6FB),
                                                              hoverColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xffebd7fb),
                                                                    width: 1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                perMonth = !perMonth;
                                              });
                                            },
                                            child: Container(
                                              height: 42,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: perMonth,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        perMonth = value!;
                                                      });
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  Text("Per Month"),
                                                  if (perMonth)
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 11,
                                                          right: 15,
                                                        ),
                                                        child: TextFormField(
                                                            textAlign:
                                                                TextAlign.start,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                PerMonthController,
                                                            autocorrect: true,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .next,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              hintText:
                                                                  '₹ 1000',
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          15),
                                                              hintStyle:
                                                                  TextStyle(
                                                                fontFamily:
                                                                    "Roboto_Regular",
                                                                color: Color(
                                                                    0xffacacac),
                                                                fontSize: SizeConfig
                                                                        .blockSizeHorizontal *
                                                                    3.5,
                                                              ),
                                                              fillColor: Color(
                                                                  0xffF5F6FB),
                                                              hoverColor:
                                                                  Colors.white,
                                                              filled: true,
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0)),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xffebd7fb),
                                                                    width: 1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)),
                            width: SizeConfig.screenWidth * 0.94,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDropdownOpenSell = !isDropdownOpenSell;
                                  isSelectedSell =
                                      !isSelectedSell; // Toggle the selected state
                                });
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 13),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(
                                                    0xff624ffa), // Outer circle color
                                                width: 01,
                                              ),
                                            ),
                                            child: isSelectedSell ||
                                                    isDropdownOpenSell
                                                ? Center(
                                                    child: Container(
                                                      width:
                                                          10, // Inner circle size
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color(
                                                            0xff624ffa), // Inner circle color
                                                      ),
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          SizedBox(
                                              width:
                                                  10), // Space between checkbox and text
                                          Text(
                                            "To Sell",
                                            style: TextStyle(
                                                fontFamily:
                                                    "Montserrat-BoldItalic",
                                                color: Color(0xff624ffa),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Spacer(),
                                          // Dropdown Icon
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isDropdownOpenSell =
                                                    !isDropdownOpenSell; // Toggle dropdown state
                                              });
                                            },
                                            child: Icon(
                                                isDropdownOpenSell
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                size: 28,
                                                color: Color(0xff624ffa)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isDropdownOpenSell)
                                      Container(
                                        height: 60, // Limit the dropdown height
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 11,
                                            right: 15,
                                          ),
                                          child: TextFormField(
                                              textAlign: TextAlign.start,
                                              // focusNode: _productNameFocus,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: sellController,
                                              autocorrect: true,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText: '₹ 1000',
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 9,
                                                        horizontal: 15),
                                                hintStyle: TextStyle(
                                                  fontFamily: "Roboto_Regular",
                                                  color: Color(0xffacacac),
                                                  fontSize: SizeConfig
                                                          .blockSizeHorizontal *
                                                      3.5,
                                                ),
                                                fillColor: Color(0xffF5F6FB),
                                                hoverColor: Colors.white,
                                                filled: true,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xffe2bfff),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              )),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: parentHeight * 0.06,
                  width: parentWidth * 0.47,
                  decoration: BoxDecoration(
                    color: Color(0xff7937a1),
                    border: Border.all(color: Color(0xffe8a33e), width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/star.png'),
                            height: 22,
                          ),
                          Text(
                            "  DEAL ZONE  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "okra_Bold",
                              letterSpacing: 1.0,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/images/star.png'),
                            height: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showTextField = !showTextField; // Toggle visibility
              });
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    height: parentHeight * 0.08,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xffffa055),
                          Color(0xfffd4952),
                          Color(0xfffd4952),
                        ],
                      ),
                      border: Border.all(color: Color(0xffe8a33e), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.white, // Light color
                      highlightColor: Color(0xff632883), // Highlight color
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("CREATE BUSINESS PROFILE",
                              style: TextStyle(
                                  color: Color(0xff632883),
                                  fontFamily: "Montserrat-BoldItalic",
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 4.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.9),
                              overflow: TextOverflow.ellipsis),
                          Text(
                            "  (Optional)",
                            style: TextStyle(
                              color: Colors.grey[500]!,
                              fontFamily: "Roboto_Regular",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
                Image(
                    image: AssetImage('assets/images/business_pro.png'),
                    height: 50),
              ],
            ),
          ),
          if (showTextField)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "    Business Name",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd5abff).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: businessNameController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Business Name',
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 14, bottom: 12),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd5abff), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "    Business WhatsApss Contact",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd5abff).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: businessContactController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Business Name',
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 14, bottom: 12),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd5abff), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "    Business email",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd5abff).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: businessEmailController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Business Name',
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 14, bottom: 12),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd5abff), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "     Business Office Address",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Stack(
                children: [
                  widget.BusinessOfficeAddress.isEmpty
                      ? GestureDetector(
                          onTap: () async {
                            final selectedAddress = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationMapScreen()),
                            );

                            if (selectedAddress != null) {
                              setState(() {
                                widget.BusinessOfficeAddress = selectedAddress;
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: parentHeight * 0.01,
                                left: parentWidth * 0.03,
                                right: parentWidth * 0.03),
                            child: Container(
                              height: parentHeight * 0.0603,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                /* border: Border.all(
                                color: Color(0xffd5abff).withOpacity(0.5)),*/

                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffd5abff).withOpacity(0.3),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/location.png'),
                                      color: Colors.black45,
                                      height: 18,
                                    ),
                                    Text(
                                      "    Select Office Address",
                                      style: TextStyle(
                                        color: Color(0xff7D7B7B),
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.8,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto-Regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            final selectedAddress = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationMapScreen()),
                            );

                            if (selectedAddress != null) {
                              setState(() {
                                widget.BusinessOfficeAddress = selectedAddress;
                              });
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: parentHeight * 0.01,
                                left: parentWidth * 0.03,
                                right: parentWidth * 0.04),
                            child: Container(
                              decoration: BoxDecoration(
                                //   color: Color(0xffFFF0F0),
                                border: Border.all(
                                    color: Color(0xffd5abff).withOpacity(0.5)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, bottom: 10, left: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/location.png'),
                                      color: Color(0xff7F96F0),
                                      height: 18,
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        widget.BusinessOfficeAddress,
                                        style: TextStyle(
                                          color: Color(0xff7F96F0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Roboto-Medium',
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.only(top: 13, left: 20),
                child: GestureDetector(
                  onTap: _pickSingleImageFromGallery,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: parentHeight * 0.14,
                        width: parentWidth * 0.44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.8),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: _selectedImage == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,
                                      color: Colors.grey, size: 50),
                                  SizedBox(height: 10),
                                  Text(
                                    "Upload Business Image",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  _selectedImage!,
                                  width: double.infinity,
                                  height: parentHeight * 0.14, // Fixed height
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                      if (_selectedImage != null)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "    Business GESTIN",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd5abff).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: businessGSTINController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Business Name',
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 14, bottom: 12),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd5abff), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                "    Business Started Since",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 10, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd5abff).withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: businessStartedController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Business Name',
                      contentPadding:
                          EdgeInsets.only(left: 10, top: 14, bottom: 12),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd5abff), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Container(
                  height: ResponsiveUtil.height(90),
                  width: ResponsiveUtil().isMobile(context)
                      ? ResponsiveUtil.width(420)
                      : ResponsiveUtil().isTablet(context)
                          ? ResponsiveUtil.width(800)
                          : ResponsiveUtil.width(1600),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xff632883), width: 0.3),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ResponsiveUtil.width(13))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "FOLLOW US ON SOCIAL MEDIA",
                        style: TextStyle(
                          color: Color(0xff3d87f1),
                          fontFamily: "okra_Medium",
                          fontSize: 15,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => launchURL(
                                    "https://www.facebook.com/yourprofile"),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/facebook.png'),
                                  height: parentHeight * 0.024,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => launchURL(
                                    "https://www.youtube.com/yourchannel"),
                                child: Image(
                                  image: AssetImage('assets/images/youtub.png'),
                                  height: parentHeight * 0.028,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => launchURL(
                                    "https://www.instagram.com/yourprofile"),
                                child: Image(
                                  image: AssetImage('assets/images/insta.png'),
                                  height: parentHeight * 0.025,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => launchURL(
                                    "https://www.linkedin.com/in/yourprofile"),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/linkedIn.png'),
                                  height: parentHeight * 0.025,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: IntrinsicWidth(
              //  padding: const EdgeInsets.all(8.0),
              child: Container(
                height: parentHeight * 0.06,
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
                child: Text(
                  "Add Product",
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
          SizedBox(height: 17),
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
  String text = "ELECTRICAL SERVICES";
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
          "Create Service",
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
                  colors: [Color(0xfff12935), Color(0xffFF5963)],
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

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(10),
      ));

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
