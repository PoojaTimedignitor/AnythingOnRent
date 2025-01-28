import 'package:flutter/material.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:pinput/pinput.dart';

const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const borderColor = Color.fromRGBO(23, 171, 144, 0.4);


bool isLoading = false;
final defaultPinTheme = PinTheme(
  width: 36,
  height: 46,
  textStyle: const TextStyle(
    fontSize: 12,
    color:Color(0xffFE7F64) /* Color.fromRGBO(30, 60, 87, 1)*/,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: CommonColor.Black),
  ),
);


class PhoneRegistrationPage extends StatefulWidget {
  late final String mobileNumber;
  PhoneRegistrationPage({
    Key? key,
    required this.mobileNumber,
  }): super(key: key);
  @override
  _PhoneRegistrationPageState createState() => _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends State<PhoneRegistrationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final focusNode = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  bool isButtonActive = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  var code = "";

  String? _number;
  bool showOTPWidget = false;
  bool showEmailWidget = false;

  String buttonText = "Verify OTP";
  bool isEmailVerification = false;  // Track if email verification is required



  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      print("Phone Number Entered: ${phoneController.text}");

      // Update button state
      setState(() {
        isButtonActive = phoneController.text.length == 10 &&
            RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text);
      });

      print("Is Button Active: $isButtonActive");
    });


    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Slide Animation
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    phoneController.dispose();
    otpController.dispose();
    _phoneFocus.dispose();
    focusNode.dispose();

    super.dispose();
  }

  void validatePhoneNumber() {
    final phoneNumber = phoneController.text.trim();

    if (phoneNumber.isEmpty || phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    setState(() {
      showOTPWidget = true; // Show the OTP widget
    });

    // Start animation
    _animationController.forward();
  }
  void validateOTP() {
    final otp = otpController.text.trim();

    if (otp.isEmpty || otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    setState(() {
      isEmailVerification = true;
    });
  }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

    Positioned.fill(
    child: Image.asset(
      'assets/images/renttwo.jpg',
      fit: BoxFit.cover,
    ),
    ),
      Scaffold(
    backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                otpController.clear();

                if (showOTPWidget) {
                  setState(() {
                    showOTPWidget = false; // Go back to the phone number screen
                    _animationController.reverse(); // Reverse animation for OTP widget
                  });
                } else {
                  Navigator.pop(context); // Exit to the previous screen if on the phone number screen
                }
              },
            ), // Reusable back arrow widget
          ),

        body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              // Background Image


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top:250, bottom: 30),
                    child: Text(
                     '',
                      textAlign: TextAlign.center,

                    ),
                  ),

                  _buildVerificationWidget(),
                  SizedBox(height: 50),


                ],
              ),

              Padding(
                padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.6,left: SizeConfig.screenWidth*0.06,right: SizeConfig.screenWidth*0.07),
                child: ContinueButton(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),
              ),

            ],
          ),
        ),
      ),
    )]);
  }
  Widget _buildVerificationWidget() {
    return Column(
      children: [
        // Condition to show either phone number or email OTP widget
        if (!showOTPWidget)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildPhoneNumberWidget(),  // Phone number widget
          )
        else if (isEmailVerification) // Check if email verification is needed
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _buildEmailWidget(),  // Email widget
          )
        else
          SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: _buildOTPWidget(),  // OTP widget
            ),
          ),
        SizedBox(height: 50),
      ],
    );
  }
  Widget _buildPhoneNumberWidget() {
    buttonText = "Verify OTP";
    return Column(
      children: [
        Text(
          'Enter Your Number',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20) , // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,

          ),
        ),
        SizedBox(height: 40,),
        TextFormField(
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
              padding: const EdgeInsets.only(top: 10, left: 1, bottom: 13),
              child: Image.asset(
                'assets/images/flag.png',
                height: 1,
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
              fontSize: 17,
              fontFamily: "okra_Medium",
            ),
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
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
            hintText: 'Phone number',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),


      ],
    );
  }
  Widget _buildEmailWidget() {
    buttonText = "Verify Email OTP";
    return Column(
      children: [
        Text(
          'Enter Your Email',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20) , // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,

          ),
        ),
        SizedBox(height: 40,),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          focusNode: _phoneFocus,
       /*   validator: (value) {
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
          },*/

          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 10, left: 1, bottom: 13),
              child: Image.asset(
                'assets/images/email.png',
                height: 1,
                color: Colors.black,
              ),
            ),



            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
              color: Color(0xffFE7F64),
              fontSize: 17,
              fontFamily: "okra_Medium",
            ),
            contentPadding: const EdgeInsets.all(12),
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
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
            hintText: 'Enter email',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),


      ],
    );
  }

  Widget _buildOTPWidget() {
    setState(() {
      buttonText = "Next";
    });
    return Column(
      children: [

        Text(
          'Enter Mobile OTP',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20) , // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,

          ),
        ),

        getFirstImageFrame(SizeConfig.screenHeight,SizeConfig.screenWidth),
         /* TextFormField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter OTP',
              labelStyle: TextStyle(
                color: Color(0xffFE7F64),
                fontSize: 17,
                fontFamily: "okra_Medium",
              ),
              contentPadding: EdgeInsets.all(12),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xffFE7F64),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(
                  width: 0.3,
                  color: Color(0xff000000),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Enter OTP',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: "okra_Light",
              ),
            ),
          ),
*/


      ],
    );
  }


  Widget getFirstImageFrame(double parentHeight, double parentWidth) {
    return Center(
      child: SizedBox(

        width: parentWidth,
        height: parentHeight*0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    child: Text(
                      " Send to ",
                      style: TextStyle(
                          fontFamily: "Roboto_Regular",
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          color: CommonColor.Black),
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
                          color: CommonColor.Black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,

                      child: Pinput(
                        length: 4,
                        controller: otpController,
                        focusNode: focusNode,
                        onClipboardFound: (value) {
                          debugPrint('onClipboardFound: $value');
                          otpController.setText(value);
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
                              color: Color(0xffFE7F64),
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                             borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color:Color(0xffFE7F64)),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            // color: fillColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Color(0xffFE7F64)),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(
                              color: Color(0xffFE7F64)),
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
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: isButtonActive
          ? () {
        validatePhoneNumber();
        validateOTP();
        print("Button tapped");
      }
          : null,
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.0,
            left: parentWidth * 0.01,
            right: parentWidth * 0.01),
        child: Container(
            height: parentHeight * 0.06,
            decoration: BoxDecoration(
              color: isButtonActive
                  ? Color(0xffFE7F64)
                  : Color(0xffC8C8C8),

              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
               buttonText,
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
