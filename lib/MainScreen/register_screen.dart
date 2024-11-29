import 'dart:io';
import 'dart:ui';
import 'package:google_ml_kit/google_ml_kit.dart'; // For text recognition


import 'package:anything/Common_File/common_color.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../Common_File/SizeConfig.dart';
import '../ConstantData/Constant_data.dart';
import '../location_map.dart';
import 'package:get_storage/get_storage.dart';


import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String firstName;
  final String address;
  final String lat;
  final String long;
  final String lastname;
  final String email;
  final String password;
  final String cpassword;
  final String permanetAddress;
  final String mobileNumber;
  final String ProfilePicture;
  final String FrontImage;
  final String BackImage;

 /* final File FrontImage;
  final File BackImage;
*/
  const RegisterScreen({super.key, required this.address, required this.lat, required this.long, required this.ProfilePicture, /*required this.FrontImage, required this.BackImage*/ required this.firstName, required this.lastname, required this.email, required this.password, required this.cpassword, required this.permanetAddress, required this.mobileNumber, required this.FrontImage, required this.BackImage});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final box = GetStorage();
  final fields = <String, dynamic>{};
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _permanentAddressFocus = FocusNode();
  final _mobileNumber = FocusNode();
  late FocusNode focusNode;
  final formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool cPasswordVisible = true;
  bool isObscure = false;
  var chosenValue;
  final GlobalKey _tooltipKey = GlobalKey();
  bool showTooltip = true;

  void _validateAndShowTooltip() {
    if (emailController.text.isEmpty) {
      final dynamic tooltip = _tooltipKey.currentState;
      tooltip.ensureTooltipVisible(); // Show the tooltip if validation fails
    } else if (emailController.text.isEmpty) {
      setState(() {
        showTooltip = false;
      });
    }
  }

  bool isLoading = false;

  File? _imageFront;
  File? _imageBack;
  File? _imageProfile;



  Future<void> _pickImageFront(ImageSource source, bool isBackSide) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _imageFront = File(pickedFile.path);
        });

        bool isValid = await validateAadhaarImage(_imageFront!,);
        if (isValid) {
          await preprocessImage(_imageFront!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('This image is not valid for Aadhaar card.')),
          );
        }
      }
    } catch (e) {

    }
  }

  Future<bool> validateAadhaarImage(File file) async {

    return true;
  }

  Future<void> preprocessImage(File file) async {

    img.Image? image = img.decodeImage(file.readAsBytesSync());

    if (image != null) {

      img.Image grayscaleImage = img.grayscale(image);


      File processedFile = File('${file.path}_processed.jpg')..writeAsBytesSync(img.encodeJpg(grayscaleImage));


      await verifyAadhaar(processedFile);
    }
  }

  Future<void> verifyAadhaar(File file) async {
    final inputImage = InputImage.fromFile(file);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    print("Detected Text: ${recognizedText.text}");

    if (_containsAadhaarSpecificText(recognizedText.text)) {
      print("Valid Aadhaar card image.");
    } else {
      print("This is not a valid Aadhaar card.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('This image is not a valid Aadhaar card.')),
      );
    }

    textRecognizer.close();
  }

// Helper function to match Aadhaar-specific text
  bool _containsAadhaarSpecificText(String text) {
    final aadhaarKeywords = [
      "Aadhaar",
      "Unique Identification Authority of India",
      "UIDAI",
      "Aadhaar Number",
      "UID",
    ];

    for (String keyword in aadhaarKeywords) {
      if (text.contains(keyword)) {
        return true;
      }
    }

    RegExp aadhaarRegExp = RegExp(r'\d{4}\s\d{4}\s\d{4}');
    if (aadhaarRegExp.hasMatch(text)) {
      return true;
    }

    return false;
  }

  Future<void> _pickImageBack(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _imageBack = File(pickedFile.path);
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _pickImageProfile(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _imageProfile = File(pickedFile.path);
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _showFrontGallaryDialogBox(BuildContext context) {
    SizeConfig().init(context);
    showDialog(
        context: context,
        builder: (BuildContext context,) {
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
                        _pickImageFront(ImageSource.camera,false);
                        _pickImageFront(ImageSource.camera, true);
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.024),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/camerapop.png'),
                                height: 20,
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.024,
                                left: SizeConfig.screenHeight * 0.024),
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                  height: 2.5,
                                  fontSize: SizeConfig.blockSizeHorizontal *
                                      4.3,
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
                        _pickImageFront(ImageSource.gallery,false);
                        _pickImageFront(ImageSource.gallery,true);
                      },
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.0),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/gallerypop.png'),
                                height: 20,
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.screenHeight * 0.0,
                                left: SizeConfig.screenHeight * 0.024),
                            child: Text(
                              "Photos And Gallery Library",
                              style: TextStyle(
                                  height: 2.5,
                                  fontSize: SizeConfig.blockSizeHorizontal *
                                      4.3,
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
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight * 0.02),
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
  void _showBackGallaryDialogBox(BuildContext context) {
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
                      _pickImageBack(ImageSource.camera);

                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.024),
                          child:   Image(
                            image: AssetImage('assets/images/camerapop.png'),
                            height: 20,
                          )
                        ),
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
                      _pickImageBack(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.0),
                          child:  Image(
                            image: AssetImage('assets/images/gallerypop.png'),
                            height: 20,
                          )
                        ),
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

  void _showProfileGallaryDialogBox(BuildContext context) {
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
            //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageProfile(ImageSource.camera);

                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.024),
                      child:
                      Image(
                        image: AssetImage('assets/images/camerapop.png'),
                        height: 20,
                      )
                    ),
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
                  _pickImageProfile(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.0),
                      child:   Image(
                        image: AssetImage('assets/images/gallerypop.png'),
                        height: 20,
                      )
                    ),
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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  void saveFrontImages(List<Map<String, String>> frontImages) {
    box.write('frontImages', frontImages);  // Saving the list of images
  }

  // Fetch front images from local storage
  List<Map<String, String>> getFrontImages() {
    return box.read('frontImages') ?? [];
  }
  @override
  void initState() {
    super.initState();

    if(mounted){
      setState(() {
        firstNameController =  TextEditingController(text: widget.firstName);
        lastNameController = TextEditingController(text: widget.lastname);
        emailController = TextEditingController(text: widget.email);
        passwordController = TextEditingController(text: widget.password);
        confirmPasswordController = TextEditingController(text: widget.cpassword);
        permanentAddressController = TextEditingController(text: widget.permanetAddress);
        mobileNumberController = TextEditingController(text: widget.mobileNumber);
        if (widget.ProfilePicture.isNotEmpty) {
          // Convert path to File
          _imageProfile = File(widget.ProfilePicture);
        } else {
          // Set to null if no image path is provided
          AssetImage('assets/images/profiless.png');
        }
         if(widget.FrontImage.isNotEmpty){
           _imageFront = File(widget.FrontImage);
         }

        else{
           AssetImage(
               'assets/images/picremove.png');
         }

        if(widget.BackImage.isNotEmpty){
          _imageBack = File(widget.BackImage);
        }  else{
          AssetImage('assets/images/picremove.png');
        }

      });
    }

    passwordVisible = true;
    cPasswordVisible = true;
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }


    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastname);

    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    confirmPasswordController = TextEditingController(text: widget.cpassword);
    addressController = TextEditingController(text: widget.address);
    permanentAddressController = TextEditingController(text:widget.permanetAddress);
    mobileNumberController = TextEditingController(text: widget.mobileNumber);




  }

/*
  void _saveData() {
    // Save the data to GetStorage
    box.write('name', firstNameController.text);


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );
  }
*/



  @override
  void dispose() {
    firstNameController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff6a83da),
                  Color(0xff6a83da),
                ],
              )),
            ),
          ),
          Stack(
            children: [
              RegisterContent(SizeConfig.screenHeight, SizeConfig.screenWidth),
              NameData(SizeConfig.screenHeight, SizeConfig.screenWidth),

            ],
          ),

        ],
      ),
    );
  }

  Widget NameData(double parentHeight, double parentWidth) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.49, top: parentHeight * 0.03),
            child: PhysicalShape(
              color: Color(0xffd2ddf4),
              shadowColor: Colors.black.withOpacity(0.6),
              elevation: 10,
              clipper: ShapeBorderClipper(shape: CircleBorder()),
              child: Container(
                height: 150,
                width: 150,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: SizeConfig.screenWidth * 0.35,
              height: SizeConfig.screenHeight * 0.12,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100)),
                  color: Color(0xff87A2FC)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.7, top: parentHeight * 0.03),
            child: Image(
              image: AssetImage('assets/images/register.png'),
              height: parentHeight * 0.25,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.05, left: parentHeight * 0.02),
            child: Text(
              "Welcome Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat-Medium',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.09, left: parentHeight * 0.02),
            child: Text(
              "Create Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat-Regular',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showProfileGallaryDialogBox(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.20, left: parentWidth * 0.0),
              child: Stack(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        child: CircleAvatar(
                            radius: 35.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 10.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 14.0,
                                    color: Color(0xFF404040),
                                  ),
                                ),
                              ),
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: _imageProfile != null
                                  ? FileImage(_imageProfile!)
                                  : AssetImage('assets/images/profiless.png')
                                      as ImageProvider,
                            )
                            /* Container(
                                width: parentWidth*0.45,


                                child:

                                Image.file(_image!)),*/
                            ))),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget RegisterContent(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.28),
        child: Container(
          //height: parentHeight * 0.82,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color(0xff725858), blurRadius: 20.0)],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child:
              ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
            Register(SizeConfig.screenHeight, SizeConfig.screenWidth),
            RegisterButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
            SizedBox(
              height: 13,
            )
          ]),
        ));
  }

  Widget Register(double parentHeight, double parentWidth) {
    return Padding(
        padding:
            EdgeInsets.only(top: parentHeight * 0.04, left: parentWidth * 0.05),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First Name",
                      style: TextStyle(
                        color: CommonColor.RegisterText,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto-Regular',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: parentHeight * 0.01,
                          left: parentWidth * 0.0,
                          right: parentWidth * 0.04),
                      child: Container(

                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller:firstNameController,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              contentPadding: EdgeInsets.only(
                                left: parentWidth * 0.04,
                              ),
                              hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                color: Color(0xff7D7B7B),
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                // color: CommonColor.DIVIDER_COLOR,
                              ),
                              fillColor: Color(0xfffbf2f2),
                              hoverColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black12, width: 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Name",
                      style: TextStyle(
                        color: CommonColor.RegisterText,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto-Regular',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: parentHeight * 0.01,
                          left: parentWidth * 0.0,
                          right: parentWidth * 0.04),
                      child: Container(

                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: lastNameController,
                              autocorrect: true,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                contentPadding: EdgeInsets.only(
                                  left: parentWidth * 0.04,
                                ),
                                hintStyle: TextStyle(
                                  fontFamily: "Roboto_Regular",
                                  color: Color(0xff7D7B7B),
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.5,
                                  // color: CommonColor.DIVIDER_COLOR,
                                ),
                                fillColor: Color(0xffFFF0F0),
                                hoverColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            "Email",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.0,
                right: parentWidth * 0.04),
            child: Container(

                child: TextFormField(
                    focusNode: _emailFocus,
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
                      hintText: 'Email',
                      contentPadding: EdgeInsets.only(
                        left: parentWidth * 0.04,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xff7D7B7B),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        // color: CommonColor.DIVIDER_COLOR,
                      ),
                      fillColor: Color(0xffFFF0F0),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ))),
          ),
          SizedBox(
            height: parentHeight * 0.025,
          ),
          Text(
            "Password",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.0,
                right: parentWidth * 0.04),
            child: Container(

                child: TextFormField(
                    obscureText: passwordVisible,
                    focusNode: _passwordFocus,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/user.png'),
                            // height: 20,
                          )),
                      suffixIcon: Container(
                        height: 10,
                        width: 10,
                        child: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                isObscure = !isObscure;
                                passwordVisible = !passwordVisible;
                              },
                            );
                          },
                        ),
                      ),
                      hintText: 'Password',
                      contentPadding: EdgeInsets.only(
                        left: parentWidth * 0.04,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xff7D7B7B),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        // color: CommonColor.DIVIDER_COLOR,
                      ),
                      fillColor: Color(0xffFFF0F0),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ))),
          ),
          SizedBox(
            height: parentHeight * 0.025,
          ),
          Text(
            "Confirm Password",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.0,
                right: parentWidth * 0.04),
            child: Container(

                child: TextFormField(
                    obscureText: cPasswordVisible,
                    keyboardType: TextInputType.text,
                    focusNode: _confirmPasswordFocus,
                    controller: confirmPasswordController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/user.png'),
                            height: 20,
                          )),
                      suffixIcon: IconButton(
                        icon: Icon(cPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(
                            () {
                              isObscure = !isObscure;
                              cPasswordVisible = !cPasswordVisible;
                            },
                          );
                        },
                      ),
                      hintText: 'Confirm password',
                      contentPadding: EdgeInsets.only(
                        left: parentWidth * 0.04,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xff7D7B7B),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        // color: CommonColor.DIVIDER_COLOR,
                      ),
                      fillColor: Color(0xffFFF0F0),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ))),
          ),
          SizedBox(
            height: parentHeight * 0.025,

          ),
          Text(
            "Current Address",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),

          Stack(
            children: [

widget.address.isEmpty?
              GestureDetector(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationMapScreen(firstName: firstNameController.text, lastname: lastNameController.text, email: emailController.text, password: passwordController.text, cpassword: confirmPasswordController.text, permanetAddress: permanentAddressController.text, mobileNumber: mobileNumberController.text, ProfileImage:_imageProfile?.path ?? '', frontImage: _imageFront?.path ?? '', BackImage: _imageBack?.path ?? '',)),

                  );

                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.01,
                      left: parentWidth * 0.0,
                      right: parentWidth * 0.04),
                  child: Container(
                    height: parentHeight*0.065,
                    decoration: BoxDecoration(
                      color: Color(0xffFFF0F0),
                        borderRadius: BorderRadius.circular(10.0),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('assets/images/location.png'),
                            color: Colors.black45,
                            height: 18,
                          ),
                          Text(
                            "    Select Current Address",
                            style: TextStyle(
                              color: Color(0xff7D7B7B),
                              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Roboto-Regular',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ):
GestureDetector(
  onTap: (){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => LocationMapScreen(firstName: firstNameController.text, lastname: lastNameController.text, email: emailController.text, password: passwordController.text, cpassword: confirmPasswordController.text, permanetAddress: permanentAddressController.text, mobileNumber: mobileNumberController.text, ProfileImage:_imageProfile?.path ?? '', frontImage: _imageFront?.path?? '', BackImage: _imageBack?.path ?? '',

          //  recLane: widget.recLane,
        )));
  },
  child: Padding(
    padding: EdgeInsets.only(
        top: parentHeight * 0.01,
        left: parentWidth * 0.0,
        right: parentWidth * 0.04),
    child:Container(
      decoration: BoxDecoration(
        color: Color(0xffFFF0F0),
        borderRadius: BorderRadius.circular(10.0),

      ),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items at the top
          children: [
            Image(
              image: AssetImage('assets/images/location.png'),
              color: Color(0xff7F96F0),
              height: 18,
            ),
            SizedBox(width: 10), // Add some space between the icon and text
            Expanded(  // Allows the text to take up available space
              child: Text(
                widget.address,
                style: TextStyle(
                  color: Color(0xff7F96F0),
                  fontSize: 14, // Adjust font size accordingly
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto-Medium',
                ),
                maxLines: 3, // Maximum two lines
                overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
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
          Text(
            "Permanent Address",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.0,
                right: parentWidth * 0.04),
            child: Container(

                child: TextFormField(
                    keyboardType: TextInputType.text,
                    focusNode: _permanentAddressFocus,
                    controller: permanentAddressController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/user.png'),
                            height: 20,
                          )),
                      hintText: 'Permanent Address',
                      contentPadding: EdgeInsets.only(
                        left: parentWidth * 0.04,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xff7D7B7B),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        // color: CommonColor.DIVIDER_COLOR,
                      ),
                      fillColor: Color(0xffFFF0F0),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ))),
          ),
          SizedBox(
            height: parentHeight * 0.025,
          ),
          Text(
            "Mobile Number",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.0,
                right: parentWidth * 0.04),
            child: Container(

                child: TextFormField(
                    keyboardType: TextInputType.number,
                    autocorrect: true,
                    focusNode: _mobileNumber,
                    controller: mobileNumberController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/user.png'),
                            height: 20,
                          )),
                      hintText: 'Mobile Number',
                      contentPadding: EdgeInsets.only(
                        left: parentWidth * 0.04,
                      ),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xff7D7B7B),
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        // color: CommonColor.DIVIDER_COLOR,
                      ),
                      fillColor: Color(0xffFFF0F0),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ))),
          ),
          SizedBox(
            height: parentHeight * 0.025,
          ),
          Text(
            "Upload Adhar Card Document",
            style: TextStyle(
              color: Color(0xff242222),
              fontSize: SizeConfig.blockSizeHorizontal * 4.2,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto-Medium',
            ),
          ),
          /*  Padding(
            padding: EdgeInsets.only(
                right: parentWidth * 0.0, top: parentHeight * 0.01),
            child: Text(
              "Upload the following documents to get products/services",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                // fontWeight: FontWeight.normal,

                fontFamily: 'Roboto-Regular',
              ),
            ),
          ),*/
          Padding(
            padding: EdgeInsets.only(
                right: parentWidth * 0.0, top: parentHeight * 0.01),
            child: Text(
              "(Kindly Upload the documents either in JPEG, PNG format)",
              style: TextStyle(
                color: CommonColor.grayText,
                fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                // fontWeight: FontWeight.normal,

                fontFamily: 'Roboto-Regular',
              ),
            ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: parentWidth * 0.0),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/images/id.png'),
                  height: parentHeight * 0.03,
                  //color: Colors.blueAccent,
                ),
                Text(
                  "    ID Proof",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                      fontFamily: 'Poppins_Medium',
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                )
              ],
            ),
          ),
          SizedBox(height: 3),
         Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.02),
                  child: Text(
                    "(Aadhar Card)",
                    style: TextStyle(
                      color: CommonColor.bottomsheet,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                      // fontWeight: FontWeight.normal,

                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                ),
     /*         Padding(
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
              SizedBox(height: 26),*/
              SizedBox(height: 13),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                          width: parentWidth * 0.42,
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
                                _showFrontGallaryDialogBox(context);
                              },
                              child: _imageFront == null
                                  ? Container(
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
                                            child:  /*Image.network(frontImages[index]['url']!)*/ Image(
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
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top: 7,bottom: 5),
                                            child: Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  70))),
                                                  height: parentWidth * 0.256,
                                                  width: parentWidth * 0.256,
                                                  child: Image.file(_imageFront!,
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _imageFront = null;
                                              setState(() {});
                                            },
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: parentWidth * 0.03),
                                                child: Align(
                                                    alignment:
                                                    Alignment.bottomRight,
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      radius: 13.0,
                                                      child: Image(
                                                          image: AssetImage(
                                                              'assets/images/picremove.png'),
                                                          height:
                                                          parentHeight * 0.016),
                                                    ))
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          )),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: parentHeight * 0.0),
                        child: Text(
                          "Front Side",
                          style: TextStyle(
                            color: Color(0xff242222),
                            fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                            // fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat-Regular',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Container(
                        width: parentWidth *
                            0.42, // padding: EdgeInsets.all(20), //padding of outer Container
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(10),

                          color: CommonColor.Blue, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [4, 5],
                          //dash patterns, 10 is dash width, 6 is space width
                          child:  GestureDetector(
                            onTap: (){
                              _showBackGallaryDialogBox(context);
                            },
                                child: _imageBack == null
    ? Container(
                                    //inner container
                                    height: parentHeight *
                                        0.14, //height of inner container
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                                    fontFamily: 'Roboto_Regular',
                                                    fontWeight: FontWeight.w400,
                                                    //overflow: TextOverflow.ellipsis,
                                                    color: CommonColor.Blue)),
                                          ),
                                        ),
                                      ],
                                    ), //width to 100% match to parent container.
                                    // color:Colors.yellow //background color of inner container
                                  ):  Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top: 7,bottom: 5),
                                        child: Center(
                                          child: Container(
                                              height: parentWidth * 0.250,
                                              width: parentWidth * 0.250,
                                              child: Image.file(_imageBack!,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _imageBack = null;
                                          setState(() {});
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                right: parentWidth * 0.03),
                                            child: Align(
                                                alignment:
                                                Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 13.0,
                                                  child: Image(
                                                      image: AssetImage(
                                                          'assets/images/picremove.png'),
                                                      height:
                                                      parentHeight * 0.016),
                                                ))
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )

                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: parentHeight * 0.0),
                        child: Text(
                          "Back Side",
                          style: TextStyle(
                            color: Color(0xff242222),
                            fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                            // fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat-Regular',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
         )
        ]));
  }

  Widget RegisterButton(double parentWidth, double parentHeight) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {

              if (passwordController.text != confirmPasswordController.text) {
            print("Error: Password and Confirm Password do not match");
            // You can also show a UI error message here
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Passwords do not match'))
            );
            return;
          }
        /*
             if(mounted){
                setState(() {
                  isLoading = true;
                });
              }*/
            if (formKey.currentState != null) {
              final isValid = formKey.currentState!.validate();
              if (!isValid) return;
              // proceed with form submission or other logic
            } else {
              print("Form state is null");
            }




        /*else {*/
            // print("Full Name: ${fullNameController.text}");
           print("firstname: ${firstNameController.text}");
            print("lastname: ${lastNameController.text}");
            print("phoneNumber: ${mobileNumberController.text}");
            print("email: ${emailController.text}");
            print("password: ${passwordController.text}");
            print("cpassword: ${confirmPasswordController.text}");
            print("currentLocation: ${widget.lat}");
            print("PermanentAdd: ${permanentAddressController.text}");
            print("profileImage: ${_imageProfile}");
            print("frountImage: ${_imageFront}");
            print("backImage: ${_imageBack}");
            ApiClients()
                .registerDio(
              // fullNameController.text,
              firstNameController.text,
              lastNameController.text,
              mobileNumberController.text,
              emailController.text,
              passwordController.text,
              confirmPasswordController.text,
              _imageProfile,
              _imageFront,
              _imageBack,
              permanentAddressController.text,
              widget.lat,
              widget.long,

            )
                .then((value) {
              //  if (value.isEmpty) return;
              print("token...${value['token']}");
              print(value['data']);
              print("Loading: $isLoading");
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }


              if (value['success'] == true) {
                if (value['newUser']?['email'] != null) {}
                print("userId stored successfully: ${value['newUser']?['userId']}");
                GetStorage().write(
                    ConstantData.UserId, value['newUser']?['userId']);
                GetStorage().write(ConstantData.Useremail, value['newUser']?['email']);
                GetStorage().write(ConstantData.Userpassword, passwordController.text);



                GetStorage().write(
                    ConstantData.UserCpassword, confirmPasswordController.text);
                GetStorage().write(
                    ConstantData.UserParmanentAddress, value['newUser']?['permanentAddress']);
                GetStorage().write(
                    ConstantData.UserMobile, value['newUser']?['PhoneNumber']);
                GetStorage().write(
                    ConstantData.UserFirstName, value['newUser']?['firstName']);
                GetStorage().write(
                    ConstantData.UserLastName, value['newUser']?['lastName']);
                GetStorage().write(
                    ConstantData.UserFrontImage, value['newUser']?['frontImages']);
                GetStorage().write(
                    ConstantData.UserBackImage, value['newUser']?['backImages']);
                GetStorage().write(
                    ConstantData.UserProfileImage, value['newUser']?['profilePicture']);
                GetStorage().write(
                    ConstantData.Userlatitude, value['newUser']?['latitude']);
                GetStorage().write(
                    ConstantData.Userlongitude, value['newUser']?['longitude']);


                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KYCVerifyScreen()));

                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              }
            });
            // }
          },



          child: Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.05,
                left: parentWidth * 0.04,
                right: parentWidth * 0.04),
            child: Container(
                width: parentWidth * 0.77,
                height: parentHeight * 0.13,
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
                  /*   border: Border.all(
                      width: 1, color: CommonColor.APP_BAR_COLOR),*/ //Border.
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Center(
                    child: Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto-Regular',
                      fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                ))),
          ),
        ),

        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(
                    text: "Already have an account ?",
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto-Regular',
                        fontSize: 15),
                    children: [
                      TextSpan(
                        text: " Login",
                        style: TextStyle(
                            color: CommonColor.Blue,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Roboto-Regular',
                            fontSize: 17),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          print("jdfbsdff");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),


                            );
                          },
                      ),
                    ])),
          ],
        )
      ],
    );
  }
}
