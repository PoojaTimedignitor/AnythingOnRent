/*
import 'package:flutter/material.dart';

import '../Common_File/new_responsive_helper.dart';

class RatingBasedView extends StatefulWidget {
  const RatingBasedView({super.key});

  @override
  State<RatingBasedView> createState() => _RatingBasedViewState();
}

class _RatingBasedViewState extends State<RatingBasedView> {
  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    return SafeArea(
      child: Scaffold(
            body: Container(
              color: Colors.pink[900],
              margin: responsive.getMargin(all: 0).copyWith(top: responsive.isMobile ? 2 : 4 , bottom: responsive.isMobile ? 2 : 4 , left: responsive.isMobile ? 20 : 4 , ),
              padding: responsive.getPadding(all: 0).copyWith(left: responsive.isMobile ? 10 : 30, top: responsive.isMobile ? 3 : 5),              /// new add responsive padding
              height: responsive.height(responsive.isMobile ? 200 : responsive.isTablet ? 55 : 70),                          /// new change
              width: responsive.width(responsive.isMobile ? 320 : responsive.isTablet ? 370 : 420),                      /// new change
           //   child: ,
            ),
      ),
    );
  }
}
*/



/// Drawer

/*
import 'dart:ui';
import 'package:flutter/material.dart';
import '../Common_File/new_responsive_helper.dart';
import '../SideBar/My Collection.dart';
import '../SideBar/My Transaction History.dart';
import '../SideBar/MyFevorites.dart';

class CustomDrawer extends StatefulWidget {
 // final ResponsiveHelper responsive;

  const CustomDrawer({Key? key,}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int selectedIndex = -1;

  void onItemTap(int index, Widget page) {
    setState(() => selectedIndex = index);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);


    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          buildMenuItem(
            index: 0,
            icon: Image.asset('assets/images/myads.png',
                height: responsive.height(responsive.isMobile ? 25 : 30)),
            title: "Manage Posts",
            page: const MyCollection(),
          ),
          buildMenuItem(
            index: 1,
            icon: const Icon(Icons.drafts, size: 22),
            title: "Drafts",
            page: const AddToCart(),
          ),
          buildMenuItem(
            index: 2,
            icon: const Icon(Icons.bookmark_border, size: 22),
            title: "My Favorites",
            page: const AddToCart(),
          ),
          buildMenuItem(
            index: 3,
            icon: Image.asset('assets/images/transaction.png',
                height: responsive.height(responsive.isMobile ? 29 : 35)),
            title: "Contacted History",
            page: const MyTransaction(),
          ),
          buildMenuItem(
            index: 4,
            icon: Image.asset('assets/images/transaction.png',
                height: responsive.height(responsive.isMobile ? 29 : 35)),
            title: "Users Contacted",
            page: const MyTransaction(),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required int index,
    required Widget icon,
    required String title,
    required Widget page,
  }) {
    bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemTap(index, page),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: isSelected
                ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: ListTile(
              leading: icon,
              title: Text(
                title,
                style: TextStyle(
                  color: const Color(0xff2B2B2B),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
            ),
          ),
        ),
      ),
    );
  }
}
*/




import 'dart:ui';
import 'package:flutter/material.dart';
import '../Common_File/new_responsive_helper.dart';
import '../SideBar/My Collection.dart';
import '../SideBar/My Transaction History.dart';
import '../SideBar/MyFevorites.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int selectedIndex = -1;

  void onItemTap(int index, Widget page) {
    setState(() => selectedIndex = index);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          buildMenuItem(
            index: 0,
            icon: Image.asset(
              'assets/images/myads.png',
              height: responsive.height(responsive.isMobile ? 25 : 30),
            ),
            title: "Manage Posts",
            page: const MyCollection(),
          ),
          buildMenuItem(
            index: 1,
            icon: const Icon(Icons.drafts, size: 22),
            title: "Drafts",
            page: const AddToCart(),
          ),
          buildMenuItem(
            index: 2,
            icon: const Icon(Icons.bookmark_border, size: 22),
            title: "My Favorites",
            page: const AddToCart(),
          ),
          buildMenuItem(
            index: 3,
            icon: Image.asset(
              'assets/images/transaction.png',
              height: responsive.height(responsive.isMobile ? 29 : 35),
            ),
            title: "Contacted History",
            page: const MyTransaction(),
          ),
          buildMenuItem(
            index: 4,
            icon: Image.asset(
              'assets/images/transaction.png',
              height: responsive.height(responsive.isMobile ? 29 : 35),
            ),
            title: "Users Contacted",
            page: const MyTransaction(),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required int index,
    required Widget icon,
    required String title,
    required Widget page,
  }) {
    bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemTap(index, page),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: isSelected
                ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: ListTile(
              leading: icon,
              title: Text(
                title,
                style: const TextStyle(
                  color: Color(0xff2B2B2B),
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
            ),
          ),
        ),
      ),
    );
  }
}
