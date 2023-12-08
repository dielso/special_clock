import 'dart:math';

import 'package:flutter/material.dart';

class ShadowEarthMoon extends StatefulWidget {
  final double childRadius;
  final double parentRadius;
  final double angle;
  final DateTime currentDt;
  final Color color;
  final Color shadowColor;

  ShadowEarthMoon({required this.childRadius,
    required this.parentRadius,
    required this.angle,
    required this.color,
    required this.shadowColor,
    required this.currentDt});

  @override
  _ShadowEarthMoonState createState() => _ShadowEarthMoonState();
}

class _ShadowEarthMoonState extends State<ShadowEarthMoon> {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.angle * 2 * pi,
      child: Stack(
        alignment: Alignment.center,
        children: [
      Transform.rotate(
      angle: -widget.angle * 2 * pi,
        child: Container(
            width: widget.parentRadius,
            height: widget.parentRadius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 0.9,
                  colors: [widget.color, widget.shadowColor]),
            )),
      ),
      Positioned(
        top: 0,
        child: Container(
          width: widget.childRadius,
          height: widget.childRadius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color,
            gradient: RadialGradient(
                center: Alignment.bottomCenter,
                radius: 0.8,
                colors: [widget.color, widget.shadowColor]),
          ),
        ),
      )]
    ));
  }
}
