/*

import 'dart:async';

import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainHome.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'Authentication/register_common.dart';
import 'ConstantData/AuthStorage.dart';
import 'ConstantData/Constant_data.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
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
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          initialRoute: '/',
          home: const MyHomePage(title: ''),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
           // '/frame': (BuildContext context) => onboardingScreen(),
            '/dashboard': (BuildContext context) => MainHome(lat: '', long: '', showLoginWidget: false,),
            '/register': (BuildContext context) => PhoneRegistrationPage(mobileNumber: '', email: '', phoneNumber: '', showLoginWidget: false,

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
    Navigator.of(context).pushReplacementNamed('/register');
  }

  void resetSplashFlag() {
    GetStorage().write('isFirstTimesss', false);
  }


  void navigateHomePage() {
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  Timer startTimer() {
    var duration = const Duration(seconds: 2);

    try {
      bool isFirstTime = GetStorage().read('isFirstTime') ?? true; // Default true
      String? accessToken = AuthStorage.getAccessToken();

      print("📌 First Time: $isFirstTime, Access Token: $accessToken");

      if (isFirstTime) {
        print("🔴 First time user, Navigating to Register Page");
        return Timer(duration, navigateParentPage);
      } else if (accessToken == null || accessToken.isEmpty) {
        print("🟠 Token Not Found, Navigating to Register Page");
        return Timer(duration, navigateParentPage);
      } else {
        print("🟢 Token Found, Navigating to Dashboard");
        return Timer(duration, navigateHomePage);
      }
    } catch (e) {
      print("❌ Error in startTimer: $e");
    }

    return Timer(duration, navigateParentPage); // Default Case
}}*/




import 'dart:async';

import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/MainHome.dart';
import 'package:anything/newGetStorage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'Authentication/register_common.dart';
import 'ConstantData/AuthStorage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Storage Init

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          initialRoute: '/',
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          routes: <String, WidgetBuilder>{
            '/dashboard': (BuildContext context) => MainHome(
              lat: '',
              long: '',
              showLoginWidget: false,
            ),
            '/register': (BuildContext context) => PhoneRegistrationPage(
              mobileNumber: '',
              email: '',
              phoneNumber: '',
              showLoginWidget: false,
            ),
          },
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:Column(


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




  void navigateToRegister() {
    Navigator.of(context).pushReplacementNamed('/register');
  }

  void navigateToDashboard() {
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  Timer startTimer() {
    var duration = const Duration(seconds: 2);

    try {
      bool isFirstTime = GetStorage().read('isFirstTime') ?? false;
      String? accessToken = NewAuthStorage.getAccessToken();

      print("📌 First Time: $isFirstTime, Access Token: $accessToken");

      if (isFirstTime) {
        print("🔴 First time user, Navigating to Register Page");
        return Timer(duration, navigateToRegister);
      } else if (accessToken == null || accessToken.isEmpty) {
        print("🟠 Token Not Found, Navigating to Register Page");
        return Timer(duration, navigateToRegister);
      } else {
        print("🟢 Token Found, Navigating to Dashboard");
        return Timer(duration, navigateToDashboard);
      }
    } catch (e) {
      print("❌ Error in startTimer: $e");
    }

    return Timer(duration, navigateToDashboard); // Default Case
  }
}
