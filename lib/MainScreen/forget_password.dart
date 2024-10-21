import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainScreen/forget_pass_OTP_verify.dart';
import 'package:flutter/material.dart';




class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

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
                          onTap: (){
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
                          onTap: (){
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
                          "Forget Password?",
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
                          left: SizeConfig.screenWidth * 0.16,
                          right: SizeConfig.screenWidth * 0.16),
                      child: Text(
                        "Please enter your email so we can send you a verification code ",
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
                    /*   Row(
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
                       Icon(Icons.star,color: Colors.red,size: 10,)
                     ],
                   )*/

                    Padding(
                      padding:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                      child: RichText(
                        text: TextSpan(
                            text: 'Email',
                            style: TextStyle(
                                color: CommonColor.RegisterText,
                                fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Roboto-Regular'),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.8,
                                    fontWeight: FontWeight.normal,
                                  ))
                            ]),
                        textScaleFactor: 1.0,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.02,
                          left: SizeConfig.screenWidth * 0.04,
                          right: SizeConfig.screenWidth * 0.04),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: emailController,
                          autocorrect: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.04,
                            ),
                            prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Image(
                                  image:
                                      AssetImage('assets/images/email.png'),
                                  height: 20,
                                )),
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
                                borderSide: BorderSide(
                                    color: Colors.black12, width: 0.9),
                                //  borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black12, width: 0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: (){
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
                              return OTPVerify(
                              );
                            });
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: SizeConfig.screenHeight * 0.03),
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
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.3),
                              ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
