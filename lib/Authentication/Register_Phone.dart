import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/common_color.dart';

class Register_Phone extends StatefulWidget {

  const Register_Phone({super.key});

  @override
  State<Register_Phone> createState() => _Register_PhoneState();
}

class _Register_PhoneState extends State<Register_Phone> {
  final _phoneFocus = FocusNode();

  String verificationID = "";

  late String _number;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      print("Phone Number enter ${phoneController.text}");


      setState(() {
        isButtonActive = phoneController.text.length == 10 &&
            RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text);
      });

      print("Is Button Active: $isButtonActive");
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
      
      
        children: [
      
          Padding(
            padding: const EdgeInsets.only(top: 120 ),
            child: SizedBox(
      
              height: ResponsiveUtil.height(SizeConfig.screenHeight*0.62),
      
              child:  Stack(
                children: [
      
                   Positioned.fill(
                      child: Image.asset(
                        'assets/images/register_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  Positioned(
                    top:ResponsiveUtil.height(160),
                    left: ResponsiveUtil.width(90),
                    right: ResponsiveUtil.width(10),
                    child: Text(
                      'Enter Your Number',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "okra_extrabold",
                        fontSize: ResponsiveUtil.fontSize(20) ,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
      
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top:ResponsiveUtil.height(210),
                        left: ResponsiveUtil.width(62),
                        right: ResponsiveUtil.width(42),),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              focusNode: _phoneFocus,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.trim().length < 10 || value.trim().length > 10) {
                                  return 'Please Enter Valid Number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _number = value;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding:  EdgeInsets.only(top: 10,left: 1,bottom: 13),
                                  child: Image(
                                    image: AssetImage('assets/images/flag.png'),
                                    height:1,
                                  ),
                                ),
                                prefixText: "+91 ",
      
                                prefixStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                  color: Color(0xffFE7F64),
                                  fontSize: ResponsiveUtil.fontSize(17),
                                  fontFamily: "okra_Medium",
                                ),
                                contentPadding:  EdgeInsets.all(12),
                                isDense: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:  BorderSide(
                                    width: 1,
                                    color: Color(0xffFE7F64),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0.3,
                                    color: Color(0xff000000),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 9,
                                    color: Color(0xffFE7F64),
                                  ),
      
                                  borderRadius: BorderRadius.circular(10.0),
                                ), hintText: ' phone number',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: ResponsiveUtil.fontSize(15),
                                  fontFamily: "okra_Light",
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                              ),
                            ),
                          ),
                        ],
      
                      ))
                ],
              ),
            ),
          ),
          ContinueButton(
              SizeConfig.screenHeight, SizeConfig.screenWidth),
          Padding(
            padding:  EdgeInsets.only(top:ResponsiveUtil.height(25),left: ResponsiveUtil.height(25)),
            child: Container(
              width: ResponsiveUtil.height(370),
      
              child: RichText(
                  text: TextSpan(
                      text: "By clicking Sign up, you agree to our",
                      style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat-Medium',
                          fontSize: 14),
                      children: [
                        TextSpan(
                          text: " Terms & Conditions",
                          style: TextStyle(
                              color: CommonColor.grayText,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("jdfbsdff");
                              /*  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );*/
                            },
                        ),
                        TextSpan(
                          text: " and ",
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Montserrat-Medium',
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("jdfbsdff");
                              /*  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );*/
                            },
                        ),
                        TextSpan(
                          text: " Privacy Policy",
                          style: TextStyle(
                              color: CommonColor.grayText,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Montserrat-Bold',
                              fontSize: 14),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("jdfbsdff");
                              /*  Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );*/
                            },
                        ),
                      ])),
            ),
          )
      
        ],
      ),
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: isButtonActive
          ? () {

        print("Button tapped");
      }
          : null,
      child: Padding(
        padding: EdgeInsets.only(

            left: parentWidth * 0.08,
            right: parentWidth * 0.08),
        child: Container(
            height: parentHeight * 0.06,
            decoration: BoxDecoration(
              color: isButtonActive
                  ? Color(0xff838383)
                  : CommonColor.SearchBar,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Continue",
                style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    color: CommonColor.white),
              ),
            )),
      ),
    );
  }

}