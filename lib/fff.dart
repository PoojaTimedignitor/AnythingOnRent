/*
import 'package:flutter/material.dart';

import 'Common_File/common_color.dart';


class EnterMobileNumber extends StatefulWidget {
  const EnterMobileNumber({Key? key}) : super(key: key);

  @override
  _EnterMobileNumberState createState() => _EnterMobileNumberState();
}
final _formKey = GlobalKey<FormState>();
class _EnterMobileNumberState extends State<EnterMobileNumber> {
  bool _checkbox = false;
  final _phoneFocus = FocusNode();
  //FirebaseAuth auth = FirebaseAuth.instance;
  String verificationID = "";

  late String _number;

  TextEditingController phoneController = TextEditingController();
  validate() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      print("validated");
      print("hii");
      debugPrint(_number);
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      await auth.verifyPhoneNumber(
          phoneNumber: "+91${phoneController.text}",
          verificationCompleted: (phoneAuthCredential) async {},
          verificationFailed: (verificationFailed) {
            print(verificationFailed);
          },
          codeSent: (String verificationId, int? resendToken) async {
            setState(() {
              verificationID = verificationId;
              print('verid $verificationID');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EnterOtpNumber(
                            mobileNumber: phoneController.text,
                            auth: '',
                            verificationId: verificationID,
                          )));
            });
            //Navigator.of(context).pop();
          },
          codeAutoRetrievalTimeout: (verificationID) async {});
    } else {
      _showToast(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onDoubleTap: () {},
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.2),
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.10,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: getAddMainHeadingLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),
              Container(
                //height: SizeConfig.screenHeight,
                  child: Column(
                    children: [
                      getFirstImageFrame(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                      ContinueButton(
                          SizeConfig.screenHeight, SizeConfig.screenWidth),
                      getBottomText()
                    ],
                  ))
            ],
          ),
        ));
  }
  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            onDoubleTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * .04),
              child: Container(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: parentHeight * .025,
                  color: CommonColor.BLACK,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.07),
            child: Text(
              "SAHAR / IFTAR",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.transparent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth * .04),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: parentHeight * .03,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return Form(
      key: _formKey,

      child: Padding(
        padding: EdgeInsets.only(top: parentHeight * 0.04),
        child: Center(
          child: SizedBox(
            width: parentWidth,
            height: parentHeight * .6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: parentHeight * .23,
                    width: parentWidth * .58,
                    decoration: BoxDecoration(
                        color: CommonColor.GRAY_COLOR,
                        borderRadius: BorderRadius.circular(30)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        "https://cdn.pixabay.com/photo/2015/10/25/21/02/abu-1006336__340.jpg",
                        //listPaths[index % listPaths.length],
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: parentHeight * 0.06,
                      left: parentWidth * 0.13,
                      right: parentWidth * 0.1),
                  child: Text(
                    "Enter the Mobile No.  we will send you one time verification code to start.  ",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                        color: CommonColor.BLACK,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto_bold'),
                    //textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: parentWidth * 0.02, right: parentWidth * 0.02),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: parentWidth * 0.03, top: parentHeight * 0.009),

                          */
/*   child: Text(
                            "State",
                            style:
                            TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                          )*//*

                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: parentHeight * 0.03,
                            left: parentWidth * 0.03,
                            right: parentWidth * 0.03),
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
                                    // Return null if the entered password is valid
                                    return null;
                                  },
                                  onChanged: (value){
                                    _number = value;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: const Image(image: AssetImage( 'assets/images/flag.png'),),
                                      prefixText: "+91 ",
                                      prefixStyle: const TextStyle(color: Colors.black),
                                      labelText: 'Phone Number',
                                      labelStyle: const TextStyle(
                                          color:  CommonColor.REGISTRARTION_COLOR
                                      ),
                                      contentPadding: const EdgeInsets.all(12),
                                      isDense: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: CommonColor.REGISTRARTION_COLOR),
                                          borderRadius: BorderRadius.circular(10.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: CommonColor.REGISTRARTION_COLOR),
                                          borderRadius: BorderRadius.circular(10.0)),
                                      //borderRadius: BorderRadius.circular(10)
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: CommonColor.REGISTRARTION_COLOR),
                                          borderRadius: BorderRadius.circular(10.0)),
                                      hintStyle: TextStyle(
                                          fontFamily: "Roboto_Regular",
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                          color: CommonColor.SEARCH_TEXT_COLOR
                                      ))),
                            ),
                          ],

                        ))
                  ]),
                ),

                Padding(
                  padding:  EdgeInsets.only(top: parentHeight*0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: parentWidth * 0.08),
                            child: Checkbox(
                              side: const BorderSide(
                                // set border color here
                                color: CommonColor.REGISTRARTION_TRUSTEE,
                              ),
                              value: _checkbox,
                              checkColor: Colors.white,
                              activeColor: CommonColor.REGISTRARTION_TRUSTEE,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: parentHeight * 0.006,
                                left: parentWidth * 0.0,
                                right: parentWidth * 0.06),
                            child: Text(
                              "By clicking Sign up, you agree to our \nTerms & Conditions and Privacy Policy. ",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                  color: CommonColor.BLACK,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto_bold'),
                              //textAlign: TextAlign.center,
                            ),
                          ), //textAlign: TextAlign.center,
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () async {
        validate();
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.03,
            left: parentWidth * 0.1,
            right: parentWidth * 0.1),
        child: Container(
            height: parentHeight * 0.06,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [CommonColor.LEFT_COLOR, CommonColor.RIGHT_COLOR]),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "Continue",
                style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    color: CommonColor.WHITE_COLOR),
              ),
            )),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Enter valid mobile Number'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget getBottomText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already Have an Account?",
            style: TextStyle(
                fontSize: 15,
                fontFamily: "Roboto_Regular",
                fontWeight: FontWeight.w400,
                // fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                color: CommonColor.BLACK_COLOR),
          ),
          GestureDetector(
            onDoubleTap: () {},
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              color: Colors.transparent,
              child: const Text(
                " Login",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: CommonColor.RIGHT_COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/


/*
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:masjiduserapp/masjit_user_app_api/masjit_app_responce_model/user_register_response_model.dart';
import 'package:masjiduserapp/size_config.dart';

import 'package:masjiduserapp/user_registration.dart';
import 'package:masjiduserapp/util/constant.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

import 'common.color.dart';



const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

bool isLoading = false;
final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
    fontSize: 22,
    color: CommonColor.REGISTRARTION_TRUSTEE */
/* Color.fromRGBO(30, 60, 87, 1)*//*
,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: CommonColor.REGISTRARTION_TRUSTEE),
  ),
);

class EnterOtpNumber extends StatefulWidget {
  const EnterOtpNumber({
    Key? key,
    required this.mobileNumber,
    required this.auth,
    required this.verificationId,
  }) : super(key: key);
  final String mobileNumber;
  final String auth;
  final String verificationId;

  @override
  _EnterOtpNumberState createState() => _EnterOtpNumberState();
}

class _EnterOtpNumberState extends State<EnterOtpNumber> {
  final bool _checkbox = false;
  final bool _checkboxListTile = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  late Box box;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";


  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  var getPhoneNumber;
  Future<UserPhoneNumberRegistrationResponceModel>? result;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    box = Hive.box(kBoxName);

    super.initState();
    if (mounted) {
      setState(() {
        print('phone ${widget.mobileNumber}');
        box.put(kUserPhoneNumber, widget.mobileNumber);
        // print("Id ${widget.phoneNumber}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onDoubleTap: () {},
          child: ListView(
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.2),
            shrinkWrap: true,
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.10,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: getAddMainHeadingLayout(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),
              Column(
                children: [
                  getFirstImageFrame(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                  ContinueButton(
                      SizeConfig.screenHeight, SizeConfig.screenWidth),
                ],
              )
            ],
          ),
        ));
  }

  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            onDoubleTap: () {},
            child: Padding(
              padding: EdgeInsets.only(left: parentWidth * .04),
              child: Container(
                padding: EdgeInsets.only(top: parentHeight * 0.02),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: parentHeight * .025,
                  color: CommonColor.BLACK,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.07),
            child: Text(
              "SAHAR / IFTAR",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w400,
                  color: Colors.transparent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: parentWidth * .04),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                Icons.arrow_back_ios,
                size: parentHeight * .03,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<UserPhoneNumberRegistrationResponceModel> getOtpApi() async {
    try {
      final result = await http
          .post(Uri.parse("http://admin.azan4salah.com/api/user/verify"), body: {

        "phone": widget.mobileNumber.toString(),

      });
      print("new order:" + result.body);
      isLoading = false;

      return userPhoneNumberRegistrationResponceModelFromJson(result.body);
    } catch (e) {
      rethrow;
    }
  }

  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: parentHeight * 0.03),
      child: Center(
        child: SizedBox(

          width: parentWidth,
          height: parentHeight*0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: parentHeight * .23,
                width: parentWidth * .58,
                decoration: BoxDecoration(
                    color: CommonColor.GRAY_COLOR,
                    borderRadius: BorderRadius.circular(30)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child:Image.network(
                      "https://cdn.pixabay.com/photo/2015/10/25/21/02/abu-1006336__340.jpg",
                      //listPaths[index % listPaths.length],
                      fit: BoxFit.cover,

                    )
                ),),
              Padding(
                padding: EdgeInsets.only(
                    top: parentHeight * 0.03,
                    left: parentWidth * 0.10,
                    right: parentWidth * 0.1),
                child: Text(
                  "Enter the OTP.",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      color: CommonColor.REGISTRARTION_TRUSTEE,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto_bold'),
                  //textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: parentWidth * 0.0),
                      child: Text(
                        " Send to ",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.BLACK_COLOR),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.0),
                      child: Text(
                        "+91" + widget.mobileNumber,
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.BLACK_COLOR),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Directionality(
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
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
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
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 20,
                                height: parentHeight * 0.002,
                                color: CommonColor.REGISTRARTION_TRUSTEE,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              //  borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: CommonColor.REGISTRARTION_TRUSTEE),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              // color: fillColor,
                              //borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: CommonColor.REGISTRARTION_TRUSTEE),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(
                                color: CommonColor.REGISTRARTION_TRUSTEE),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return  GestureDetector(

      onTap: () async {
        showDialog(context: context, builder: (context)
        {
          return const Center(child: CircularProgressIndicator());
        }
        );
        // isLoading = true;
        print('verid 1 ${widget.verificationId}');
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: code,
        );

        try{
          await auth.signInWithCredential(credential);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserRegistration(phoneNum: widget.mobileNumber,)));
        }catch(excepti){
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Some Error Occured. Try Again Later')));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.0,
            left: parentWidth * 0.1,
            right: parentWidth * 0.1),
        child: Column(
          children: [
            Container(
                height: parentHeight * 0.06,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        CommonColor.LEFT_COLOR,
                        CommonColor.RIGHT_COLOR
                      ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    "Verify",
                    style: TextStyle(
                        fontFamily: "Roboto_Regular",
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                        color: CommonColor.WHITE_COLOR),
                  ),
                )),
            */
/* Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(right: parentWidth * 0.0),
                        child: Text(
                          " Didn’t receive SMS? ",
                          style: TextStyle(
                              fontFamily: "Roboto_Regular",
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                              color: CommonColor.BLACK_COLOR),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: parentWidth * 0.0),
                      child: Text(
                        "Resend",
                        style: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                            color: CommonColor.CANCLE_BUTTON),
                      ),
                    ),
                  ],
                ),
              ),*//*

          ],
        ),
      ),

    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: SizedBox(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
*/

///

/*

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CircularSwapWithArcAnimation extends StatefulWidget {
  const CircularSwapWithArcAnimation({super.key});

  @override
  State<CircularSwapWithArcAnimation> createState() =>
      _CircularSwapWithArcAnimationState();
}

class _CircularSwapWithArcAnimationState
    extends State<CircularSwapWithArcAnimation> with TickerProviderStateMixin {
  List<String> adsUrlsList = [
    'https://pune.accordequips.com/images/products/15ccb1ae241836.png',
    'https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg',
    'https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg',
    'https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg',
  ];

  Timer? _autoPlayTimer;
  bool isAnimating = false;
  late AnimationController _arcController;

  @override
  void initState() {
    super.initState();
    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _startAutoRotation();
  }

  void _startAutoRotation() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!isAnimating) _startArcSwap();
    });
  }

  void _pauseAutoRotation() {
    _autoPlayTimer?.cancel();
  }

  void _startArcSwap() {
    setState(() {
      isAnimating = true;
    });

    _arcController.forward(from: 0).then((_) {
      setState(() {
        final last = adsUrlsList.removeLast();
        adsUrlsList.insert(0, last);
        isAnimating = false;
      });
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _arcController.dispose();
    super.dispose();
  }

  Widget _buildImage(String url, {double? size}) {
    return Container(
      width: size ?? double.infinity,
      height: size ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFF57C00),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  Offset _calculateArcOffset(double t, Offset start, Offset end) {
    final mid = Offset((start.dx + end.dx) / 2, start.dy - 100);
    final x = pow(1 - t, 2) * start.dx +
        2 * (1 - t) * t * mid.dx +
        pow(t, 2) * end.dx;
    final y = pow(1 - t, 2) * start.dy +
        2 * (1 - t) * t * mid.dy +
        pow(t, 2) * end.dy;
    return Offset(x.toDouble(), y.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double heightFraction = screenSize.height * 0.08;
    final double widthFraction = screenSize.width * 0.5;

    // final double thumbSize = 70;
    // final double spacing = 12;

    final double thumbSize = 70;
    final double spacing = 12;

    final double thumbnailColumnHeight = (thumbSize * 3) + (spacing * 2); // 3 thumbs + 2 gaps
    final double bigViewHeight = thumbSize * 3 + spacing * 2; // same height as thumbnail column
    final double verticalCenter = (screenSize.height - bigViewHeight) / 2;


    return Container(
      color: Colors.pink,
      height: heightFraction * 10,  //100,
      padding: EdgeInsets.only(top: 20, bottom: 50),
      child:
      Stack(
        children: [
          /// Big View
          // Positioned(
          //   left: 0,
          //   top: 20, // kuch padding bhi mil gaya
          //   width: widthFraction,
          //   height: heightFraction * 3,             //300, // ya jitni height chahiye
          //
          //   child: isAnimating
          //       ? AnimatedBuilder(
          //     animation: _arcController,
          //     builder: (_, child) {
          //       final offset = _calculateArcOffset(
          //         _arcController.value,
          //         Offset(widthFraction + spacing, 0),
          //         Offset(0, 0),
          //       );
          //       return Transform.translate(
          //         offset: offset,
          //         child: _buildImage(adsUrlsList[3]),
          //       );
          //     },
          //   )
          //       : _buildImage(adsUrlsList[0]),
          // ),


          Positioned(
            left: 0,
            top: verticalCenter,
            width: widthFraction,
            height: bigViewHeight,
            child: isAnimating
                ? AnimatedBuilder(
              animation: _arcController,
              builder: (_, child) {
                final offset = _calculateArcOffset(
                  _arcController.value,
                  Offset(widthFraction + spacing, 0),
                  Offset(0, 0),
                );
                return Transform.translate(
                  offset: offset,
                  child: _buildImage(adsUrlsList[3]),
                );
              },
            )
                : _buildImage(adsUrlsList[0]),
          ),


          /// Thumbnails
          Positioned(
            right: 0,
            top: verticalCenter,
            // right: 0,
            // top: 0,
            child: Column(
              children: List.generate(3, (i) {
                final url = adsUrlsList[i + 1];
                Widget thumb = _buildImage(url, size: thumbSize);

                if (isAnimating) {
                  if (i == 0) {
                    return AnimatedBuilder(
                      animation: _arcController,
                      builder: (_, child) {
                        final offset = _calculateArcOffset(
                          _arcController.value,
                          Offset(0, 0),
                          Offset(0, (thumbSize + spacing) * i),
                        );
                        return Transform.translate(
                          offset: offset,
                          child: SizedBox(height: thumbSize, child: child),
                        );
                      },
                      child: _buildImage(adsUrlsList[0], size: thumbSize),
                    );
                  }

                  if (i == 1) {
                    return AnimatedBuilder(
                      animation: _arcController,
                      builder: (_, child) {
                        final offset =
                        Offset(0, _arcController.value * (thumbSize + spacing));
                        return Transform.translate(
                          offset: offset,
                          child: SizedBox(height: thumbSize, child: child),
                        );
                      },
                      child: _buildImage(adsUrlsList[1], size: thumbSize),
                    );
                  }

                  // i == 2 -> NO ANIMATION, just return normal static widget
                  // so it remains stable
                }

                // Default (no animation or i==2 case)
                return Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: GestureDetector(
                    onTap: () {
                      if (!isAnimating) {
                        _pauseAutoRotation();
                        _startArcSwap();
                      }
                    },
                    child: thumb,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
*/


///
/*

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CircularSwapWithArcAnimation extends StatefulWidget {
  const CircularSwapWithArcAnimation({super.key});

  @override
  State<CircularSwapWithArcAnimation> createState() =>
      _CircularSwapWithArcAnimationState();
}

class _CircularSwapWithArcAnimationState extends State<CircularSwapWithArcAnimation>
    with TickerProviderStateMixin {
  List<String> adsUrlsList = [
    'https://pune.accordequips.com/images/products/15ccb1ae241836.png',
    'https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg',
    'https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg',
    'https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg',
  ];

  late AnimationController _arcController;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _arcController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          final last = adsUrlsList.removeLast();
          adsUrlsList.insert(0, last);
        });
        _arcController.forward(from: 0); // loop again
      }
    });

    _arcController.forward();
  }

  void _pauseAnimation() {
    _arcController.stop();
  }

  @override
  void dispose() {
    _arcController.dispose();
    super.dispose();
  }

  Widget _buildImage(String url, {double? size}) {
    return Container(
      width: size ?? double.infinity,
      height: size ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFF57C00),
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  Offset _calculateArcOffset(double t, Offset start, Offset end) {
    final curvedT = Curves.easeInOut.transform(t);
    final mid = Offset((start.dx + end.dx) / 2, start.dy - 100);
    final x = pow(1 - curvedT, 2) * start.dx +
        2 * (1 - curvedT) * curvedT * mid.dx +
        pow(curvedT, 2) * end.dx;
    final y = pow(1 - curvedT, 2) * start.dy +
        2 * (1 - curvedT) * curvedT * mid.dy +
        pow(curvedT, 2) * end.dy;
    return Offset(x.toDouble(), y.toDouble());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double thumbSize = 70;
    final double spacing = 12;

    final double bigViewHeight = (thumbSize * 3) + (spacing * 2);
    final double verticalCenter = (screenSize.height - bigViewHeight) / 2;
    final double widthFraction = screenSize.width * 0.5;

    return Container(
      color: Colors.pink.shade50,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Thumbnails Column
          Positioned(
            right: 0,
            top: verticalCenter,
            child: Column(
              children: List.generate(3, (i) {
                return Padding(
                  padding: EdgeInsets.only(bottom: spacing),
                  child: GestureDetector(
                    onTap: () {
                      if (!isAnimating) _pauseAnimation();
                    },
                    child: _buildImage(adsUrlsList[i + 1], size: thumbSize),
                  ),
                );
              }),
            ),
          ),

          // Big View on top using stack layering
          // Positioned(
          //   left: 0,
          //   top: verticalCenter,
          //   width: widthFraction,
          //   height: bigViewHeight,
          //   child: AnimatedBuilder(
          //     animation: _arcController,
          //     builder: (_, child) {
          //       final offset = _calculateArcOffset(
          //         _arcController.value,
          //         Offset(widthFraction + spacing, bigViewHeight - thumbSize),
          //         Offset(0, 0),
          //       );
          //       return Transform.translate(
          //         offset: offset,
          //         child: _buildImage(adsUrlsList[3]),
          //       );
          //     },
          //   ),
          // ),

          Positioned(
            left: 0,
            top: verticalCenter,
            width: widthFraction,
            height: bigViewHeight,
            child: AnimatedBuilder(
              animation: _arcController,
              builder: (_, child) {
                final offset = _calculateArcOffset(
                  _arcController.value,
                  Offset(widthFraction + spacing, bigViewHeight - thumbSize),
                  Offset(0, 0),
                );

                return Transform.translate(
                  offset: offset,
                  child: Hero(
                    tag: 'bigview-image',
                    child: _buildImage(adsUrlsList[3]),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
*/




///



import 'dart:async';
import 'dart:ui';
import 'package:anything/Common_File/new_responsive_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageRotator(),
    );
  }
}

class ImageRotator extends StatefulWidget {
  const ImageRotator({super.key});

  @override
  State<ImageRotator> createState() => _ImageRotatorState();
}

class _ImageRotatorState extends State<ImageRotator> {
  final List<String> images = [
    'https://pune.accordequips.com/images/products/15ccb1ae241836.png',
    'https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg',
    'https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg',
    'https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg',
  ];

  late Timer _timer;

  void rotateImages() {
    setState(() {
      final first = images.removeAt(0);
      images.add(first);
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => rotateImages());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
     /* Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Big image on the left
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: ClipRRect(
                      key: ValueKey(images[0]),
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        images[0],
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Column of thumbnails on right
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: ClipRRect(
                            key: ValueKey(images[index + 1]),
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              images[index + 1],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );*/

      Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Big image on the left
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Container(
                        key: ValueKey(images[0]),
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF3E2723),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            images[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Column of thumbnails on right
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),

                          child: AnimatedSwitcher(
                            duration: const Duration(seconds: 1),
                            child: Container(
                              key: ValueKey(images[index + 1]),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF3E2723),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  images[index + 1],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  }
}


class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  bool isButtonAttached = false;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context); // Replace with your instance

    return Stack(
      children: [
        // Golden/orange button row
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: responsive.getPadding(all: 0).copyWith(left: 2, right: 2),
              margin: responsive.getMargin(all: 0).copyWith(left: 10, right: 20),
              height: responsive.height(responsive.isMobile ? 38 : responsive.isTablet ? 50 : 60),
              width: responsive.width(responsive.isMobile ? 130 : responsive.isTablet ? 160 : 180),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFBC02D), Color(0xFFE65100)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),

        // Animated Create Post button
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: isButtonAttached
              ? responsive.height(responsive.isMobile ? 6 : 4) // Position near the top button
              : responsive.height(responsive.isMobile ? 100 : 200), // Starting position
          left: responsive.width(responsive.isMobile ? 157 : 180),
          bottom: responsive.height(responsive.isMobile ? 12 : 6),
          right: responsive.width(responsive.isMobile ? 12 : 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isButtonAttached = !isButtonAttached;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: responsive.getMargin(all: 5),
                      padding: responsive.getPadding(all: 0).copyWith(
                        left: 8,
                        right: 20,
                        bottom: responsive.isMobile ? 12 : 10,
                      ),
                      child: Text(
                        'Create Post +',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.fontSize(responsive.isMobile ? 14 : 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



///

/*

import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularImageRotator(),
    );
  }
}

class CircularImageRotator extends StatefulWidget {
  const CircularImageRotator({super.key});

  @override
  State<CircularImageRotator> createState() => _CircularImageRotatorState();
}

class _CircularImageRotatorState extends State<CircularImageRotator>
    with SingleTickerProviderStateMixin {
  final List<String> images = [
    'https://pune.accordequips.com/images/products/15ccb1ae241836.png',
    'https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg',
    'https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg',
    'https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg',
  ];

  late AnimationController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _controller.forward(from: 0).whenComplete(() {
        setState(() {
          final first = images.removeAt(0);
          images.add(first);
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Offset _arcOffset(double progress, Offset from, Offset to) {
    final center = Offset((from.dx + to.dx) / 2, (from.dy + to.dy) / 2 - 80);
    final radius = (from - center).distance;
    final angle1 = atan2(from.dy - center.dy, from.dx - center.dx);
    final angle2 = atan2(to.dy - center.dy, to.dx - center.dx);
    final angle = angle1 + (angle2 - angle1) * progress;

    return Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );
  }

  Widget _buildAnimatedImage(int index, Offset from, Offset to, double size,
      {bool isMain = false}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final offset = _arcOffset(_controller.value, from, to);
        return Positioned(
          left: offset.dx,
          top: offset.dy,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              images[index],
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final leftCenter = Offset(50, 150);
    final rightTop = Offset(300, 50);
    final rightMid = Offset(300, 150);
    final rightBottom = Offset(300, 250);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildAnimatedImage(0, leftCenter, rightTop, 250),
          _buildAnimatedImage(1, rightTop, rightMid, 80),
          _buildAnimatedImage(2, rightMid, rightBottom, 80),
          _buildAnimatedImage(3, rightBottom, leftCenter, 80),
        ],
      ),
    );
  }
}
*/




