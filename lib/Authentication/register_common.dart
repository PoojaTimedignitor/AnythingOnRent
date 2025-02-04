import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:pinput/pinput.dart';
import 'package:get_storage/get_storage.dart';

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
    color: Color(0xffFE7F64) /* Color.fromRGBO(30, 60, 87, 1)*/,
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
    required this.email, required this.phoneNumber,
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

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _passwordFocus = FocusNode();
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
  bool isOTPEmailVerification =
  false;
  bool isNextScreen = false;
  bool continueScreen = false;
  final ApiClients authService = ApiClients(); // API Service का Object

  @override
  void initState() {
    super.initState();
    if (mounted)
      phoneController.addListener(() {
        print("Phone Number Entered: ${phoneController.text}");

        // Update button state
        setState(() {
          isButtonActive = phoneController.text.length == 10 &&
              RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text);
        });

        print("Is Button Active: $isButtonActive");
      });
    phoneNumber = GetStorage().read<String>('phoneNumber'); // 📌 Saved Phone Number
    _animationController = AnimationController(
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
    _animationController.forward();
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

    print("📞 Sending OTP to: $phoneNumber");

    bool isRegistered = await authService.sendMobileOtp(phoneNumber);

    if (isRegistered) {
      GetStorage().write('phoneNumber', phoneNumber); // ✅ Save phone number
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent successfully!')),
      );

      setState(() {
        showOTPWidget = true;
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

    print("🔢 Verifying OTP: $otp for $phoneNumber");


    phoneNumber = GetStorage().read<String>('phoneNumber');  // Read phone number from storage


    bool isVerified = await authService.verifyMobileOtp(phoneNumber!, otp);

    if (isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verified successfully!')),
      );


      setState(() {
        isEmailVerification = true;
        clearOTPField();
      });

      Navigator.pushNamed(context, '/emailVerification');
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

    print('isRegistered: $isRegistered'); // Debugging print
    print("📞 phone: $phoneNumber");
    print("📞 email: $email");
    if (isRegistered) {
      print("✅ OTP Sent Successfully");
      GetStorage().write('email', email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent to email successfully!')),
      );

      setState(() {
        isOTPEmailVerification = true;
      });

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, '/Otp');
      });
    } else {
      print("❌ Failed to send OTP, showing SnackBar"); // Debugging Print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email OTP. Try again!')),
      );
    }
    print("Email is valid: $email");
  }




  Future<void> validateEmailOTP() async {
    final otps = emailOTPController.text.trim();
    print("📩 Entered OTP: $otps");

    if (otps.isEmpty || otps.length != 4 || !RegExp(r'^\d{4}$').hasMatch(otps)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
      return;
    }

    print("🔢 Verifying OTP: $otps for $phoneNumber");

    phoneNumber = GetStorage().read<String>('phoneNumber');  // Phone number ko storage se read karo
    email = GetStorage().read<String>('email');  // Email ko storage se read karo

    print("hhhh   ${otps}");
    bool isVerified = await authService.verifyEmailOtp(phoneNumber!, email!, otps);
    print("🔢 phone: $phoneNumber, email: $email");

    if (isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP verified successfully!')),
      );

      // OTP verification successful hone par OTP field clear karo
      if (isOTPEmailVerification) {
        otpController.clear(); // Email OTP verification ke baad OTP field clear karo
      }

      setState(() {
        isNextScreen = true;
        clearOTPField();
      });

      // Agle screen pe jaane ke liye code daalein
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
    final passwordRegex =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');


    if (firstName.isEmpty || !nameRegex.hasMatch(firstName)) {
      showSnackbar('Please enter a valid First Name (only letters)');
      return;
    }

    if (lastName.isEmpty || !nameRegex.hasMatch(lastName)) {
      showSnackbar('Please enter a valid Last Name (only letters)');
      return;
    }

    if (password.isEmpty || !passwordRegex.hasMatch(password)) {
      showSnackbar('Password must be at least 6 characters, include 1 letter & 1 number');
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
        onWillPop: () async{
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
                    position: _slideAnimation,
                    child: _buildOTPWidget(phoneNumber!)),
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
                  child: _buildEmailWidget(phoneNumber!), // Email widget
                ),
                SizedBox(height: 50),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: ' Send Email OTP', onPressed: validateEmail),
              ],
            ),
          )
        else if (!isNextScreen)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                _buildEmailOTPWidget(email,phoneNumber!,),
                SizedBox(height: 50),
                ContinueButton(SizeConfig.screenHeight, SizeConfig.screenWidth,
                    buttonText: ' Next', onPressed: validateEmailOTP),
              ],
            ),
          )
              else if (!continueScreen)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        _buildDetailsWidget(),
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

  Widget _buildEmailWidget(String PhoneNumber) {
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

  Widget _buildEmailOTPWidget(String? email,String? phoneNumber) {
    return Column(
      children: [
        Text(
          'Enter Email OTP',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20), // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        getFirstImageFrame(
          SizeConfig.screenHeight, SizeConfig.screenWidth, title: "Send to",
          contactInfo: widget.email, // Pass email dynamically
          onPressed:
           (){

           },

          showOTPField: true,
        ),
      ],
    );
  }

  Widget _buildOTPWidget(String phoneNumber) {
    return Column(
      children: [
        Text(
          'Enter Mobile OTP',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20), // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        getFirstImageFrame(
          SizeConfig.screenHeight,
          SizeConfig.screenWidth,
          title: 'Send to',
          contactInfo: "+91$phoneNumber",
          onPressed:
          (){
          },
          showOTPField: true,
        ),

      ],
    );
  }

  Widget getFirstImageFrame(
      double parentHeight,
      double parentWidth, {
        required String title, // Dynamic Title (Send to Mobile / Email)
        required String contactInfo, // Dynamic Mobile Number / Email
        required VoidCallback onPressed,
        bool showOTPField = true, // Enable/Disable OTP Field
      }) {
    print('Phone Number: ${widget.phoneNumber}');
    print('Contact Info: $contactInfo');
    return Center(

      child: Container(

        width: parentWidth,
        height: parentHeight * 0.2, // Increased height for better layout
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
                          controller: isEmailVerification || isOTPEmailVerification
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
      ),
    );
  }

  Widget _buildDetailsWidget() {
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
        ),
        SizedBox(
          height: 20,
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
        Text("Gender", style :TextStyle(
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
                color: isSelected ? Color(0xffFE7F64) : Colors.black.withOpacity(0.3),
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


