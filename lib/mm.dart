import 'dart:async';
import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final bool repeat;

  ShowUp({ required this.child,  required this.delay, required this.repeat});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: _animController,
    );

    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.35),
      end: Offset.zero,
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay ?? 0), () {
      if (mounted) {
        if (widget.repeat) {
          _animController.repeat(reverse: true); // Repeats with reverse effect
        } else {
          _animController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animController,
        child: FadeTransition(
          opacity: _animController,
          child: SlideTransition(
            position: _animOffset,
            child: Text(
              "Hello, Animated Text!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}