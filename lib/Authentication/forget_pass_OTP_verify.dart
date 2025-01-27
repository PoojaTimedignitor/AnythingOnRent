import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

bool isLoading = false;
final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
    fontSize: 22,
    color: CommonColor.Black /* Color.fromRGBO(30, 60, 87, 1)*/,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: CommonColor.Black),
  ),
);

class OTPVerify extends StatefulWidget {
  const OTPVerify({super.key});

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  TextEditingController emailController = TextEditingController();
  var code = "";
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final _formKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.42,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.02),
                  child: Image(
                    image: AssetImage('assets/images/forgetpass.png'),
                    height: SizeConfig.screenHeight * 0.240,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.screenHeight * 0.24,
                      left: SizeConfig.screenWidth * 0.75),
                  child: Image(
                    image: AssetImage('assets/images/forgetpasstwo.png'),
                    height: SizeConfig.screenHeight * 0.240,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * .35),
                            child: Container(
                              color: CommonColor.showBottombar.withOpacity(0.2),
                              height: SizeConfig.screenHeight * 0.004,
                              width: SizeConfig.screenHeight * 0.1,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * .1,
                                top: SizeConfig.screenHeight * 0.01),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.017),
                              child: Icon(
                                Icons.close,
                                size: SizeConfig.screenHeight * .03,
                                color: CommonColor.Black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.01),
                        child: Text(
                          "OTP Verification",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                              fontFamily: 'Roboto_Medium',
                              fontWeight: FontWeight.w400,
                              color: CommonColor.Black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.02,
                          left: SizeConfig.screenWidth * 0.1,
                          right: SizeConfig.screenWidth * 0.1),
                      child: Text(
                        "We will send code you a code this sayyadaaysha8999@gmail.com email address. ",
                        style: TextStyle(
                          color: CommonColor.RegisterText,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto-Regular',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.03,
                    ),


                    Material(
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10),
                        child: Form(
                          key: _formKey,
                          child: Directionality(
                            // Specify direction if desired
                            textDirection: TextDirection.ltr,

                            child: Pinput(
                              length: 6,
                              controller: pinController,
                              focusNode: focusNode,
                              onClipboardFound: (value) {
                                debugPrint('onClipboardFound: $value');
                                pinController.setText(value);
                              },
                              hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                                code = value;
                              },
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 9),
                                    width: 20,
                                    height: SizeConfig.screenHeight * 0.002,
                                    color: CommonColor.Black,
                                  ),
                                ],
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  //  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: CommonColor.Black),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  // color: fillColor,
                                  //borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: CommonColor.Black),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyBorderWith(
                                border:
                                    Border.all(color: CommonColor.Black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.17),
                        child: Icon(
                          Icons.message,
                          size: SizeConfig.screenHeight * .03,
                          color: CommonColor.Black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.03),
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                              color: CommonColor.Black,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto-Regular',
                              fontSize: SizeConfig.blockSizeHorizontal * 3.7),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.26),
                        child: Text(
                          "01:50",
                          style: TextStyle(
                              color: CommonColor.Black,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto-Regular',
                              fontSize: SizeConfig.blockSizeHorizontal * 3.7),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.4),
                  child: Center(
                    child: Container(
                        width: SizeConfig.screenWidth * 0.9,
                        height: SizeConfig.screenHeight * 0.06,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xffFA6B6B).withOpacity(0.3),
                                blurRadius: 2,
                                spreadRadius: 1,
                                offset: Offset(4, 4)),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xffFF9292),
                              Color(0xffFA6B6B),
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
                          "Send Code",
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
          ],
        ),
      ),
    );
  }
}
