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
import 'package:anything/MainHome.dart';
import 'package:anything/newGetStorage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'Authentication/register_common.dart';
import 'mm.dart';

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
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: DevicePreview.appBuilder(context, widget),
            );
          },
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

class SplashScreen extends StatefulWidget   {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>

    with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
 late AnimationController _controllerZoom;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
     startTimer();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800), // Animation duration
    );


    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller)
      ..addStatusListener((status) {
        // Repeat the animation back and forth
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    // 3. Start animation
    _controller.forward();



/*
    _controllerZoom = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );


    _animation = Tween(begin: 0.0, end: 200.0).animate(_controller);


    _controllerZoom.addListener(() {
      setState(() {});
    });

    // Start the animation
    _controllerZoom.forward();*/




    _controllerZoom = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Define an animation that goes from 0 (zoomed out) to 1 (full size).
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controllerZoom, curve: Curves.easeInOut),
    );

    // Start the animation as soon as the widget is built.
    _controllerZoom.forward();
  }




  @override
  void dispose() {
    // Always dispose controller to free resources
    _controller.dispose();
    _controllerZoom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.only(top: 240),
        child: Stack(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ddt(
                          )));
                },
                child:

                ScaleTransition(
                  scale: _animation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100, left: 90),
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                          image: AssetImage("assets/images/logo.png"),
                        ),
                      ),
                    ),
                  ),
                )

            ),
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: Container(
                height: 200,
                width: 400,
              // color: Colors.red,
                child: Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 100,left: 20),
                      child: Image(
                        image: const AssetImage("assets/images/splash_one.png"),height: 50,
                      ),
                    ),




                    Padding(
                      padding:  EdgeInsets.only(bottom: 60),
                      child: Image(
                        image: const AssetImage("assets/images/splash_two.png"),height: 60,
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(bottom: 80,left: 80),
                      child: Image(
                        image:  AssetImage("assets/images/splash_three.png"),height: 50,
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 10,top: 30),
                      child: Image(
                        image:  AssetImage("assets/images/splash_four.png"),height: 60,
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

      print("First Time: $isFirstTime, Access Token: $accessToken");

      if (isFirstTime) {
        print("First time user, Navigating to Register Page");
        return Timer(duration, navigateToRegister);
      } else if (accessToken == null || accessToken.isEmpty) {
        print("Token Not Found, Navigating to Register Page");
        return Timer(duration, navigateToRegister);
      } else {
        print("Token Found, Navigating to Dashboard");
        return Timer(duration, navigateToDashboard);
      }
    } catch (e) {
      print("Error in startTimer: $e");
    }

    return Timer(duration, navigateToDashboard); // Default Case
  }
}
