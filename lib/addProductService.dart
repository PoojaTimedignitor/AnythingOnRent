import 'dart:io';

import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainHome.dart';
import 'package:anything/model/dio_client.dart';
import 'package:anything/ttttttttt.dart';
import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'CatagrioesList.dart';
import 'MyBehavior.dart';
import 'ResponseModule/getSubCatResponseModel.dart';
import 'createPostCity.dart';
import 'dummytwo.dart';
import 'ResponseModule/getSubCatResponseModel.dart' as subCatData;

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
  final _subCatControllerFocus = FocusNode();

  TextEditingController productNameController = TextEditingController();
  TextEditingController productCurrentAddressController =
      TextEditingController();

  TextEditingController PerHourController = TextEditingController();
  TextEditingController PerDayController = TextEditingController();
  TextEditingController PerWeekController = TextEditingController();
  TextEditingController PerMonthController = TextEditingController();
  TextEditingController productDiscriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productRatingController = TextEditingController();

  TextEditingController SubCatController = TextEditingController();

  late TabController _tabController;
  int currentIndex = 0;
  late PageController _pageController;

  String updatedTexts = "Choose Categories";
  String productType = "Product";
  String updatedCitys = "Choose City";
  bool isDropdownOpenRent = false;
  bool isDropdownOpenSell = false;
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  String? selectedCategory;
  String categoryId = '';
  int quantity = 0;
  bool isSelectedRent = false; // Checkbox selected state
  bool isSelectedSell = false; // Checkbox selected state
  bool perDay = false;
  bool perHour = false;
  bool perMonth = false;
  bool perWeek = false;

  bool isLoading = true;
  bool isChecked = false;
  String _selectedPrimaryOption = "";
  String _selectedSecondaryOption = "";
  bool _showPrimarySuggestions = false;
  bool _showSecondarySuggestions = false;

  Map<String, List<String>> _secondarySuggestions = {
    'apple': ['Color', 'Seed', 'Type'],
    'banana': ['Ripeness', 'Length', 'Taste'],
    'cherry': ['Size', 'Color', 'Type'],
  };

  void _onPrimaryTap() {
    setState(() {
      _showPrimarySuggestions = true;
      _showSecondarySuggestions = false; // Hide secondary list
    });
  }

  void _onPrimaryOptionTap(String option) {
    setState(() {
      _selectedPrimaryOption = option;
      SubCatController.text = option;
      _showPrimarySuggestions = false;
      _showSecondarySuggestions = true;
    });
  }

  void _onSecondaryOptionTap(String option) {
    setState(() {
      _selectedSecondaryOption = option;
      SubCatController.text = "$_selectedPrimaryOption -> $option";
      _showSecondarySuggestions = false;
    });
  }

  List<subCatData.Data> SubCat = [];
  List<subCatData.Data> filteredSubCat = [];

  void fetchSubCategories(String categoryId) async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> response =
          await ApiClients().getAllSubCat(categoryId);
      var jsonList = getSubCategories.fromJson(response);
      setState(() {
        SubCat = jsonList.data ?? [];
        filteredSubCat = List.from(SubCat);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching subcategories: $e");
    }
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

  void updateCitys(String newCity) {
    setState(() {
      updatedCitys = newCity;
      GetStorage().write('selectedCity', newCity);
    });
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

  /* void updateTextCity(String newText) {
    box.write('updatedTextCity', newText); // Save the new text
    setState(() {
      updatedCitys = newText; // Update the state to show the new text
    });
  }*/

  void _updateQuantity(int change) {
    setState(() {
      quantity += change;
      if (quantity < 0) quantity = 0; // Prevent negative quantity

      box.write('quantity', quantity);
    });
  }

  Future<bool?> _discardDialogBox() async {
    SizeConfig().init(context);
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Discard Changes?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(height: 10),
            Container(
              child: Text(
                "Are you sure you want to discard chnages?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Roboto-Medium",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context, false);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Container(
                      width: SizeConfig.screenWidth * 0.3,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // color: Colors.white,

                          border: Border.all(
                              color: CommonColor.SearchBar, width: 0.3)),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                    child: Container(
                      width: SizeConfig.screenWidth * 0.3,
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: Colors.white,

                        color: Color(0xfffb8a60),
                      ),
                      child: Center(
                        child: Text(
                          "Discard",
                          style: TextStyle(
                              height: 2,
                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (selectedCategory != null) {
      bool? discard = await _discardDialogBox();
      return discard ?? false;
    }
    return true;
  }

  void onCategoryChanged(String selectedCategoryId) {
    print("Selected Category ID in parent: $selectedCategoryId");
    fetchSubCategories(
        selectedCategoryId); // Fetch subcategories with the selected category ID
  }

/*  void _filterSuggestions(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the text field is cleared, show all suggestions
        _filteredSuggestions = _suggestions;
      } else {
        // Otherwise, filter suggestions based on the input query
        _filteredSuggestions = _suggestions
            .where((suggestion) =>
            suggestion.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }*/

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    quantity = box.read<int>('quantity') ?? 0;
    updatedCitys = GetStorage().read('selectedCity') ?? "Choose city";

    _pageController = PageController(initialPage: currentIndex);
    if (categoryId.isNotEmpty) {
      print("Selected Category ID: $categoryId");
      fetchSubCategories(categoryId);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xffF5F6FB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
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
                          SizedBox(height: 50),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (selectedCategory == null) {
                                      Navigator.pop(context);
                                    } else {
                                      _discardDialogBox();
                                    }
                                  },
                                  child: Icon(Icons.arrow_back),
                                ),
                                Text(
                                  "  Create Product / Service",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.4,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.transparent),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: SizeConfig.screenHeight * 0.0005,
                            color: CommonColor.SearchBar,
                          ),
                          SizedBox(height: 13),
                          Padding(
                            padding: EdgeInsets.only(left: 13, right: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(20)),
                              height: SizeConfig.screenHeight * 0.11,
                              child: Padding(
                                padding: EdgeInsets.only(left: 13),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundImage: AssetImage(
                                          "assets/images/profile.png"),
                                    ),
                                    SizedBox(width: 08),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 12),
                                        Text(
                                          "  Hii, Aaysha",
                                          style: TextStyle(
                                            color: Color(0xfff000000),
                                            fontFamily: "okra_Medium",
                                            fontSize: 17,
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
      ),
    );
  }

  Widget getAddGameTabLayout(double parentHeight, double parentWidth) {
    return DefaultTabController(
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
                      Color(0xff9f83f7),
                      Color(0xff9f83f7),
                    ],
                  ),
                ),
                buttonMargin: EdgeInsets.symmetric(horizontal: 18),
                unselectedDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                unselectedBorderColor: Color(0xffFE7F64),
                physics: NeverScrollableScrollPhysics(),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                            color: Colors.white,
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
          Container(
            height: SizeConfig.screenHeight * 0.6,
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Stack(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff3E3E3E).withOpacity(0.2),
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                      offset: Offset(0, 1)),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
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
                                            builder: (context) => dataaaaaa()));
                                  },
                                  child: Text(
                                    "    SELECT CATAGORIES",
                                    style: TextStyle(
                                      color: Color(0xff9e43f4),
                                      fontFamily: "okra_Medium",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
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
                                        return CatagriesList(
                                          onChanged: (value) {
                                            onCategoryChanged(value);
                                            setState(() {
                                              categoryId = value;
                                              selectedCategory = value;
                                            });
                                          },
                                          categoryId: categoryId,
                                        );
                                      },
                                    );

                                    if (result != null) {
                                      setState(() {
                                        categoryId = result;

                                        selectedCategory = result;
                                        updatedTexts = result;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 7),
                                    child: Container(
                                      height: 60,
                                      width: SizeConfig.screenWidth * 0.9,
                                      decoration: BoxDecoration(
                                        //   color: Color(0xffF5F6FB),

                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Color(0xffECE7FF),
                                            Color(0xfff9f6ff),
                                          ],
                                        ),

                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (updatedTexts),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Roboto_Medium",
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.9,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: Color(0xff675397),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Visibility(
                          visible: selectedCategory != null,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              height: SizeConfig.screenHeight * 0.15,
                              width: SizeConfig.screenWidth * 0.94,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      height: SizeConfig.screenHeight * 0.03,
                                      width: SizeConfig.screenWidth * 0.9,
                                      child: Text(
                                        "    Types of ${updatedTexts} categories",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "okra_Medium",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 5, right: 5, top: 10),
                                      child: TextField(
                                        controller: SubCatController,
                                        readOnly: true, // Prevent typing
                                        onTap:
                                            _onPrimaryTap, // Show primary suggestions on tap
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'SubCategories',
                                          contentPadding: EdgeInsets.all(10.0),
                                          hintStyle: TextStyle(
                                            fontFamily: "Roboto_Regular",
                                            color: Color(0xff7D7B7B),
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.5,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400]!,
                                                width: 1.0),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400]!,
                                                width:
                                                    1.0), // Focused underline color and width
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[400]!,
                                                width:
                                                    1.0), // Normal state underline
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => dddd()));
                                    },
                                    child: Text(
                                      "    Product Name",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "okra_Medium",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: TextFormField(
                                        enabled: selectedCategory != null,
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
                                            color: Color(0xffa1a1a1),
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
                                                color: Color(0xffD9D9D9),
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
                        ),
                        SizedBox(height: 27),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
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
                                        enabled: selectedCategory != null,
                                        textAlign: TextAlign.start,
                                        maxLines: 6,
                                        focusNode: _productDiscriptionFocus,
                                        keyboardType: TextInputType.text,
                                        controller:
                                            productDiscriptionController,
                                        autocorrect: true,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText:
                                              'HD cameras capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand',
                                          contentPadding: EdgeInsets.all(10.0),
                                          hintStyle: TextStyle(
                                            fontFamily: "Roboto_Regular",
                                            color: Color(0xffa1a1a1),
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
                        ),
                        SizedBox(height: 27),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              height: SizeConfig.screenHeight * 0.24,
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
                                  if (selectedCategory != null)
                                    Row(children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 13, left: 20),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: parentHeight *
                                                              0.01),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/images/uploadpic.png'),
                                                        height:
                                                            parentHeight * 0.04,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Container(
                                                      height: 26,
                                                      width: 100,
                                                      decoration: BoxDecoration(
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
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                2.5,
                                                            fontFamily:
                                                                'Roboto_Regular',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: CommonColor
                                                                .Blue,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: AnotherCarousel(
                                                    images: _selectedImages
                                                        .map((image) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                Dialog(
                                                              child: Stack(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    child: /*Container(

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
                                                                          SizeConfig.screenHeight *
                                                                              0.5,
                                                                      child: PageView
                                                                          .builder(
                                                                        controller:
                                                                            _pageController,
                                                                        itemCount:
                                                                            _selectedImages.length,
                                                                        onPageChanged:
                                                                            (index) {
                                                                          setState(
                                                                              () {
                                                                            currentIndex =
                                                                                index;
                                                                          });
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return Container(
                                                                            height:
                                                                                SizeConfig.screenHeight * 0.5,
                                                                            width:
                                                                                SizeConfig.screenWidth, // 80% of the screen height
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.transparent,
                                                                              borderRadius: BorderRadius.circular(12),
                                                                              image: DecorationImage(
                                                                                image: FileImage(_selectedImages[index]),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  if (currentIndex >
                                                                      0)
                                                                    Positioned(
                                                                      top: 180,
                                                                      left: 10,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.black.withOpacity(0.5),
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            IconButton(
                                                                          icon: Icon(
                                                                              Icons.arrow_back,
                                                                              color: Colors.white,
                                                                              size: 30),
                                                                          onPressed:
                                                                              () {
                                                                            if (currentIndex >
                                                                                0) {
                                                                              setState(() {
                                                                                currentIndex--;
                                                                              });
                                                                              _pageController.animateToPage(
                                                                                currentIndex,
                                                                                duration: Duration(milliseconds: 300),
                                                                                curve: Curves.easeInOut,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  // Forward Arrow
                                                                  if (currentIndex <
                                                                      _selectedImages
                                                                              .length -
                                                                          1)
                                                                    Positioned(
                                                                      top: 180,
                                                                      right: 10,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.black.withOpacity(0.5),
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            IconButton(
                                                                          icon: Icon(
                                                                              Icons.arrow_forward,
                                                                              color: Colors.white,
                                                                              size: 30),
                                                                          onPressed:
                                                                              () {
                                                                            if (currentIndex <
                                                                                _selectedImages.length - 1) {
                                                                              setState(() {
                                                                                currentIndex++;
                                                                              });
                                                                              _pageController.animateToPage(
                                                                                currentIndex,
                                                                                duration: Duration(milliseconds: 300),
                                                                                curve: Curves.easeInOut,
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),

                                                                  Positioned(
                                                                    right: 16,
                                                                    child:
                                                                        IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(context),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: ClipRRect(
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
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                int replaceIndex =
                                                    await _getReplaceIndex();
                                                if (replaceIndex != -1) {
                                                  //_pickImageForReplacement(replaceIndex);
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: parentWidth * 0.17),
                                                child: Container(
                                                  height: parentHeight * 0.04,
                                                  width: parentWidth * 0.22,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffF5F6FB),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Center(
                                                    child: Text(
                                                      " Replace",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "okra_Medium",
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            3.1,
                                                        color:
                                                            Color(0xff3684F0),
                                                        fontWeight:
                                                            FontWeight.w200,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      SizedBox(width: 17),
                                    ])
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 27),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
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
                                    onTap: selectedCategory != null
                                        ? () async {
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
                                        : null,
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
                                              color: Colors.black,
                                              letterSpacing: 0.5,
                                              fontFamily: "okra_Medium",
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4.0,
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
                        ),
                        SizedBox(height: 10),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
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
                                        enabled: selectedCategory != null,
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
                                            color: Color(0xffa1a1a1),
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
                        ),
                        SizedBox(height: 22),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
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
                                            onPressed:
                                                selectedCategory != null &&
                                                        quantity > 0
                                                    ? () {
                                                        setState(() {
                                                          _updateQuantity(-1);
                                                        });
                                                      }
                                                    : null,
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
                                            onPressed: selectedCategory != null
                                                ? () {
                                                    setState(() {
                                                      _updateQuantity(1);
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  width: SizeConfig.screenWidth * 0.94,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDropdownOpenRent =
                                            !isDropdownOpenRent;
                                        isSelectedRent =
                                            !isSelectedRent; // Toggle the selected state
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 13),
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
                                                    child: isSelectedRent ||
                                                            isDropdownOpenRent
                                                        ? Center(
                                                            child: Container(
                                                              width:
                                                                  10, // Inner circle size
                                                              height: 10,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
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
                                                    "To Rent",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat-BoldItalic",
                                                        color:
                                                            Color(0xff624ffa),
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 28,
                                                        color:
                                                            Color(0xff624ffa)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (isDropdownOpenRent)
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        value: perHour,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            perHour = value!;
                                                          });
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      Text("Per Hour"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        value: perDay,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            perDay = value!;
                                                          });
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      Text("Per Day"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        value: perWeek,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            perWeek = value!;
                                                          });
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      Text("Per Week"),
                                                      if (perWeek)
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10.0),
                                                          child: TextFormField(
                                                            controller: PerHourController,
                                                            decoration: InputDecoration(
                                                              labelText: "Enter value for Per Week",
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        value: perMonth,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            perMonth = value!;
                                                          });
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                      ),
                                                      Text("Per Month"),
                                                    ],
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /* SafeArea(
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
                                                        BorderRadius.circular(
                                                            7),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "okra-Medium",
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  3.6,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xffF1E7FB),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
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
                                                                          top:
                                                                              3),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
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
                                                                              .compact,
                                                                      materialTapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 2),
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
                                                                          top:
                                                                              5),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Checkbox(
                                                                    value:
                                                                        perDay,
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
                                                              SizedBox(
                                                                  height: 5),
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
                                                                          top:
                                                                              3),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
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
                                                              SizedBox(
                                                                  height: 5),
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
                                                                          top:
                                                                              3),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
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

                                                              */
                                  /*  ElevatedButton(
                                                                   onPressed: () {
                                                                     // Logic for what to do with selected checkboxes
                                                                     print('Per Day: $perDay');
                                                                     print('Per Hour: $perHour');
                                                                     print('Per Month: $perMonth');
                                                                     print('Per Week: $perWeek');
                                                                   }, child: Container(),

                                                                 ),*/
                                  /*
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
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "okra-Medium",
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  3.9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 40,
                                                                      top: 10),
                                                              child:
                                                                  TextFormField(
                                                                      textAlign: TextAlign
                                                                          .start,
                                                                      maxLines:
                                                                          2,
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
                                                                            EdgeInsets.all(1.0),
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
                                                                            borderSide:
                                                                                BorderSide.none,
                                                                            borderRadius: BorderRadius.circular(10.0)),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xffebd7fb),
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
                                ),*/
                                ),
                                SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  width: SizeConfig.screenWidth * 0.94,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDropdownOpenSell =
                                            !isDropdownOpenSell;
                                        isSelectedSell =
                                            !isSelectedSell; // Toggle the selected state
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 13),
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
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
                                                        color:
                                                            Color(0xff624ffa),
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                            ? Icons
                                                                .keyboard_arrow_up
                                                            : Icons
                                                                .keyboard_arrow_down,
                                                        size: 28,
                                                        color:
                                                            Color(0xff624ffa)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (isDropdownOpenSell)
                                              Container(
                                                height:
                                                    200, // Limit the dropdown height
                                                child: SingleChildScrollView(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 28.0,
                                                            top: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: double
                                                              .infinity, // Make the container fill the available width
                                                          child: Text(
                                                            "Option 1",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow: TextOverflow
                                                                .ellipsis, // Text will truncate with an ellipsis if it's too long
                                                            maxLines:
                                                                1, // Ensures the text stays on one line
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            "Option 2",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text(
                                                            "Option 3",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /* SafeArea(
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
                                                        BorderRadius.circular(
                                                            7),
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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "okra-Medium",
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  3.6,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xffF1E7FB),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
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
                                                                          top:
                                                                              3),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
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
                                                                              .compact,
                                                                      materialTapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 2),
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
                                                                          top:
                                                                              5),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                  Checkbox(
                                                                    value:
                                                                        perDay,
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
                                                              SizedBox(
                                                                  height: 5),
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
                                                                          top:
                                                                              3),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
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
                                                              SizedBox(
                                                                  height: 5),
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
                                                                          top:
                                                                              3),
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
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                                            hintStyle:
                                                                                TextStyle(
                                                                              fontFamily: "Roboto_Regular",
                                                                              color: Color(0xff7D7B7B),
                                                                              fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                            ),
                                                                            fillColor:
                                                                                Color(0xffF5F6FB),
                                                                            hoverColor:
                                                                                Colors.white,
                                                                            filled:
                                                                                true,
                                                                            enabledBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8.0)),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xffebd7fb), width: 1),
                                                                              borderRadius: BorderRadius.circular(8.0),
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

                                                              */
                                  /*  ElevatedButton(
                                                                   onPressed: () {
                                                                     // Logic for what to do with selected checkboxes
                                                                     print('Per Day: $perDay');
                                                                     print('Per Hour: $perHour');
                                                                     print('Per Month: $perMonth');
                                                                     print('Per Week: $perWeek');
                                                                   }, child: Container(),

                                                                 ),*/
                                  /*
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
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "okra-Medium",
                                                              fontSize: SizeConfig
                                                                      .blockSizeHorizontal *
                                                                  3.9,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 40,
                                                                      top: 10),
                                                              child:
                                                                  TextFormField(
                                                                      textAlign: TextAlign
                                                                          .start,
                                                                      maxLines:
                                                                          2,
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
                                                                            EdgeInsets.all(1.0),
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
                                                                            borderSide:
                                                                                BorderSide.none,
                                                                            borderRadius: BorderRadius.circular(10.0)),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Color(0xffebd7fb),
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
                                ),*/
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Opacity(
                          opacity: selectedCategory == null ? 0.3 : 1.0,
                          child: GestureDetector(
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
                                  rating,
                                  productCurrentAddressController.text,
                                  productPriceController.text,
                                )
                                    .then((value) {
                                  print("type.. ${value['data']?['type']}");
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainHome()));

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
                                            SizeConfig.blockSizeHorizontal *
                                                4.2),
                                  ))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_showPrimarySuggestions || _showSecondarySuggestions)
                      Padding(
                          padding:
                              EdgeInsets.only(top: 140, left: 10, right: 10),
                          child: Container(
                            height: parentHeight * 0.5,
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredSubCat.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Fashion Categories",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                }

                                final actualIndex = index - 1;

                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      visualDensity: VisualDensity(
                                          horizontal: 0, vertical: -4),
                                      minVerticalPadding: 0,
                                      title: Text(
                                        filteredSubCat[actualIndex].name ?? '',
                                        style: TextStyle(
                                          letterSpacing: 0.5,
                                          color: Colors.black,
                                          fontFamily: "Montserrat_Regular",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onTap: () => _onPrimaryOptionTap(
                                          filteredSubCat[index]
                                              .name
                                              .toString()[actualIndex]),
                                    ),
                                    Divider(
                                      color: CommonColor.SearchBar,
                                      thickness: 0.2,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ))
                  ]),
                ),
                Text('Service Tab'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
