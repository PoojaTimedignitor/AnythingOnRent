import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:buttons_tabbar/buttons_tabbar.dart';


class PlaceTypeView extends StatefulWidget {
  const PlaceTypeView({super.key});

  @override
  State<PlaceTypeView> createState() => _PlaceTypeViewState();
}

class _PlaceTypeViewState extends State<PlaceTypeView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: 60,
                color: Colors.white,
                padding: EdgeInsets.only(left: 30, bottom: 20, right: 10),
                child: ButtonsTabBar(
                  backgroundColor: Colors.red,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),


                  tabs: [
                    Tab(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 0.5)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Overall')),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 0.5)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Level-1')),
                      ),
                    ),


                  ],
                ),
              ),
      
              Container(
                //child: Container(
                height: 200,
                //color: Colors.blue,
                child: TabBarView(
                  children: [
                    Text('One'),
                    Text('Two'),

                  ],
                ),
              ),
              //),
              //Container(),
            ],
          ),
        ),
      ),
    );

  }
}