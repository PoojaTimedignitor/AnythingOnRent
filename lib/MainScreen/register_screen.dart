
import 'dart:io';

import 'package:anything/Common_File/common_color.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../Common_File/SizeConfig.dart';
import '../ConstantData/Constant_data.dart';
import 'login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fields = <String, dynamic>{};
  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _addressFocus = FocusNode();
  final _permanentAddressFocus = FocusNode();
  final _mobileNumber = FocusNode();
  late FocusNode focusNode;

  bool isLoading = false;

  File? _image;
  final _images = <XFile>[];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }



  void _showGallaryDialogBox(BuildContext context) {
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
              /*  Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  "Choose Option",
                  style: TextStyle(
                      height: 1,
                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      color: CommonColor.black),
                ),
              ),*/
              Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    },
                    child: Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.024),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: SizeConfig.screenHeight * 0.03,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.024,left: SizeConfig.screenHeight*0.024),
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
                    onTap: (){
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    },
                    child: Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: SizeConfig.screenHeight * 0.03,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.0,left: SizeConfig.screenHeight*0.024),
                          child: Text(
                            "Picture and Video Library",
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
                  padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.02),
                  child: Container(
                    width: SizeConfig.screenWidth*0.3,
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
                            color: Colors.black),
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



  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();




  @override
  void initState() {
    super.initState();

    if(mounted){
      setState(() {
        isLoading = true;
      });
    }

  /*  if(mounted){
      setState(() {
        isLoading = true;
      });
    }*/
   // print("dddd   $RegisterLocalDataStore");
   // RegisterLocalDataStore();
    focusNode = FocusNode();
    focusNode.addListener(() => setState(() {}));
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    addressController = TextEditingController();
    permanentAddressController = TextEditingController();
    mobileNumberController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();

    super.dispose();
  }


  final _formKey = GlobalKey<FormState>();




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
              Visibility(

                visible: isLoading,
                child: Center(child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * .05,
                      width: SizeConfig.screenWidth * .1,

                      child: Image(
                        image: const AssetImage(
                            "assets/images/anything_loding.png"),

                        width: SizeConfig.screenWidth * .1,
                      ),
                    ),
                    Text("  Loading...",    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto-Regular',
                        fontSize: SizeConfig.blockSizeHorizontal * 3.3),

                    )
                  ],
                ),),
              )
            ],


          ),
          /*    GestureDetector(

                behavior: HitTestBehavior.translucent,
                child: AnimationScreen(color: Theme.of(context).colorScheme.secondary),)*/
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
                left: parentWidth * 0.49, top: parentHeight * 0.04),
            child: PhysicalShape(
              color: Color(0xffd2ddf4),
              shadowColor: Colors.black.withOpacity(0.6),
              elevation: 10,
              clipper: ShapeBorderClipper(shape: CircleBorder()),
              child: Container(
                height: 180,
                width: 180,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: SizeConfig.screenWidth * 0.36,
              height: SizeConfig.screenHeight * 0.15,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100)),
                  color: Color(0xff87A2FC)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.7, top: parentHeight * 0.07),
            child: Image(
              image: AssetImage('assets/images/register.png'),
              height: parentHeight * 0.35,
              width: parentWidth * 0.7,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.08, left: parentHeight * 0.02),
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
                top: parentHeight * 0.12, left: parentHeight * 0.02),
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
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.28, left: parentWidth * 0.4),
            child: CircleAvatar(
              radius: 34,
              backgroundImage: AssetImage("assets/images/profile.png"),
              child: Stack(children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.white,
                    child: Icon(
                      CupertinoIcons.camera,
                      size: 18,
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget RegisterContent(double parentHeight, double parentWidth) {
    return Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.35),
        child: Container(
          height: parentHeight * 0.65,
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
          EdgeInsets.only(top: parentHeight * 0.06, left: parentWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Full Name",
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: fullNameController,
                    focusNode: _fullNameFocus,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/user.png'),
                            height: 20,
                          )),
                      hintText: 'Full Name',
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
            height: parentHeight * 0.020,
          ),
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: emailController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                  controller: passwordController,
                    keyboardType: TextInputType.text,
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
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/eye.png'),
                            height: 30,
                          )),
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                    keyboardType: TextInputType.text,
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
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/hidden.png'),
                            height: 30,
                          )),
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
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.01,
                left: parentWidth * 0.0,
                right: parentWidth * 0.04),
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: addressController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/user.png'),
                            height: 20,
                          )),
                      hintText: 'Current Address',
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                    keyboardType: TextInputType.text,
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                      color: Colors.black26)
                ]),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: true,
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
          Padding(
            padding: EdgeInsets.only(
                right: parentWidth * 0.05, top: parentHeight * 0.01),
            child: Text(
              "No need to pay for furniture assembly. We will install your furniture for free",
              style: TextStyle(
                color: Color(0xff454545),
                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                // fontWeight: FontWeight.normal,

                fontFamily: 'Roboto-Regular',
              ),
            ),
          ),
          SizedBox(height: 15),
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
                        child: Container(
                          //inner container
                          height: 120, //height of inner container
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: parentHeight * 0.01),
                                child: Image(
                                    image:
                                        AssetImage('assets/images/camera.png'),
                                    height: parentHeight * 0.05),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: parentHeight * 0.01),
                                child: Text("Drag and Drop Files here or",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                2.5,
                                        fontFamily: 'Roboto_Regular',
                                        fontWeight: FontWeight.w400,
                                        //overflow: TextOverflow.ellipsis,
                                        color: Colors.black)),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: (){
                                  _showGallaryDialogBox(context);
                                },
                                child: Container(
                                  height: 28,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: CommonColor.Blue),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Center(
                                    child: Text("Browser file",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    2.5,
                                            fontFamily: 'Roboto_Regular',
                                            fontWeight: FontWeight.w400,
                                            //overflow: TextOverflow.ellipsis,
                                            color: CommonColor.Blue)),
                                  ),
                                ),
                              ),
                            ],
                          ), //width to 100% match to parent container.
                          // color:Colors.yellow //background color of inner container
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
                      child: Container(
                        //inner container
                        height: 120, //height of inner container
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: parentHeight * 0.01),
                              child: Image(
                                  image: AssetImage('assets/images/camera.png'),
                                  height: parentHeight * 0.05),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: parentHeight * 0.01),
                              child: Text("Drag and Drop Files here or",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 2.5,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      //overflow: TextOverflow.ellipsis,
                                      color: Colors.black)),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 28,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: CommonColor.Blue),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text("Browser file",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
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
                      ),
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
      ),
    );
  }

  Widget RegisterButton(double parentWidth, double parentHeight) {
    return GestureDetector(

        onTap: () {

    /*  if (passwordController.text != confirmPasswordController.text) {
        print("Error: Password and Confirm Password do not match");
        // You can also show a UI error message here
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Passwords do not match'))
        );
        return;
      }*/

         /* if(mounted){
            setState(() {
              isLoading = true;
            });
          }*/

/*else {*/
            print("Full Name: ${fullNameController.text}");
            print("email: ${emailController.text}");
            print("password: ${passwordController.text}");
            print("cpassword: ${confirmPasswordController.text}");
            print("address: ${addressController.text}");
            print("mobile: ${mobileNumberController.text}");
            ApiClients().registerDio(
              fullNameController.text,
              emailController.text,
              passwordController.text,
              confirmPasswordController.text,
              mobileNumberController.text,
              addressController.text,
              permanentAddressController.text,

            ).then((value) {
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
                print("..aaaass ${ value['newUser']['userId']}");


                GetStorage().write(
                    ConstantData.Username, value['newUser']['name']);
                GetStorage().write(
                    ConstantData.UserId, value['newUser']['userId']);
                GetStorage().write(
                    ConstantData.Useremail, value['newUser']['email']);
                GetStorage().write(
                    ConstantData.Userpassword, value['newUser']['password']);
                GetStorage().write(
                    ConstantData.UserCpassword, value['newUser']['cpassword']);
                GetStorage().write(ConstantData.UserCurrentAddress,
                    value['newUser']['currentAddress']);
                GetStorage().write(ConstantData.UserParmanentAddress,
                    value['newUser']['permanentAddress']);
                GetStorage().write(
                    ConstantData.UserMobile, value['newUser']['PhoneNumber']);


                // print("numVal ${value['data']}");

                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const KYCVerifyScreen()));
              }
              if(mounted){
                setState(() {
                  isLoading = false;
                });
              }
            }
            );
         // }
              },


       /* if (showCustomTooltip)
    Positioned(
      right: 0,
      child: CustomTooltip(
        message: 'This field cannot be empty',
        onClose: () {
          setState(() {
            showCustomTooltip = false; // Hide the tooltip
          });
        },
      ),
    ),*/


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
                    offset: Offset(4, 4)),
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
    );
  }
}
