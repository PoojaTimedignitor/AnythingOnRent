/*
import 'package:flutter/material.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({super.key});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
*/





//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ComingSoonScreen extends StatelessWidget {
//   const ComingSoonScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Spotlights
//           Positioned(
//             top: 50,
//             left: 40,
//             child: _spotlight(),
//           ),
//           Positioned(
//             top: 50,
//             right: 40,
//             child: _spotlight(),
//           ),
//
//           // Center Text
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Coming",
//                   style: GoogleFonts.greatVibes(
//                     fontSize: 80,
//                     color: Colors.white.withOpacity(0.9),
//                     shadows: [
//                       Shadow(
//                         color: Colors.white.withOpacity(0.3),
//                         blurRadius: 15,
//                         offset: Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   "SOON",
//                   style: GoogleFonts.bebasNeue(
//                     fontSize: 60,
//                     color: Colors.grey[300],
//                     letterSpacing: 5,
//                     shadows: [
//                       Shadow(
//                         color: Colors.black.withOpacity(0.8),
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Bottom glow
//           Positioned(
//             bottom: 100,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 height: 100,
//                 width: 250,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [
//                       Colors.white.withOpacity(0.15),
//                       Colors.transparent,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Spotlight Widget
//   Widget _spotlight() {
//     return Column(
//       children: [
//         Icon(Icons.light, size: 40, color: Colors.white24),
//         Container(
//           width: 60,
//           height: 100,
//           decoration: BoxDecoration(
//             gradient: RadialGradient(
//               radius: 1,
//               center: Alignment.topCenter,
//               colors: [
//                 Colors.white.withOpacity(0.2),
//                 Colors.transparent,
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Common_File/common_color.dart';
import '../Common_File/new_responsive_helper.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      //backgroundColor: Colors.pink[100],
      body: Center(
        child: Container(
          color: Colors.black,
          height: 300,
          margin: responsive.getMargin(all: 0).copyWith(top: responsive.isMobile ? 2 : 4 , bottom: responsive.isMobile ? 2 : 4 , left: responsive.isMobile ? 5 : 4 , right: responsive.isMobile ? 5 : 4 , ),

         // padding: responsive.getPadding(all: 0).copyWith(left: responsive.isMobile ? 10 : 30, top: responsive.isMobile ? 3 : 5),              /// new add responsive padding

          // width: responsive.width(
          //   responsive.isMobile ? 380 : responsive.isTablet ? 370 : 420,
          // ),
          child: Stack(
            children: [

              // Container(
              //   height: 150,
              //   width: double.infinity,
              //   margin: responsive.getMargin(all: 0).copyWith(top: responsive.isMobile ? 70 : 4 , bottom: responsive.isMobile ? 2 : 4 , left: responsive.isMobile ? 10 : 4 , right: responsive.isMobile ? 10 : 4 , ),
              //   decoration: const BoxDecoration(
              //      // color: Colors.pink[100]
              //   ),
              //      child: Column(
              //        mainAxisAlignment: MainAxisAlignment.center,
              //        crossAxisAlignment: CrossAxisAlignment.center,
              //        children: [
              //          Container(
              //            color: Colors.black54,
              //            height: 25,
              //            //width: 20,
              //            child: const Text('data', style: TextStyle(color: Colors.cyan),),
              //          ),
              //          const SizedBox(height: 10,),
              //          Container(
              //            height: 25,
              //            //width: 20,
              //            decoration: BoxDecoration(
              //              color: Colors.black54,
              //              border: Border.all(color: CommonColor.grayText, width: 0.3),
              //            ),
              //            child: const Text('data', style: TextStyle(color: Colors.cyan),),
              //          ),
              //          const SizedBox(height: 10,),
              //          Container(
              //            color: Colors.black54,
              //            height: 25,
              //            //width: 20,
              //            child: const Text('data', style: TextStyle(color: Colors.cyan),),
              //          ),
              //        ],
              //      ) ,
              // ),

              // Spotlights
              Positioned(
                top: 10,
                left: 20,
                child: _spotlight(),
              ),

              Positioned(
                top: 10,
                right: 20,
                child: _spotlight(),
              ),


              // Center Text
              Align(
                alignment: Alignment.center,
                child: Column(
                 // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Coming",
                      style: GoogleFonts.greatVibes(
                        fontSize: 80,
                      //  color: Colors.white.withOpacity(0.9),
                        color: Colors.white.withOpacity(0.2),
                        shadows: [
                          const Shadow(
                           // color: Colors.white.withOpacity(0.3),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                    Text(
                      "SOON",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 60,
                        color: Colors.white.withOpacity(0.2),
                        // color: Colors.grey[300],
                        letterSpacing: 5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.8),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  margin: responsive.getMargin(all: 0).copyWith(
                   // top: responsive.isMobile ? 70 : 4,
                    //bottom: responsive.isMobile ? 2 : 4,
                    left: responsive.isMobile ? 20 : 4,
                    right: responsive.isMobile ? 20 : 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          border: Border.all(
                              color: CommonColor.grayText, width: 0.3),
                        ),
                        child: const Center(
                          child: Text(
                            'data',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          border: Border.all(
                              color: CommonColor.grayText, width: 0.3),
                        ),
                        child: const Center(
                          child: Text(
                            'data',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          border: Border.all(
                              color: CommonColor.grayText, width: 0.3),
                        ),
                        child: const Center(
                          child: Text(
                            'data',
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom glow
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: responsive.height(
                      responsive.isMobile ? 40 : responsive.isTablet ? 55 : 70,
                    ),
                    width: responsive.width(
                      responsive.isMobile ? 320 : responsive.isTablet ? 370 : 420,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Spotlight Widget
  Widget _spotlight() {
    return Column(
      children: [
        const Icon(Icons.light, size: 40, color: Colors.white24),
        Container(
          width: 60,
          height: 100,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              center: Alignment.topCenter,
              colors: [
                Colors.white.withOpacity(0.2),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }
}




/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Common_File/common_color.dart';
import '../Common_File/new_responsive_helper.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: 200,
          width: responsive.width(
            responsive.isMobile ? 320 : responsive.isTablet ? 370 : 420,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// BACKGROUND: Coming / SOON
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Coming",
                      style: GoogleFonts.greatVibes(
                        fontSize: 80,
                        color: Colors.white.withOpacity(0.2),
                        shadows: const [
                          Shadow(
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "SOON",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 60,
                        color: Colors.white.withOpacity(0.15),
                        letterSpacing: 5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.8),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// FOREGROUND: Container with text blocks
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  margin: responsive.getMargin(all: 0).copyWith(
                    top: responsive.isMobile ? 70 : 4,
                    bottom: responsive.isMobile ? 2 : 4,
                    left: responsive.isMobile ? 10 : 4,
                    right: responsive.isMobile ? 10 : 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.black54,
                        height: 25,
                        child: const Text(
                          'data',
                          style: TextStyle(color: Colors.cyan),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          border: Border.all(
                              color: CommonColor.grayText, width: 0.3),
                        ),
                        child: const Text(
                          'data',
                          style: TextStyle(color: Colors.cyan),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        color: Colors.black54,
                        height: 25,
                        child: const Text(
                          'data',
                          style: TextStyle(color: Colors.cyan),
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
}
*/
