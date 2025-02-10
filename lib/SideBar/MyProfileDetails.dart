import 'dart:io';

import 'package:anything/MainHome.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Authentication/forget_pass_OTP_verify.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:get_storage/get_storage.dart';

import '../ConstantData/Constant_data.dart';
import '../MyBehavior.dart';
import '../dummyData.dart';

class Myprofiledetails extends StatefulWidget {
  const Myprofiledetails({super.key});

  @override
  State<Myprofiledetails> createState() => _MyprofiledetailsState();
}

class _MyprofiledetailsState extends State<Myprofiledetails> {
  late final String firstname;
  late final String phoneNumber;
  late final String email;
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

  bool isEditing = false; // Controls edit mode

  String address = "123 Main Street, City, Country";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    setState(() {
      print("Saved image: ${GetStorage().read(ConstantData.UserMobile)}");

      firstname = GetStorage().read(ConstantData.UserFirstName) ?? "Guest";
      phoneNumber = GetStorage().read(ConstantData.UserMobile) ?? "Guest";
      email = GetStorage().read(ConstantData.Useremail) ?? "Guest";
      profileImage = GetStorage().read(ConstantData.UserProfileImage);

    });

    nameController.text = firstname;
    phoneController.text = phoneNumber;
    emailController.text = email;
    addressController.text = address;
    // TODO: implement initState
    super.initState();
  }

  void _showGallaryDialogBox(BuildContext context) {
    SizeConfig().init(context);
    showDialog(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Column(
            children: [
              Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();

                      _captureImageFromCamera();
                      /*    _pickImageFront(ImageSource.camera, false);
                      _pickImageFront(ImageSource.camera, true);*/
                    },
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.024),
                            child: Image(
                              image: AssetImage('assets/images/camerapop.png'),
                              height: 20,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.024,
                              left: SizeConfig.screenHeight * 0.024),
                          child: Text(
                            "Camera",
                            style: TextStyle(
                                height: 2.5,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImageFromGallery();
                      /*  _pickImageFront(ImageSource.gallery, false);
                      _pickImageFront(ImageSource.gallery, true);*/
                    },
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.0),
                            child: Image(
                              image: AssetImage('assets/images/gallerypop.png'),
                              height: 20,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.0,
                              left: SizeConfig.screenHeight * 0.024),
                          child: Text(
                            "Photos And Gallery Library",
                            style: TextStyle(
                                height: 2.5,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
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

                  /* AppPreferences.clearAppPreference();
                  Get.to(() => const  SignIn());*/
                },
                child: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                  child: Container(
                    width: SizeConfig.screenWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,

                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // stops: [0.8, 0.9],
                        colors: [Color(0xffFF8B8B), Color(0xffFD6B6B)],
                      ),

                      color: Color(0xffFF8B8B),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            height: 2,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text(
          "Profile Details",
          style: TextStyle(
            fontFamily: "Montserrat-Medium",
            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
            color: CommonColor.TextBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(

            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  height: 300,
                  width: 400,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 240,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anythingsAdss.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 270),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anthingsAds.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Container(
                  height: 250,
                  width: 400,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 290),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anyone.png"), // Replace with your image path
                              // fit: BoxFit.cover, // Adjusts the image to cover the entire screen
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 310),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/anytwo.png"), // Replace with your image path

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.76,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Color(0xfff1f2fd),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                  //  borderRadius: BorderRadius.circular(15)
                  ),
              child: AllDetalisContaine(
                  SizeConfig.screenHeight, SizeConfig.screenWidth),
            ),
          )
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

       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.33),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    _image != null
                        ? Padding(
                            padding: EdgeInsets.only(top: parentHeight * 0.05),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.1), // Shadow color
                                    blurRadius: 5, // Shadow blur
                                    offset:
                                        Offset(0, 2), // Shadow position (x, y)
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 35.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 32.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:FileImage(_image!)
                                  // Profile image
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(top: parentHeight * 0.05),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.1), // Shadow color
                                    blurRadius: 5, // Shadow blur
                                    offset:
                                        Offset(0, 2), // Shadow position (x, y)
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 35.0,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 32.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: (profileImage != null &&
                                          profileImage!.isNotEmpty)
                                      ? NetworkImage(
                                          profileImage!) // Display image from URL
                                      : AssetImage('assets/images/profiless.png')
                                          as ImageProvider,
                                  // Profile image
                                ),
                              ),
                            ),
                          ),
                    if (isEditing)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _showGallaryDialogBox(context);
                            // Handle camera icon tap here
                            print("Camera Icon Tapped");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                    width:
                        10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserProfileScreen()));
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditing = !isEditing; // Toggle editing mode
                      });
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.1),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.045,
                        width: MediaQuery.of(context).size.width * 0.22,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text("Listing ID:",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 16,
                  letterSpacing: 0.9,
                  fontWeight: FontWeight.w600,
                )),
          ),
          SizedBox(height: 5),
          Center(
            child: Text("AB2345",
                style: TextStyle(
                  color: Color(0xff3684F0),
                  fontFamily: "okra_Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(height: 20),
          isEditing
              ? _buildEditForm(SizeConfig.screenHeight, SizeConfig.screenWidth)
              : mainData(),
        ],
      ),
    );
  }

  Widget mainData() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.96,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Name", firstname),
            SizedBox(height: 10),
            _buildInfoRow("Phone Number", phoneNumber),
            SizedBox(height: 10),
            _buildInfoRow("Email", email),
            SizedBox(height: 10),
            _buildInfoRow("Address", address),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Text("$label :",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          SizedBox(width: 20),
          Flexible(
            flex: 2, // Adjusts space for the value
            child: Text(
              value, // Replace with actual user name
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat-Medium",
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          Padding(
            padding: EdgeInsets.only(
              top: parentHeight * 0.01,
            ),
            child: Container(
                child: TextFormField(
              // focusNode: _emailFocus,
              keyboardType: TextInputType.text,
              controller: nameController,
              autocorrect: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Image(
                      image: AssetImage('assets/images/email.png'),
                      height: 20,
                    )),
                contentPadding: EdgeInsets.only(
                  left: parentWidth * 0.04,
                ),
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
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
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
          SizedBox(height: parentHeight * 0.02),
          Text("Phone Number",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          Padding(
            padding: EdgeInsets.only(
              top: parentHeight * 0.01,
            ),
            child: Container(
                child: TextFormField(
              // focusNode: _emailFocus,
              keyboardType: TextInputType.text,
              controller: phoneController,
              autocorrect: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Image(
                      image: AssetImage('assets/images/email.png'),
                      height: 20,
                    )),
                contentPadding: EdgeInsets.only(
                  left: parentWidth * 0.04,
                ),
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
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
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
          SizedBox(height: parentHeight * 0.02),
          Text("Email",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.01),
            child: Container(
                child: TextFormField(
              // focusNode: _emailFocus,
              keyboardType: TextInputType.text,
              controller: emailController,
              autocorrect: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Image(
                      image: AssetImage('assets/images/email.png'),
                      height: 20,
                    )),
                contentPadding: EdgeInsets.only(
                  left: parentWidth * 0.04,
                ),
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
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
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
          SizedBox(height: parentHeight * 0.02),
          Text("Current Location",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          Padding(
            padding: EdgeInsets.only(
              top: parentHeight * 0.01,
            ),
            child: Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: addressController,
                autocorrect: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Image(
                      image: AssetImage('assets/images/email.png'),
                      height: 20,
                    ),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: parentWidth * 0.04,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Montserrat-Medium",
                    fontSize: 13,
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
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(height: parentHeight * 0.03),
          GestureDetector(
            onTap: () {
              setState(() {
                isEditing = false;
                isLoading = true;
                ApiClients()
                    .editUserProfile(
                     nameController.text,
                     phoneController.text,
                     emailController.text,
                  addressController.text,
                  _image
                    )
                    .then((value) {
                  /*if (value.containsKey("message") && value["message"] == "Authorization token missing") {
                    print("User is not authorized. Redirect to login.");
                    // Handle redirection or error notification
                    return;
                  }*/

                  if (mounted) {
                    setState(() => isLoading = false);
                  }

                  ApiClients().getUserProfileData().then((value) {
                    if (!value.containsKey('user')) {
                      print("Invalid user data received.");
                      return;
                    }
                  ApiClients().getUserProfileData().then((value) {
                    if (value.isEmpty) return;

                    GetStorage()
                        .write(ConstantData.UserId, value['user']['userId']);
                    GetStorage().write(
                        ConstantData.UserFirstName, value['user']['firstName']);
                    GetStorage().write(
                        ConstantData.UserMobile, value['user']['phoneNumber']);
                    GetStorage().write(
                        ConstantData.Useremail  , value['user']['email']);

                    GetStorage().write(ConstantData.UserProfileImage,
                        value['user']['profilePicture']);


                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainHome(lat: '', long: '',)),
                    );
                  });
                  }).catchError((error) {
                    print("Error during profile update: $error");
                    setState(() => isLoading = false);
                  });
                },);

               /* firstname = nameController.text;
                phoneNumber = phoneController.text;
                email = emailController.text;
                address = addressController.text;
                isEditing = false;*/ // Exit edit mode
              });
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: parentWidth * 0.04, right: parentWidth * 0.04),
              child: Container(
                  width: parentWidth * 0.77,
                  height: parentHeight * 0.06,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(1, 1)),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffFEBA69),
                        Color(0xffFE7F64),
                      ],
                    ),

                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto-Regular',
                        fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                  ))),
            ),
          ),
        ],
      ),
    );
  }
}
