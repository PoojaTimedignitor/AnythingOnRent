import 'dart:io';

import 'package:anything/MainHome.dart';
import 'package:anything/model/dio_client.dart';
import 'package:anything/newGetStorage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Authentication/forget_pass_OTP_verify.dart';
import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:get_storage/get_storage.dart';

import '../ConstantData/Constant_data.dart';
import '../MyBehavior.dart';
import '../NewDioClient.dart';
import 'package:intl/intl.dart';

import '../location_map.dart';


class Myprofiledetails extends StatefulWidget {
  final VoidCallback option;

  const Myprofiledetails({super.key, required this.option});

  @override
  State<Myprofiledetails> createState() => _MyprofiledetailsState();
}

class _MyprofiledetailsState extends State<Myprofiledetails> {
  late String firstname;
  late String lastname;
  String phoneNumber = "Guest";
  String email = "Guest";
  late String gender;
  late String address;
  late String currentLocation;

  Map<String, dynamic>? profileData;
  String? profileImage = GetStorage().read(ConstantData.UserProfileImage);

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _captureImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600;
  }
  bool isEditing = false;

  TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();


  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstname = NewAuthStorage.getFName() ?? "Guest";
    lastname = NewAuthStorage.getLName() ?? "Guest";
    address = NewAuthStorage.getAddress() ?? "Guest";
    gender = NewAuthStorage.getGender() ?? "Guest";
    print("address    $address");

    loadUserProfile();
    //loadCurrentLocation();

  }

  void _showGallaryDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtil.height(10)),
          ),
          title: Column(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _captureImageFromCamera();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ResponsiveUtil.height(20)),
                          child: Image(
                            image: AssetImage('assets/images/camerapop.png'),
                            height: ResponsiveUtil.height(20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ResponsiveUtil.height(20),
                            left: ResponsiveUtil.width(13),
                          ),
                          child: Text(
                            "Camera",
                            style: TextStyle(
                              height: 2.5,
                              fontSize: ResponsiveUtil.fontSize(16),
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImageFromGallery();
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: ResponsiveUtil.height(5)),
                          child: Image(
                            image: AssetImage('assets/images/gallerypop.png'),
                            height: ResponsiveUtil.height(20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ResponsiveUtil.height(5),
                            left: ResponsiveUtil.width(13),
                          ),
                          child: Text(
                            "Photos And Gallery Library",
                            style: TextStyle(
                              height: 2.5,
                              fontSize: ResponsiveUtil.fontSize(16),
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: ResponsiveUtil.height(20)),
                  child: Container(
                    width: ResponsiveUtil.width(120),
                    height: ResponsiveUtil.height(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ResponsiveUtil.height(10)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xffFF8B8B), Color(0xffFD6B6B)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          height: 2,
                          fontSize: ResponsiveUtil.fontSize(16),
                          fontFamily: 'Roboto_Medium',
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        dobController.text = formattedDate;
      });
    }
  }



  Future<void> loadUserProfile() async {
    try {
      Map<String, dynamic> response = await NewApiClients().getNewProfileData();

      print("api Response $response");

      if (response.containsKey("error")) {
        print("api Error ${response["error"]}");
        return;
      }

      if (response.containsKey("profileData")) {
        Map<String, dynamic> profile = response["profileData"];

        setState(() {
          phoneController.text = profile["phoneNumber"] ?? "";
          emailController.text = profile["email"] ?? "";
          profileImage = profile["profilePicture"] ?? "";


          phoneNumber = profile["phoneNumber"] ?? "Guest";
          email = profile["email"] ?? "Guest";


        });

        print("Phone Number ${phoneController.text}");
        print("Email ${emailController.text}");

        print("Data Updated");
      } else {
        print("Profile data not found");
      }
    } catch (e) {
      print("loading Profile: $e");
    }
  }


  Future<void> loadCurrentLocation() async {
    try {
      Map<String, dynamic> response = await NewApiClients().getCurrentLocation();

      print("api Response $response");

      if (response.containsKey("error")) {
        print("error ${response["error"]}");
        return;
      }

      if (response.containsKey("currentLocation")) {
        Map<String, dynamic> location = response["currentLocation"];

        setState(() {

        });



      } else {
        print("currentLocation response");
      }
    } catch (e) {
      print("loading Location $e");
    }
  }


  @override
  void dispose() {

    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Stack(
        children: [
          Container(
              //  height: ResponsiveUtil.height(MediaQuery.of(context).size.height * 0.76),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xfff1f2fd),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                  //  borderRadius: BorderRadius.circular(15)
                  ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
                    child: SizedBox(
                      height: ResponsiveUtil.height(300),
                      width: ResponsiveUtil.width(400),
                      child: Stack(
                        children: [
                          Positioned(
                            right: ResponsiveUtil.width(240),
                            child: Container(
                              height: ResponsiveUtil.height(
                                  300),
                              width: ResponsiveUtil.width(
                                  160), // Adjust width if needed
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/anythingsAdss.png"),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: ResponsiveUtil.width(270),
                            child: Container(
                              height: ResponsiveUtil.height(300),
                              width: ResponsiveUtil.width(160),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/anthingsAds.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ResponsiveUtil.height(150)),
                    child: Container(
                      height: ResponsiveUtil.height(250),
                      width: ResponsiveUtil.width(400),
                      child: Stack(
                        children: [
                          Positioned(
                            left: ResponsiveUtil.width(290),
                            child: Container(
                              height: ResponsiveUtil.height(250),
                              width: ResponsiveUtil.width(160),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/anyone.png"),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: ResponsiveUtil.width(310),
                            child: Container(
                              height: ResponsiveUtil.height(250),
                              width: ResponsiveUtil.width(160),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/anytwo.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          AllDetalisContaine(SizeConfig.screenHeight, SizeConfig.screenWidth),

        ],
      ),
    );
  }

  Widget AllDetalisContaine(double parentWidth, double parentHeight) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: ResponsiveUtil.height(10)),
              SizedBox(height: ResponsiveUtil.height(10)),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: ResponsiveUtil.height(45),
                    width: ResponsiveUtil.width(100),
                    margin: EdgeInsets.only(right: ResponsiveUtil.width(15)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        "Edit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat-Medium",
                          fontSize: ResponsiveUtil.fontSize(14),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: ResponsiveUtil.height(5)),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: ResponsiveUtil.width(45),
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: ResponsiveUtil.width(42),
                            backgroundColor: Colors.transparent,
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : (profileImage != null &&
                                        profileImage!.isNotEmpty)
                                    ? NetworkImage(profileImage!)
                                    : AssetImage('assets/images/profiless.png')
                                        as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                    if (isEditing)
                      Positioned(
                        bottom: ResponsiveUtil.height(0),
                        right: ResponsiveUtil.width(0),
                        child: GestureDetector(
                          onTap: () {
                            _showGallaryDialogBox(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(ResponsiveUtil.width(6)),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: ResponsiveUtil.fontSize(16),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveUtil.height(20)),
          isEditing
              ? _buildEditForm(SizeConfig.screenHeight, SizeConfig.screenWidth)
              : mainData(),
        ],
      ),
    );
  }



  Widget AadhaarVerification() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
            top: ResponsiveUtil.height(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Text(
                "Aadhaar Verification",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveUtil.fontSize(14),
                  fontFamily: "okra_Medium",
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/circle_check.png',
                    height: ResponsiveUtil.height(16),
                  ),
                  SizedBox(width: ResponsiveUtil.width(4)),
                  Text(
                    "Verify",
                    style: TextStyle(
                      fontFamily: "okra_Medium",
                      fontSize: ResponsiveUtil.fontSize(16),
                      color: Color(0xff1cb363),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: ResponsiveUtil.height(393),
        width: ResponsiveUtil.width(96),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ResponsiveUtil.width(13))),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtil.width(18),
            vertical: ResponsiveUtil.height(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow("First Name", firstname),
              _buildInfoRow("Last Name", lastname),
              _buildInfoRow("Phone Number", phoneNumber),
              _buildInfoRow("Email", email),

              _buildInfoRow("permanentAddress", address),
              _buildInfoRow("Gender", gender),
              _buildInfoRow("Dob", '29-0-1999'),
              SizedBox(height: ResponsiveUtil.height(10)),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
              AadhaarVerification()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtil.height(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Text(
              "$label :",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat-Medium",
                fontSize: ResponsiveUtil.fontSize(13),
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }





  Widget _buildEditForm(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Phone Number",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: TextFormField(
                controller: phoneController,
                autocorrect: true,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon:  Icon(Icons.phone)

                  
                  ),
                  contentPadding: EdgeInsets.only(
                      left: ResponsiveUtil.width(16)),
                  fillColor: Color(0xffFFfffff),
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: ResponsiveUtil.fontSize(15),
                    fontFamily: "okra_Light",
                  ),
                ),




                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: ResponsiveUtil.fontSize(13),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtil.height(20)),
            Text(
              "Email",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: TextFormField(
                controller: emailController,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: IconButton(
                      onPressed: () {},

                      icon:  Icon(Icons.email_outlined)
                      /*icon: Image(
                        image: AssetImage('assets/images/email.png'),
                        height: ResponsiveUtil.height(20),
                      )*/
                  ),
                  contentPadding: EdgeInsets.only(
                      left: ResponsiveUtil.width(16)),
                  hintText: 'email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: ResponsiveUtil.height(15),
                    fontFamily: "okra_Light",
                  ),
                  fillColor: Color(0xffFFfffff),
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: ResponsiveUtil.height(13),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtil.height(20)),
            Text(
              "Current Location",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.height(15),
                fontWeight: FontWeight.w600,
              ),
            ),
        GestureDetector(
          onTap: () async {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationMapScreen(),
              ),
            );
          //  loadCurrentLocation();

          },

/*            onTap: () async {
                          final String? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateCity()),
                          );
                          if (result != null) {
                            updateCity(result); // Update city if selected
                          }
                        },*/
              child: Padding(
                padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.03, left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: SizeConfig.screenHeight * 0.025,
                      color: Color(0xfff44343),
                    ),
                    Flexible(
                      child: Container(
                        width: 120,
                        child: Text(
                          "currentCity",
                          style: TextStyle(
                            color: Color(0xfff44343),
                            letterSpacing: 0.0,
                            fontFamily: "okra_Medium",
                            fontSize:
                            SizeConfig.blockSizeHorizontal *
                                3.7,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtil.height(20)),
            Text(
              "DOB",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize:ResponsiveUtil.fontSize(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: TextFormField(
                controller: dobController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: IconButton(
                    onPressed: () => _selectDate(context),
                    icon: Icon(Icons.date_range),
                  ),
                  contentPadding: EdgeInsets.only(left: ResponsiveUtil.width(16)),
                  hintText: "Select DOB",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Montserrat-Medium",
                    fontSize: ResponsiveUtil.fontSize(14),
                    fontWeight: FontWeight.w500,
                  ),
                  fillColor: Color(0xffffffff),
                  hoverColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: ResponsiveUtil.fontSize(15),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtil.height(30)),
            GestureDetector(
              onTap: () {
                setState(() {
                  isEditing = false;
                  isLoading = true;
                  ApiClients().editUserProfile(
                      nameController.text, phoneController.text,
                      emailController.text, addressController.text, _image)
                      .then((value) {
                    if (mounted) {
                      setState(() => isLoading = false);
                    }

                    ApiClients().getUserProfileData().then((value) {
                      if (!value.containsKey('user')) {
                        print("Invalid user data received.");
                        return;
                      }

                      final userData = value['user'];
                      GetStorage().write(
                          ConstantData.UserId, userData['userId']);
                      GetStorage().write(
                          ConstantData.UserFirstName, userData['firstName']);
                      GetStorage().write(
                          ConstantData.UserMobile, userData['phoneNumber']);
                      GetStorage().write(
                          ConstantData.Useremail, userData['email']);
                      GetStorage().write(ConstantData.UserProfileImage,
                          userData['profilePicture']);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainHome(
                                  lat: '', long: '', showLoginWidget: false),
                        ),
                      );
                    }).catchError((error) {
                      print("Error during profile update: $error");
                      setState(() => isLoading = false);
                    });
                  });
                });
              },
              child:  Padding(
                padding: EdgeInsets.only(left: ResponsiveUtil.width(12),
                    right: ResponsiveUtil.width(12)),
                child: Container(
                  width:ResponsiveUtil(). isMobile(context)
                      ? ResponsiveUtil.width(300)  // Small screen (mobile)
                      : ResponsiveUtil().isTablet(context)
                      ? ResponsiveUtil.width(1300) // Tablet screen
                      : ResponsiveUtil.width(1500), // Large screen (desktop)
                  height: ResponsiveUtil.height(50),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffFEBA69),
                        Color(0xffFE7F64),
                      ],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto-Regular',
                        fontSize: ResponsiveUtil.height(17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],


        ));
  }
  }
