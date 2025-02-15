import 'package:flutter/material.dart';

import 'Common_File/ResponsiveUtil.dart';
class ChangeHome extends StatefulWidget {
  const ChangeHome({super.key});

  @override
  State<ChangeHome> createState() => _ChangeHomeState();
}

class _ChangeHomeState extends State<ChangeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                height: ResponsiveUtil.height(240),

               // height: 240,
                decoration: BoxDecoration(

                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffA5396D),
                      Color(0xffFE7F64),
                    ],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
