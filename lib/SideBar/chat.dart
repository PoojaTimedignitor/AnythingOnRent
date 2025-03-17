/*

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child:SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Share.share('Check out this amazing app: https://example.com');
            },
            child:  Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/MobileImage (1).jpg' ,),
                Text("Share App", style: TextStyle(fontSize: 16)),
                SizedBox(width: 5),
                Icon(Icons.share, size: 18),
              ],
            ),
          ),
        )
      ),
    );
  }
}
*/




import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../Common_File/new_responsive_helper.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Image.asset(
              'assets/images/MobileImage (1).jpg',
              width: responsive.width(350),
              height: responsive.height(350),
              fit: BoxFit.cover,
            ),

            SizedBox(height: responsive.height(40)),


            SizedBox(
              width: responsive.width(200),

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: responsive.getPadding(all: 12),
                ),
                onPressed: () {
                  Share.share('Check out this amazing app: https://example.com');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Share App",
                      style: TextStyle(
                        fontSize: responsive.fontSize(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: responsive.width(8)),
                    Icon(
                      Icons.share,
                      size: responsive.width(22),
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
}
