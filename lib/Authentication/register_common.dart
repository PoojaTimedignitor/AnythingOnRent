import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:pinput/pinput.dart';
import 'package:get_storage/get_storage.dart';

import '../ConstantData/Constant_data.dart';
import '../MainHome.dart';
import '../model/dio_client.dart';

const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
const fillColor = Color.fromRGBO(243, 246, 249, 0);
const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

bool isLoading = false;

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
    fontSize: 22,
    color: Color(0xffFE7F64),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(0),
    border: Border.all(color: CommonColor.Black),
  ),
);

class PhoneRegistrationPage extends StatefulWidget {
  late final String mobileNumber;
  late final String email;
  final String phoneNumber;

  PhoneRegistrationPage({
    Key? key,
    required this.mobileNumber,
    required this.email,
    required this.phoneNumber,
  }) : super(key: key);
  @override
  _PhoneRegistrationPageState createState() => _PhoneRegistrationPageState();
}

class _PhoneRegistrationPageState extends State<PhoneRegistrationPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController emailOTPController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController ReferralCodeController = TextEditingController();
  bool isCodeValid = false;
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _ReferralFocus = FocusNode();
  final _permanentAddressFocus = FocusNode();

  final focusNode = FocusNode();
  final emailOTPFocusNode = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  bool isButtonActive = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  var code = "";
  String selectedGender = 'Male';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void clearOTPField() {
    otpController.clear();
  }

  void clearOTPEmailField() {
    emailOTPController.clear();
  }

  String? phoneNumber;
  String? email;
  String? _number;
  bool showOTPWidget = false;

  String buttonText = "Verify OTP";
  bool isEmailVerification = false;
  bool isOTPEmailVerification = false;
  bool isNextScreen = false;
  bool continueScreen = false;
  final ApiClients authService = ApiClients();

  @override
  void initState() {
    super.initState();
    if (mounted)
      phoneController.addListener(() {
        print("Phone Number Entered: ${phoneController.text}");

        setState(() {
          isButtonActive = phoneController.text.length == 10 &&
              RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text);
        });

        print("Is Button Active: $isButtonActive");
      });
    /* String? phoneNumber = GetStorage().read<String>(ConstantData.UserMobile);
    print("phoneNumber: $phoneNumber");*/

    /* _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 5000), // Duration of animation
    );

    // SlideAnimation ki setup
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Slide from right
      end: Offset(0.0, 0.0),    // Slide to the original position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Animation start karna
    _animationController.forward();*/

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    ReferralCodeController.addListener(() {
      // Check if the referral code has 6 digits and update state
      if (ReferralCodeController.text.length == 6) {
        setState(() {
          isCodeValid = true;
        });
      } else {
        setState(() {
          isCodeValid = false;
        });
      }
    });


  }

  @override
  void dispose() {
    _animationController.dispose();
    phoneController.dispose();
    otpController.dispose();
    emailController.dispose();
    emailOTPController.dispose();
    _phoneFocus.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> validatePhoneNumber() async {
    final phoneNumber = phoneController.text.trim();

    if (phoneNumber.isEmpty || phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 10-digit phone number')),
      );
      return;
    }

    bool isRegistered = await authService.sendMobileOtp(phoneNumber);

    if (isRegistered) {
      GetStorage().write('phoneNumber', phoneNumber);
      print(
          "📌 Stored Phone Number: ${GetStorage().read<String>('phoneNumber')}");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent successfully!')),
      );

      setState(() {
        showOTPWidget = true;
        _animationController.forward();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP. Try again!')),
      );
    }
  }

  Future<void> validateOTP() async {
    final otp = otpController.text.trim();

    if (otp.isEmpty || otp.length != 4 || !RegExp(r'^\d{4}$').hasMatch(otp)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
      return;
    }

    String? phoneNumber = GetStorage().read<String>(ConstantData.UserMobile);
    print("📌 Retrieved Phone Number: $phoneNumber");

    bool isVerified = await authService.verifyMobileOtp(phoneNumber!, otp);

    if (isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verified successfully!')),
      );

      setState(() {
        isEmailVerification = true;
        clearOTPField();
        _animationController.forward();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Try again!')),
      );
    }
  }

  bool handleBackPress() {
    if (showOTPWidget) {
      setState(() {
        showOTPWidget = false;
        _animationController.reverse();
      });
      return false;
    } else if (isOTPEmailVerification) {
      setState(() {
        isOTPEmailVerification = false;
      });
      return false;
    } else if (continueScreen) {
      setState(() {
        continueScreen = false;
      });
      return false;
    } else {
      return true;
    }
  }

/*  Future<void> validateEmail() async {
    final email = emailController.text.trim();

    final emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }



    // Read the phone number from local storage
    String? phoneNumber = GetStorage().read<String>('phoneNumber');

    if (phoneNumber == null || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number is not found in storage!')),
      );
      return;
    }

    print("📞 Sending OTP to: $phoneNumber");

    // Call the sendEmailOtp function to send OTP to the email
    bool isRegistered = await authService.sendEmailOtp(phoneNumber, email);

    if (isRegistered) {
      // Save the email in local storage
      GetStorage().write('email', email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to email successfully!')),
      );

      setState(() {
        isOTPEmailVerification = true;
      });
    }
    print("Email is valid: $email");
  }*/

  Future<void> validateEmail() async {
    final email = emailController.text.trim();

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    String? phoneNumber = GetStorage().read<String>('phoneNumber');

    if (phoneNumber == null || phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number is not found in storage!')),
      );
      return;
    }

    print("📞 Sending OTP to: $phoneNumber");

    var response = await authService.sendEmailOtp(phoneNumber, email);

    print('API Response: $response'); // Debugging

    if (response != null && response.containsKey('message')) {
      String apiMessage = response['message'];

      if (apiMessage.contains("OTP sent successfully")) {
        print("✅ OTP Sent Successfully");
        GetStorage().write('email', email);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP sent to email successfully!')),
        );

        setState(() {
          isOTPEmailVerification = true;
          _animationController.forward(); // Ensure this is working
        });
      } else {
        print("❌ Failed to send OTP: $apiMessage");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(apiMessage)), // Show API error message
        );
      }
    } else {
      print("❌ Failed to send OTP, showing SnackBar");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email OTP. Try again!')),
      );
    }
  }

  Future<void> validateEmailOTP() async {
    final otps = emailOTPController.text.trim();
    print("📩 Entered OTP: $otps");

    if (otps.isEmpty ||
        otps.length != 4 ||
        !RegExp(r'^\d{4}$').hasMatch(otps)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
      return;
    }

    String? phoneNumber = GetStorage().read<String>('phoneNumber');
    String? email = GetStorage().read<String>('email');

    if (email == null) {
      var response = await authService.sendEmailOtp(
          phoneNumber!, ""); // Empty email if not known
      if (response != null && response.containsKey('email')) {
        email = response['email']; // Extract email from response
        print("📩 Email fetched from API: $email");
      } else {
        print("❌ No email found in response!");
      }
    }

    print("🔢 Verifying OTP: $otps for phone: $phoneNumber, email: $email");

    bool isVerified =
        await authService.verifyEmailOtp(email!, phoneNumber!, otps);

    if (isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verified successfully!')),
      );

      if (isOTPEmailVerification) {
        otpController.clear();
      }

      setState(() {
        isNextScreen = true;
        _animationController.forward();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP. Try again!')),
      );
    }
  }

  void ContinueScreen() {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final password = passwordController.text.trim();

    final address = permanentAddressController.text.trim(); // Permanent Address

    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');

    if (firstName.isEmpty || !nameRegex.hasMatch(firstName)) {
      showSnackbar('Please enter a valid First Name (only letters)');
      return;
    }

    if (lastName.isEmpty || !nameRegex.hasMatch(lastName)) {
      showSnackbar('Please enter a valid Last Name (only letters)');
      return;
    }

    if (password.isEmpty || !passwordRegex.hasMatch(password)) {
      showSnackbar(
          'Password must be at least 6 characters, include 1 letter & 1 number');
      return;
    }

    if (address.isEmpty || address.length < 5) {
      showSnackbar('Please enter a valid Permanent Address (min 5 chars)');
      return;
    }

    setState(() {
      continueScreen = true;
    });

    Navigator.push(
      context, // Use the stored context
      MaterialPageRoute(builder: (context) => MainHome()),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        //backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'assets/images/renttwo.jpg',
          fit: BoxFit.cover,
        ),
      ),
      WillPopScope(
        onWillPop: () async {
          return handleBackPress();
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                //otpController.clear();
                // emailOTPController.clear();
                //     passwordController.clear();

                setState(() {
                  if (showOTPWidget) {
                    showOTPWidget = false;
                    _animationController.reverse();
                  } else if (isOTPEmailVerification) {
                    otpController.clear();
                    isOTPEmailVerification = false;
                    _animationController.reverse();
                  } else if (continueScreen) {
                    continueScreen = false;
                    _animationController.reverse();
                  } else {
                    Navigator.pop(context);
                  }
                });
              },
            ), // Reusable back arrow widget
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 160, bottom: 30),
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      _buildVerificationWidget(),
                      SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildVerificationWidget() {
    return Column(
      children: [
        if (!showOTPWidget)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                _buildPhoneNumberWidget(),
                SizedBox(height: 50),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: 'Send Mobile OTP',
                    onPressed: validatePhoneNumber),
              ],
            ),
          )
        else if (!isEmailVerification)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SlideTransition(
                    position: _slideAnimation, child: _buildOTPWidget()),
                SizedBox(height: 20),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: ' Verify OTP', onPressed: validateOTP),
              ],
            ),
          )
        else if (!isOTPEmailVerification)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildEmailWidget(), // Email widget
                ),
                SizedBox(height: 50),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: ' Send Email OTP', onPressed: validateEmail),
              ],
            ),
          )
        else if (!isNextScreen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _buildEmailOTPWidget(),
                SizedBox(height: 50),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: ' Next', onPressed: validateEmailOTP),
              ],
            ),
          )
        else if (!continueScreen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildDetailsWidget(SizeConfig.screenHeight,SizeConfig.screenHeight),
                SizedBox(height: 50),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: ' Continue', onPressed: ContinueScreen),
              ],
            ),
          )

        /* else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MainHome(),
          ),*/
      ],
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
            fontSize: ResponsiveUtil.fontSize(20), // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 40,
        ),
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
          inputFormatters: [
            LengthLimitingTextInputFormatter(10), // Restrict to 10 digits
            FilteringTextInputFormatter.digitsOnly, // Allow only numbers
          ],
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
    return Column(
      children: [
        Text(
          'Enter Your Email',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20), // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.text,
          focusNode: _emailFocus,
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
              padding: const EdgeInsets.only(top: 14, left: 1, bottom: 10),
              child: Image.asset(
                'assets/images/email.png',
                height: 07,
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

  Widget _buildEmailOTPWidget() {
    String? email = GetStorage().read<String>('email');

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 19),
                child: Text(
                  'Enter Email OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "okra_extrabold",
                    fontSize: ResponsiveUtil.fontSize(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (isOTPEmailVerification) {
                    isOTPEmailVerification = false;
                  }
                });
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontFamily: "okra_Medium",
                    fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                    color: Color(0xff3684F0),
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ],
        ),
        getFirstImageFrame(
          SizeConfig.screenHeight,
          SizeConfig.screenWidth,
          title: "Send to",
          contactInfo: "$email",
          onPressed: () {},
          showOTPField: true,
        ),
      ],
    );
  }

  Widget _buildOTPWidget() {
    String? phoneNumber = GetStorage().read<String>('phoneNumber');
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 19),
                child: Text(
                  'Enter Mobile OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "okra_extrabold",
                    fontSize: ResponsiveUtil.fontSize(20),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (showOTPWidget) {
                    showOTPWidget = false;
                    _animationController.reverse();
                  }
                });
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontFamily: "okra_Medium",
                    fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                    color: Color(0xff3684F0),
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ],
        ),
        getFirstImageFrame(
          SizeConfig.screenHeight,
          SizeConfig.screenWidth,
          title: 'Send to',
          contactInfo: "+91$phoneNumber",
          onPressed: () {},
          showOTPField: true,
        ),
      ],
    );
  }

  Widget getFirstImageFrame(
    double parentHeight,
    double parentWidth, {
    required String title,
    required String contactInfo, // Dynamic Mobile Number / Email
    required VoidCallback onPressed,
    bool showOTPField = true, // Enable/Disable OTP Field
  }) {
    print('Phone Number: ${widget.phoneNumber}');
    print('Contact Info: $contactInfo');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " $title ", // Dynamic text
                  style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    color: CommonColor.Black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: parentWidth * 0.0),
                  child: Text(
                    contactInfo, // Dynamic Mobile Number / Email
                    style: TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                      color: CommonColor.Black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showOTPField)

            // Only show OTP if enabled
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 4,
                        controller:
                            isEmailVerification || isOTPEmailVerification
                                ? emailOTPController
                                : otpController,
                        focusNode: focusNode,
                        onClipboardFound: (value) {
                          debugPrint('📋 OTP Pasted: $value');

                          if (isEmailVerification || isOTPEmailVerification) {
                            emailOTPController.setText(value);
                          } else {
                            otpController.setText(value);
                          }
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('✅ OTP Entered: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('🔄 OTP Changed: $value');
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
                            border: Border.all(color: Color(0xffFE7F64)),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Color(0xffFE7F64)),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Color(0xffFE7F64)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailsWidget(double parentHeight, double parentWidth) {
    String? phoneNumber = GetStorage().read<String>('phoneNumber');
    String? email = GetStorage().read<String>('email');

    return Column(
      children: [
        Text(
          'Enter Your Details',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20), // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ), SizedBox(
          height: 20,
        ),
        Container(
          height: parentHeight * 0.18,
          decoration: BoxDecoration(
            color: Colors.white,
           /* gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xfff44343),
                Color(0xffFEA3A3),
              ],
            ),*/
               border: Border.all(width: 0.5, color: Color(0xffFE7F64)),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),child: Padding(
            padding:  EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Column(
            children: [

              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Your Phone", // Dynamic Mobile Number / Email
                  style: TextStyle(
                    fontFamily: "okra_Medium",
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                    color: Color(0xffFE7F64),
                    //color: CommonColor.Black,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:  EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "+91$phoneNumber", // Dynamic Mobile Number / Email
                        style: /*TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                      color: CommonColor.Black,
                    ),*/
                        TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "okra_Light",
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 70,
                        child: Row(


                          children: [
                            Image(image: AssetImage('assets/images/circle_check.png'),height: 15,),
                            SizedBox(width: 5,),
                            Text(
                              "Verify", // Dynamic Mobile Number / Email
                              style: TextStyle(
                                fontFamily: "okra_Medium",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                                color: Color(0xfa1cb363),
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Your Email", // Dynamic Mobile Number / Email
                  style: TextStyle(
                    fontFamily: "okra_Medium",
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                    color: Color(0xffFE7F64),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:  EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$email", // Dynamic Mobile Number / Email
                        style: /*TextStyle(
                      fontFamily: "Roboto_Regular",
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                      color: CommonColor.Black,
                    ),*/
                        TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "okra_Light",
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        width: 70,
                        child: Row(


                          children: [
                            Image(image: AssetImage('assets/images/circle_check.png'),height: 15,),
                            SizedBox(width: 5,),
                            Text(
                              "Verify", // Dynamic Mobile Number / Email
                              style: TextStyle(
                                fontFamily: "okra_Medium",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                                color: Color(0xfa1cb363),
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],
                    ),
          ),
        ),

        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: firstNameController,
          keyboardType: TextInputType.text,
          focusNode: _firstNameFocus,
          // autocorrect: true,
          textInputAction: TextInputAction.next,

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'First Name cannot be empty'; // Error message
            }
            return null;
          },
          decoration: InputDecoration(
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            labelText: 'First Name',
            labelStyle: TextStyle(
              color: Color(0xffFE7F64),
              fontSize: 19,
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
            hintText: 'First Name',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(height: 40),
        TextFormField(
          controller: lastNameController,
          keyboardType: TextInputType.text,
          focusNode: _lastNameFocus,
          // autocorrect: true,
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            labelText: 'Last Name',
            labelStyle: TextStyle(
              color: Color(0xffFE7F64),
              fontSize: 19,
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
            hintText: 'Last Name',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(height: 40),
        TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          focusNode: _passwordFocus,
          // autocorrect: true,
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            labelText: 'Create Password',
            labelStyle: TextStyle(
              color: Color(0xffFE7F64),
              fontSize: 19,
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
            hintText: 'Create Password',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(height: 40),
        TextFormField(
          controller: permanentAddressController,
          keyboardType: TextInputType.text,
          focusNode: _permanentAddressFocus,
          // autocorrect: true,
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            labelText: 'Permanent Address',
            labelStyle: TextStyle(
              color: Color(0xffFE7F64),
              fontSize: 19,
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
            hintText: 'Permanent Address',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Gender",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: "okra_Medium",
                )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildGenderOption('Male'),
                _buildGenderOption('Female'),
                _buildGenderOption('Other'),
              ],
            ),
          ],
        ),
        SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "Referral Code",
                style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: "okra_Medium",
                ),
                    children: [
                      TextSpan(
                        text: " (Optional)",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,

                            fontFamily: 'Roboto-Regular',
                            fontSize: 17),

                      ),
                    ])),
          ],
        ),
        SizedBox(height: 15),
       /* TextFormField(
          controller: ReferralCodeController,
          keyboardType: TextInputType.text,
          focusNode: _ReferralFocus,
          // autocorrect: true,
          textInputAction: TextInputAction.next,

          decoration: InputDecoration(
            prefixStyle: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            //labelText: 'Create Password',
       *//*     labelStyle: TextStyle(
              color: Color(0xffFE7F64),
              fontSize: 19,
              fontFamily: "okra_Medium",
            ),*//*
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
            hintText: 'Referral Code',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontFamily: "okra_Light",
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),*/

        TextFormField(
        controller: ReferralCodeController,
    keyboardType: TextInputType.text,
    focusNode: _ReferralFocus,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
    prefixStyle: TextStyle(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.w500,
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
    hintText: 'Referral Code',
    hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontFamily: "okra_Light",
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    suffixIcon: GestureDetector(
    onTap: () {
    if (isCodeValid) {
    // Implement verify action here
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Referral Code Verified!')),
    );
    }
    },
    child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    color: isCodeValid ? Colors.green : Colors.grey,
    child: Text(
    'Verify',
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    ),
    )

      ],
    );
  }

  Widget ContinueButton(double parentHeight, double parentWidth,
      {required String buttonText, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: () {
        if (isButtonActive) {
          print("Button Clicked!");
          onPressed();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: parentHeight * 0.0,
            left: parentWidth * 0.01,
            right: parentWidth * 0.01),
        child: Container(
            height: parentHeight * 0.06,
            decoration: BoxDecoration(
              color: isButtonActive ? Color(0xffFE7F64) : Color(0xffC8C8C8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                    color: CommonColor.Black),
              ),
            )),
      ),
    );
  }

  Widget _buildGenderOption(String gender) {
    bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Color(0xffFE7F64)
                    : Colors.black.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFE7F64),
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8),
          Text(
            gender,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Color(0xffFE7F64) : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
