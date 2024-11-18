import 'package:flutter/material.dart';
class Myprofiledetails extends StatefulWidget {
  const Myprofiledetails({super.key});

  @override
  State<Myprofiledetails> createState() => _MyprofiledetailsState();
}

class _MyprofiledetailsState extends State<Myprofiledetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("My Profile Details",)),
    );
  }
}
