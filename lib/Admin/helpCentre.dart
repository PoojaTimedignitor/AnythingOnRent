import 'package:anything/Admin/supportPage.dart';
import 'package:flutter/material.dart';
import '../Common_File/new_responsive_helper.dart';
import 'ContactUs.dart';
import 'FAQ.dart';

class HelpCenterScreen extends StatefulWidget {
  final int initialIndex;
  HelpCenterScreen({this.initialIndex = 0});

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages.addAll([
      Supportpage(
        onNeedHelpTap: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      FAQ(
        onContactUsTap: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
      ContactUsPage(
        onContactQuationTap: () {
          setState(() {
            _selectedIndex = 3;
          });
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help Center",
          style: TextStyle(
            fontFamily: "Montserrat-Medium",
            fontSize: responsive.fontSize(16),                  /// new changes
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: responsive.width(18)), // Responsive icon size
          onPressed: () {
            if (_selectedIndex == 3) {
              setState(() {
                _selectedIndex = 2;
              });
            } else {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            }
          },
        ),
      ),
      body: Padding(
        padding: responsive.getPadding(all: responsive.isMobile ? 10 : 20), // Responsive padding
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: _pages[_selectedIndex],
        ),
      ),
    );
  }
}