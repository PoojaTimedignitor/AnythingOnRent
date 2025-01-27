import 'package:flutter/material.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';

class PhoneRegistrationPage extends StatefulWidget {
  @override
  _PhoneRegistrationPageState createState() => _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends State<PhoneRegistrationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  bool isButtonActive = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  String? _number;
  bool showOTPWidget = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 220),
        child: Stack(
          children: [
            // Background Image
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                height: 120,
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 30),
                  child: Text(
                   '',
                    textAlign: TextAlign.center,
             
                  ),
                ),

                if (!showOTPWidget)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: _buildPhoneNumberWidget(),
                  )
                else
                  SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: _buildOTPWidget(),
                    ),
                  ),
                SizedBox(height: 50),
                ContinueButton(
                    SizeConfig.screenHeight, SizeConfig.screenWidth),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberWidget() {
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

  Widget _buildOTPWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter OTP"),
          TextFormField(
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

        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add OTP verification logic here
          },
          child: Text('Verify OTP'),
        ),
      ],
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: isButtonActive
          ? () {
       // validatePhoneNumber;
        print("Button tapped");
      }
          : null,
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.0,
            left: parentWidth * 0.08,
            right: parentWidth * 0.08),
        child: Container(
            height: parentHeight * 0.06,
            decoration: BoxDecoration(
              color: isButtonActive
                  ? Color(0xffFE7F64)
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
