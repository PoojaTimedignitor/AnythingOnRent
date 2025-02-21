import 'package:flutter/material.dart';
import 'MyProfileOption.dart';
import 'MyProfileDetails.dart';

class ProfileBar extends StatefulWidget {
  final int initialIndex;
  ProfileBar({this.initialIndex = 0});

  @override
  _ProfileBarState createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void goToProfile() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  void goToServiceProfile() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  void goToProductProfile() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Details",
            style: TextStyle(
              fontFamily: "Montserrat-Medium",
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (_selectedIndex > 0) {
                setState(() {
                  _selectedIndex = 0;
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            ProfileOption(
              option: goToProfile,
              onServiceProfile: goToServiceProfile,
              onProductProfile: goToProductProfile,
            ),
            Myprofiledetails(option: goToProfile),

          ],
        ),
      ),
    );
  }
}
