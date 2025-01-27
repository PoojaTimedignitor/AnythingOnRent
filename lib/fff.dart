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

                          /*   child: Text(
                            "State",
                            style:
                            TextStyle(color: CommonColor.REGISTRARTION_TRUSTEE),
                          )*/
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
}