import 'package:anything/ConstantData/Constant_data.dart';
import 'package:anything/Home_screen.dart';
import 'package:anything/MainScreen/register_screen.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../MainHome.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  bool passwordVisible=true;
  bool isObscure = false;
  var _formKey = GlobalKey<FormState>();
  final GlobalKey _tooltipKey = GlobalKey();
 bool showTooltip = true;



  void _validateAndShowTooltip() {
    if (emailController.text.isEmpty) {
      final dynamic tooltip = _tooltipKey.currentState;
      tooltip.ensureTooltipVisible(); // Show the tooltip if validation fails
    } else    if (emailController.text.isEmpty) {
      setState(() {
        showTooltip = false;
      });

    }

  }
  @override

  void initState(){
    super.initState();
    passwordVisible=true;
  }
/*  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        body: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [

            Image(
              image: AssetImage('assets/images/login.png'),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 22,top: 40),
              child: GestureDetector(

                  onTap: (){
                    Navigator.pop(context);
                  },

                  child: Icon(Icons.arrow_back,color: Colors.white,size: 25)),
            ),
          ],
        ),
        ImagesWithText(SizeConfig.screenHeight, SizeConfig.screenWidth),
        LoginContent(SizeConfig.screenHeight, SizeConfig.screenWidth),
        Stack(
          children: [

            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.6, top: 25),
              child: Image(
                image: AssetImage('assets/images/loginsecound.png'),
                height: SizeConfig.screenHeight * 0.267,
              ),
            ),

            RegisterButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
          ],
        ),
      ],
    ));
  }

  Widget ImagesWithText(double parentHeight, double parentWidth) {
    return Column(
      children: [
        Text(
          "Welcome Back!",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto-Regular',
              fontSize: SizeConfig.blockSizeHorizontal * 5.1),
        ),
        SizedBox(height: 9),
        Text(
          "Login",
          style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.w700,
              fontFamily: 'Roboto-Regular',
              fontSize: SizeConfig.blockSizeHorizontal * 4.3),
        ),
        SizedBox(height: 20),
        Image(
          image: AssetImage('assets/images/loginlogo.png'),
          width: parentHeight * 0.15,
        ),
      ],
    );
  }

  Widget LoginContent(double parentHeight, double parentWidth) {
    return Padding(
      padding:
          EdgeInsets.only(top: parentHeight * 0.0, left: parentWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(
              color: CommonColor.RegisterText,
              fontSize: SizeConfig.blockSizeHorizontal * 3.8,
              fontWeight: FontWeight.normal,
              fontFamily: 'Roboto-Regular',
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
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
                  child: Tooltip(
                    key: _tooltipKey,

                    padding: EdgeInsets.only(
                        top: parentHeight * 0.2,
                       ),

                    message: '                                This field cannot be empty*',
                  //  triggerMode: TooltipTriggerMode.manual,

                    decoration: BoxDecoration(
                      color: Colors.transparent,
                     // Background color
                      borderRadius: BorderRadius.circular(8), // Rounded corners

                     // Border color and width
                    ),
                    textStyle: TextStyle(
                      color: Colors.red, // Tooltip text color
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                    child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.text,

                       // validator: _validateText,
                    /*
                        validator: (value) {


                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;

                        },*/


                        autocorrect: true,
                        textInputAction: TextInputAction.next,
                      /*  onChanged: (value) {
                          setState(() {
                            emailError = validatorss(value);
                          });
                        },*/




                        decoration: InputDecoration(
                          errorText: null,
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




                        ),


                    ),
                  )),

            ),

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
                    obscureText: passwordVisible,

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
                   /*   suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Image(
                            image: AssetImage('assets/images/eye.png'),
                            height: 30,
                          )),*/
                      hintText: 'Password',
                      suffixIcon: IconButton(
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
          GestureDetector(
            onTap: (){

             /* showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent, // Keeps the transparency, but handles background in Container
                builder: (context) =>
                    Container(
                      height: MediaQuery.of(context).size.height * 0.38,
                      decoration: BoxDecoration(
                        color: Colors.red, // Set your custom color here
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      child: ForgetPassword(),
                    ),
              );*/


                showModalBottomSheet(
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
                      return ForgetPassword(
                      );
                    });
              },


            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.58),
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  color: CommonColor.RegisterText,
                  fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget RegisterButton(double parentWidth, double parentHeight) {
    return GestureDetector(
      onTap: () {

        _validateAndShowTooltip();

        // Password validation (ensure it's not empty and meets a minimum length requirement)
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        print("Password must be at least 6 characters long");
        return;
      }

      // Call login API if validation passes
      ApiClients().loginDio(emailController.text, passwordController.text).then((value) {
        print(value['data']);
        print("Response: $value");

        if (mounted) {
          setState(() {});
        }

        if (value['success'] == true) {
          print("UserId: ${value['user']?['email']}");

          // Store credentials in GetStorage

          GetStorage().write(ConstantData.Useremail, value['user']?['email']);
          GetStorage().write(ConstantData.UserId, value['user']?['userId']);
          GetStorage().write(ConstantData.Userpassword, value['user']?['password']);

          // Navigate to the home screen upon successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  MainHome()),
          );
        } else if(value['success'] == false) {
          print("Email or password does not match");
        }
      }).catchError((error) {
        print("An error occurred: $error");
      });


      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.05,
                left: parentWidth * 0.03,
                right: parentWidth * 0.03),
            child: Container(
                width: 370,
                height: parentHeight * 0.13,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
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
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto-Regular',
                      fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                ),



                )),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: parentHeight * 0.003,
                width: parentWidth * 0.15,
                color: Colors.black26,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "or",
                style: TextStyle(color: Color(0xff110E0E).withOpacity(0.4)),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: parentHeight * 0.003,
                width: parentWidth * 0.15,
                color: Colors.black26,
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/facebook.png'),
                width: parentHeight * 0.13,
              ),
              SizedBox(width: 10),
              Image(
                image: AssetImage('assets/images/google.png'),
                width: parentHeight * 0.13,
              ),
              SizedBox(width: 10),
              Image(
                image: AssetImage('assets/images/linkedIn.png'),
                width: parentHeight * 0.13,
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: parentWidth * 0.03),
                child: RichText(
                    text: TextSpan(
                        text: "Don’t have an account ?",
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Roboto-Regular',
                            fontSize: 14),
                        children: [
                      TextSpan(
                        text: " Sign Up",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Roboto-Regular',
                            fontSize: 14),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ])),
              ),
            ],
          )
        ],
      ),
    );
  }
}
