import 'package:flutter/material.dart';
class Myfevorites extends StatefulWidget {
  const Myfevorites({super.key});

  @override
  State<Myfevorites> createState() => _MyfevoritesState();
}

class _MyfevoritesState extends State<Myfevorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("My Fevorites",)),
    );
  }
}
