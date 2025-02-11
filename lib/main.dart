import 'dart:async';

import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainHome.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Authentication/onboardingScreen.dart';
import 'Authentication/register_common.dart';
import 'Authentication/register_screen.dart';
import 'ConstantData/Constant_data.dart';





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = GetStorage().read('isFirstTime') ?? true;

    return  ScreenUtilInit(
      designSize: Size(375, 812), // Your design size here
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          initialRoute: '/',
          home: const MyHomePage(title: ''),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/frame': (BuildContext context) => onboardingScreen(),
            '/dashboard': (BuildContext context) => MainHome(lat: '', long: '', showLoginWidget: false,),
            '/register': (BuildContext context) => PhoneRegistrationPage(mobileNumber: '', email: '', phoneNumber: '', showLoginWidget: false,
             /* address: '',
              lat: '',
              long: '',
              ProfilePicture: '',
              firstName: '',
              lastname: '',
              email: '',
              password: '',
              cpassword: '',
              permanetAddress: '',
              mobileNumber: '',
              FrontImage: '',
              BackImage: '',*/
            ),
          },
        );
      },
    );


  }
}


//image: AssetImage("assets/images/renttwo.jpg"),
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resetSplashFlag();
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(


      body: Column(


        children: <Widget>[

          Stack(
            children: [
              Container(

                height: SizeConfig.screenHeight * 0.3,
                decoration: BoxDecoration(
                    color: CommonColor.splashContainer,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(70),
                        bottomLeft: Radius.circular(70))
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.25),
                child: Center(
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,


                    ),
                    child: Image(
                        image: const AssetImage("assets/images/logo.png"),
                        height: SizeConfig.screenHeight * 0.1),

                  ),
                ),
              )
            ],
          ),
          SplashScreen(SizeConfig.screenHeight, SizeConfig.screenWidth)

        ],
      ),

    );
  }


  Widget SplashScreen(double parentHeight, double parentWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: parentWidth * 0.1),
          child: Image(image: AssetImage("assets/images/group.png"),
              height: parentHeight * 0.2),
        ),

        SizedBox(height: 30),

        Text("Anything on Rent",
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.blockSizeHorizontal * 6.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.only(
              left: parentWidth * 0.09, right: parentWidth * 0.09),
          child: Text(
              "Upgrade your Product with new products after 15 Days of use for free",
              style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeHorizontal * 4.0,

                fontFamily: 'Montserrat-Medium',

              ),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center),
        ),


        //     Style

      ],
    );
  }


  void navigateParentPage() {
    Navigator.of(context).pushReplacementNamed('/frame');
  }

  void resetSplashFlag() {
    GetStorage().write('isFirstTimesss', false);
  }



  void navigateHomePage() {
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }


  startTimer() {
    var duration = const Duration(seconds: 2);
    try {
      String accessToken = GetStorage().read(ConstantData.UserAccessToken);

      print("-----> $accessToken");

      if (accessToken.isEmpty) {
        return Timer(duration, navigateParentPage);
      } else if (accessToken.isNotEmpty) {
        return Timer(duration, navigateHomePage);
      }
    } catch (e) {
      print("Error: $e");
    }
    return Timer(duration, navigateParentPage); // Default navigate to onboarding if any error occurs
  }
}





