import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../ConstantData/Constant_data.dart';
import 'package:intl/intl.dart';
import '../Authentication/forget_pass_OTP_verify.dart';

import '../MainHome.dart';
import '../MyBehavior.dart';
import '../NewDioClient.dart';
import '../location_map.dart';
import '../model/dio_client.dart';
import '../newGetStorage.dart';
class ProfileOption extends StatefulWidget {
  final VoidCallback option;
  final VoidCallback onServiceProfile;
  final VoidCallback onProductProfile;
  const ProfileOption({super.key, required this.option, required this.onServiceProfile, required this.onProductProfile});

  @override
  State<ProfileOption> createState() => _ProfileOptionState();
}

class _ProfileOptionState extends State<ProfileOption> {



  late String firstname;
  late String lastname;
  String phoneNumber = "Guest";
  String email = "Guest";
  late String gender;
  late String address;
  late String currentLocation;
  // late String currentCity;
  // late String currentLocation;
  // String profileImage = "";
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
  bool isProductEdit = false;
  bool isServiceEdit = false;

  TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();


  TextEditingController addressController = TextEditingController();



  bool isProfile = false;
  bool isProductProfile = false;
  bool isServiceProfile = false;


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

      print("API Response: $response");

      if (response.containsKey("error")) {
        print("❌ API Error: ${response["error"]}");
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

        print("Phone Number: ${phoneController.text}");
        print("Email: ${emailController.text}");

        print("✅ Profile Data Updated!");
      } else {
        print("❌ Error: Profile data not found in response");
      }
    } catch (e) {
      print("❌ Error Loading Profile: $e");
    }
  }


  Future<void> loadCurrentLocation() async {
    try {
      Map<String, dynamic> response = await NewApiClients().getCurrentLocation();

      print("🌍 API Response: $response");

      if (response.containsKey("error")) {
        print("❌ API Error: ${response["error"]}");
        return;
      }

      if (response.containsKey("currentLocation")) {
        Map<String, dynamic> location = response["currentLocation"];

        setState(() {
          // currentCity = location["city"] ?? "Unknown";
        });

        //  print("📍 Current City: $currentCity");

      } else {
        print("❌ Error: currentLocation not found in response");
      }
    } catch (e) {
      print("❌ Error Loading Location: $e");
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(

          children: [
            GestureDetector(
              onTap: () async {
                setState(() {
                  isProfile = !isProfile;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: 48,
                  width: SizeConfig.screenHeight * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            image: AssetImage(isProfile
                                ? 'assets/images/minus.png'
                                : 'assets/images/add.png'),
                            height: 15,
                            color: Color(0xfff44343),
                          ),
                        ],
                      )),
                ),
              ),
            ),
        
            if (isProfile)
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(

        
                  decoration: BoxDecoration(

                      //  color: Colors.white,
                      border: Border.all(color: Color(0xfff4823b), width: 0.5),
                      borderRadius:
                      BorderRadius.all(Radius.circular(ResponsiveUtil.width(5))),

                  ),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [


                              Padding(
                                padding:  EdgeInsets.only(left: 140,top: 10),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
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
                                        radius: ResponsiveUtil.width(40),
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: ResponsiveUtil.width(34),
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
                              Padding(
                                padding:  EdgeInsets.all(13.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isEditing = !isEditing;
                                    });
                                  },
                                  child: Container(
                                    height: ResponsiveUtil.height(37),
                                    width: ResponsiveUtil.width(90),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Edit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Montserrat-Medium",
                                          fontSize: ResponsiveUtil.fontSize(13),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
        
                        SizedBox(height: ResponsiveUtil.height(10)),
                        isEditing
                            ? _ProfileEditForm(SizeConfig.screenHeight, SizeConfig.screenWidth)
                            : mainProfileData(),
                      ],
                    ),
                  )
                ),
              ),
        
            GestureDetector(
              onTap: () async {
                setState(() {
                  isServiceProfile = !isServiceProfile;
                });

              },
              child: Padding(
                padding: EdgeInsets.only(top: 14, left: 10, right: 10),
                child: Container(
                  height: 45,
                  width: SizeConfig.screenHeight * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                            " Service Business Profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage(isServiceProfile
                                ? 'assets/images/minus.png'
                                : 'assets/images/add.png'),
                            height: 15,
                            color: Color(0xfff44343),
                          ),
                        ],
                      )),
                ),
              ),
            ),


            if (isServiceProfile)
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(


                    decoration: BoxDecoration(

                      //  color: Colors.white,
                      border: Border.all(color: Color(0xfff4823b), width: 0.5),
                      borderRadius:
                      BorderRadius.all(Radius.circular(ResponsiveUtil.width(5))),

                    ),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [


                                Padding(
                                  padding:  EdgeInsets.only(left: 140,top: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
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
                                          radius: ResponsiveUtil.width(40),
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: ResponsiveUtil.width(34),
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
                                      if (isServiceEdit)
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
                                Padding(
                                  padding:  EdgeInsets.all(13.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isServiceEdit = !isServiceEdit;
                                      });
                                    },
                                    child: Container(
                                      height: ResponsiveUtil.height(37),
                                      width: ResponsiveUtil.width(90),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Edit",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Montserrat-Medium",
                                            fontSize: ResponsiveUtil.fontSize(13),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: ResponsiveUtil.height(10)),
                          isServiceEdit
                              ? _ServiceEditForm(SizeConfig.screenHeight, SizeConfig.screenWidth)
                              : mainServiceData(),
                        ],
                      ),
                    )
                ),
              ),


            GestureDetector(
              onTap: () async {
                setState(() {
                  isProductProfile = !isProductProfile;
                });

              },
              child: Padding(
                padding: EdgeInsets.only(top: 14, left: 10, right: 10),
                child: Container(
                  height: 45,
                  width: SizeConfig.screenHeight * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.help_outline, // Icon before the text
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            " Product Business profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Image(
                            image: AssetImage(isProductProfile
                                ? 'assets/images/minus.png'
                                : 'assets/images/add.png'),
                            height: 15,
                            color: Color(0xfff44343),
                          ),
                        ],
                      )),
                ),
              ),
            ),




            if (isProductProfile)
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(


                    decoration: BoxDecoration(

                      //  color: Colors.white,
                      border: Border.all(color: Color(0xfff4823b), width: 0.5),
                      borderRadius:
                      BorderRadius.all(Radius.circular(ResponsiveUtil.width(5))),

                    ),
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [


                                Padding(
                                  padding:  EdgeInsets.only(left: 140,top: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
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
                                          radius: ResponsiveUtil.width(40),
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: ResponsiveUtil.width(34),
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
                                      if (isProductEdit)
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
                                Padding(
                                  padding:  EdgeInsets.all(13.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isProductEdit = !isProductEdit;
                                      });
                                    },
                                    child: Container(
                                      height: ResponsiveUtil.height(37),
                                      width: ResponsiveUtil.width(90),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Edit",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Montserrat-Medium",
                                            fontSize: ResponsiveUtil.fontSize(13),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: ResponsiveUtil.height(10)),
                          isProductEdit
                              ? _productEditForm(SizeConfig.screenHeight, SizeConfig.screenWidth)
                              : mainProductData(),
                        ],
                      ),
                    )
                ),
              ),
          ],
        ),
      ),
    );
  }



  Widget aadhaarProfile() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
            top: ResponsiveUtil.height(16)), // Responsive top padding
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

  Widget mainProfileData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: ResponsiveUtil.height(350),
        width: ResponsiveUtil.width(96),
        decoration: BoxDecoration(
        //  color: Colors.white,
          /*border: Border.all(color: Color(0xfff4823b), width: 0.3),
          borderRadius:
          BorderRadius.all(Radius.circular(ResponsiveUtil.width(13))),*/
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtil.width(18),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profileInfoRow("First Name", firstname),
              _profileInfoRow("Last Name", lastname),
              _profileInfoRow("Phone Number", phoneNumber),
              _profileInfoRow("Email", email),
              //  _buildInfoRow("CurrentLocation", currentCity),
              _profileInfoRow("permanentAddress", address),
              _profileInfoRow("Gender", gender),
              _profileInfoRow("Dob", '29-0-1999'),
              SizedBox(height: ResponsiveUtil.height(10)),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
              aadhaarProfile()
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileInfoRow(String label, String value) {
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
                fontSize: ResponsiveUtil.fontSize(13),
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
                fontSize: ResponsiveUtil.fontSize(12),
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


  Widget _ProfileEditForm(double parentHeight, double parentWidth) {
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
                fontSize: ResponsiveUtil.fontSize(13),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(7)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
                child: TextFormField(
                  controller: phoneController,
                  autocorrect: true,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.phone, size: 17),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    fillColor: Color(0xffFFFFFF),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.fontSize(13),
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
            )
,
            SizedBox(height: ResponsiveUtil.height(10)),
            Text(
              "Email",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(7)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
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
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.height(13),
                      fontFamily: "okra_Light",
                    ),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
            SizedBox(height: ResponsiveUtil.height(13)),
            Text(
              "Current Location",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.height(14),
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
                    top: SizeConfig.screenHeight * 0.01,),
                child: Container(
                  height: ResponsiveUtil.height(37),
                  width: ResponsiveUtil.width(140),
                  decoration: BoxDecoration(
    border: Border.all(color: Color(0xfff4823b), width: 0.5),

                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              "CurrentCity",
                              style: TextStyle(
                                color: Color(0xfff44343),
                                letterSpacing: 0.0,
                                fontFamily: "okra_Medium",
                                fontSize:
                                SizeConfig.blockSizeHorizontal *
                                    3.5,
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
              ),
            ),
            SizedBox(height: ResponsiveUtil.height(10)),
            Text(
              "DOB",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize:ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(8)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
                child: TextFormField(
                  controller: dobController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.date_range,size: ResponsiveUtil.height(15),),
                    ),
                    contentPadding: EdgeInsets.only(left: ResponsiveUtil.width(16)),
                    hintText: "Select DOB",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Montserrat-Medium",
                      fontSize: ResponsiveUtil.fontSize(13),
                      fontWeight: FontWeight.w500,
                    ),
                    fillColor: Color(0xffffffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
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
            ),

            SizedBox(height: ResponsiveUtil.height(20)),
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
                padding: EdgeInsets.only(left: ResponsiveUtil.width(12),bottom: ResponsiveUtil.height(15),
                    right: ResponsiveUtil.width(12)),
                child: Container(
                  width:ResponsiveUtil(). isMobile(context)
                      ? ResponsiveUtil.width(300)  // Small screen (mobile)
                      : ResponsiveUtil().isTablet(context)
                      ? ResponsiveUtil.width(1300) // Tablet screen
                      : ResponsiveUtil.width(1500), // Large screen (desktop)
                  height: ResponsiveUtil.height(45),
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

  Widget aadhaarService() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
            top: ResponsiveUtil.height(16)), // Responsive top padding
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

  Widget mainServiceData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
     //   height: ResponsiveUtil.height(40),
        width: ResponsiveUtil.width(96),
        decoration: BoxDecoration(
          //  color: Colors.white,
          /*border: Border.all(color: Color(0xfff4823b), width: 0.3),
          borderRadius:
          BorderRadius.all(Radius.circular(ResponsiveUtil.width(13))),*/
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtil.width(18),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _serviceInfoRow("Business GSTIN", firstname),
              _serviceInfoRow("Business Contact", lastname),
              _serviceInfoRow("Business email", phoneNumber),
              _serviceInfoRow("Business Started Since", phoneNumber),
              _serviceInfoRow("Preferred Location", email),
              //  _buildInfoRow("CurrentLocation", currentCity),
              _serviceInfoRow("To provide Services", address),
              _serviceInfoRow("Select Availability", address),
              _serviceInfoRow("Your Association With us", address),
              _serviceInfoRow("No .Of Users Contacted:", address),
              _serviceInfoRow("Follow Me", gender),

              SizedBox(height: ResponsiveUtil.height(10)),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
              aadhaarService()
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceInfoRow(String label, String value) {
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
                fontSize: ResponsiveUtil.fontSize(13),
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
                fontSize: ResponsiveUtil.fontSize(12),
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




  Widget _ServiceEditForm(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Business GSTIN",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
                child: TextFormField(
                  controller: phoneController,
                  autocorrect: true,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon:  Icon(Icons.numbers,size: ResponsiveUtil.height(15))


                    ),
                    contentPadding: EdgeInsets.only(
                        left: ResponsiveUtil.width(16)),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'GST NO',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.fontSize(13),
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
            ),
            SizedBox(height: ResponsiveUtil.height(10)),
            Text(
              "Business Contact",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
                child: TextFormField(
                  controller: emailController,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                        onPressed: () {},

                        icon:  Icon(Icons.phone,size: ResponsiveUtil.height(15))
                      /*icon: Image(
                          image: AssetImage('assets/images/email.png'),
                          height: ResponsiveUtil.height(20),
                        )*/
                    ),
                    contentPadding: EdgeInsets.only(
                        left: ResponsiveUtil.width(16)),
                    hintText: 'Business Contact',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.height(14),
                      fontFamily: "okra_Light",
                    ),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
     SizedBox(height: ResponsiveUtil.height(10)),
            Text(
              "Business Email",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox( height: ResponsiveUtil.height(40),

                child: TextFormField(
                  controller: emailController,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                        onPressed: () {},

                        icon:  Icon(Icons.email_outlined,size: ResponsiveUtil.height(15),)
                      /*icon: Image(
                          image: AssetImage('assets/images/email.png'),
                          height: ResponsiveUtil.height(20),
                        )*/
                    ),
                    contentPadding: EdgeInsets.only(
                        left: ResponsiveUtil.width(16)),
                    hintText: 'Business Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.height(14),
                      fontFamily: "okra_Light",
                    ),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
            SizedBox(height: ResponsiveUtil.height(20)),


            Text(
              "Business Started Since",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
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
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
            SizedBox(height: ResponsiveUtil.height(20)),
            Text(
              "Preferred Location",
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
                  top: SizeConfig.screenHeight * 0.01,),
                child: Container(
                  height: ResponsiveUtil.height(37),
                  width: ResponsiveUtil.width(140),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfff4823b), width: 0.5),

                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              "CurrentCity",
                              style: TextStyle(
                                color: Color(0xfff44343),
                                letterSpacing: 0.0,
                                fontFamily: "okra_Medium",
                                fontSize:
                                SizeConfig.blockSizeHorizontal *
                                    3.5,
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
              ),
            ),

            SizedBox(height: ResponsiveUtil.height(20)),

            Container(
              height: ResponsiveUtil.height(110),
              width: ResponsiveUtil.width(320),
              decoration: BoxDecoration(
                  color: Colors.white,
                border: Border.all(color: Color(0xfff4823b), width: 0.3),
          borderRadius:
          BorderRadius.all(Radius.circular(ResponsiveUtil.width(13))),
              ),child:
            ListView(
              children: [
                SizedBox(height: ResponsiveUtil.height(20)),
                Center(
                  child: Text(
                    "FOLLOW US ON SOCIAL MEDIA",
                    style: TextStyle(
                      color: Color(0xff3d87f1),
                      fontFamily: "okra_Medium",
                      fontSize: ResponsiveUtil.height(13),
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: ResponsiveUtil.height(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/facebook.png'),
                      height: parentHeight * 0.047,
                    ),
                    SizedBox(width: ResponsiveUtil.width(10)),

                    Image(
                      image: AssetImage('assets/images/youtub.png'),
                      height: parentHeight * 0.047,
                    ), SizedBox(width: ResponsiveUtil.width(10)),
                    Image(
                      image: AssetImage('assets/images/insta.png'),
                      height: parentHeight * 0.047,
                    ), SizedBox(width: ResponsiveUtil.width(10)),

                    Image(
                      image: AssetImage('assets/images/linkedIn.png'),
                      height: parentHeight * 0.045,
                    ),
                  ],
                ),

              ],
            ),
            ),
            SizedBox(height: ResponsiveUtil.height(20)),
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
                padding: EdgeInsets.only(left: ResponsiveUtil.width(12),bottom: ResponsiveUtil.height(20),
                    right: ResponsiveUtil.width(12)),
                child: Container(
                  width:ResponsiveUtil(). isMobile(context)
                      ? ResponsiveUtil.width(300)  // Small screen (mobile)
                      : ResponsiveUtil().isTablet(context)
                      ? ResponsiveUtil.width(1300) // Tablet screen
                      : ResponsiveUtil.width(1500), // Large screen (desktop)
                  height: ResponsiveUtil.height(45),
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


  Widget aadhaarProduct() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
            top: ResponsiveUtil.height(16)), // Responsive top padding
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

  Widget mainProductData() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: ResponsiveUtil.height(380),
        width: ResponsiveUtil.width(96),
        decoration: BoxDecoration(
          //  color: Colors.white,
          /*border: Border.all(color: Color(0xfff4823b), width: 0.3),
          borderRadius:
          BorderRadius.all(Radius.circular(ResponsiveUtil.width(13))),*/
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtil.width(18),

          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productInfoRow("Business GSTIN", firstname),
              _productInfoRow("Business Contact", lastname),
              _productInfoRow("Business email", phoneNumber),
              _productInfoRow("Product Actual Location", email),

              _productInfoRow("Business Started Since", address),
              _productInfoRow("No.Of Users Contacted", address),
              _productInfoRow("Follow Me", gender),
              SizedBox(height: ResponsiveUtil.height(10)),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
              aadhaarProduct()
            ],
          ),
        ),
      ),
    );
  }

  Widget _productInfoRow(String label, String value) {
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
                fontSize: ResponsiveUtil.fontSize(13),
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
                fontSize: ResponsiveUtil.fontSize(12),
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




  Widget _productEditForm(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtil.width(16)),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Business GSTIN",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
                child: TextFormField(
                  controller: phoneController,
                  autocorrect: true,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon:  Icon(Icons.numbers,size: ResponsiveUtil.height(15))


                    ),
                    contentPadding: EdgeInsets.only(
                        left: ResponsiveUtil.width(16)),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'GST NO',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.fontSize(13),
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
            ),
            SizedBox(height: ResponsiveUtil.height(10)),
            Text(
              "Business Contact",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
                child: TextFormField(
                  controller: emailController,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                        onPressed: () {},

                        icon:  Icon(Icons.phone,size: ResponsiveUtil.height(15))
                      /*icon: Image(
                          image: AssetImage('assets/images/email.png'),
                          height: ResponsiveUtil.height(20),
                        )*/
                    ),
                    contentPadding: EdgeInsets.only(
                        left: ResponsiveUtil.width(16)),
                    hintText: 'Business Contact',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.height(14),
                      fontFamily: "okra_Light",
                    ),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
            SizedBox(height: ResponsiveUtil.height(10)),
            Text(
              "Business Email",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox( height: ResponsiveUtil.height(40),

                child: TextFormField(
                  controller: emailController,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: IconButton(
                        onPressed: () {},

                        icon:  Icon(Icons.email_outlined,size: ResponsiveUtil.height(15),)
                      /*icon: Image(
                          image: AssetImage('assets/images/email.png'),
                          height: ResponsiveUtil.height(20),
                        )*/
                    ),
                    contentPadding: EdgeInsets.only(
                        left: ResponsiveUtil.width(16)),
                    hintText: 'Business Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: ResponsiveUtil.height(14),
                      fontFamily: "okra_Light",
                    ),
                    fillColor: Color(0xffFFfffff),
                    hoverColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
            SizedBox(height: ResponsiveUtil.height(20)),


            Text(
              "Business Started Since",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: ResponsiveUtil.fontSize(15),
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ResponsiveUtil.height(10)),
              child: SizedBox(
                height: ResponsiveUtil.height(40),
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
                        borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff4823b), width: 0.5),
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
            ),
            SizedBox(height: ResponsiveUtil.height(20)),
            Text(
              "Preferred Location",
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
                  top: SizeConfig.screenHeight * 0.01,),
                child: Container(
                  height: ResponsiveUtil.height(37),
                  width: ResponsiveUtil.width(140),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfff4823b), width: 0.5),

                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              "CurrentCity",
                              style: TextStyle(
                                color: Color(0xfff44343),
                                letterSpacing: 0.0,
                                fontFamily: "okra_Medium",
                                fontSize:
                                SizeConfig.blockSizeHorizontal *
                                    3.5,
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
                padding: EdgeInsets.only(left: ResponsiveUtil.width(12),bottom: ResponsiveUtil.height(12),
                    right: ResponsiveUtil.width(12)),
                child: Container(
                  width:ResponsiveUtil(). isMobile(context)
                      ? ResponsiveUtil.width(300)  // Small screen (mobile)
                      : ResponsiveUtil().isTablet(context)
                      ? ResponsiveUtil.width(1300) // Tablet screen
                      : ResponsiveUtil.width(1500), // Large screen (desktop)
                  height: ResponsiveUtil.height(45),
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
