
import 'package:a_special_clock/widgets/earth_moon.dart';
import 'package:a_special_clock/widgets/shadow_earth_moon.dart';
import 'package:flutter/material.dart';

class SunEarth extends StatefulWidget {
  final double radius;
  final double parentRadius;
  final double angle;
  final Color color;
  final Color shadowColor;
  final DateTime currentDt;
  final DateTime endDt;

  SunEarth(
      {required this.radius,
      required this.parentRadius,
      required this.angle,
      required this.color,
      required this.shadowColor,
      required this.currentDt,
      required this.endDt});

  @override
  _SunEarthState createState() => _SunEarthState();
}

class _SunEarthState extends State<SunEarth> {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // raio
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
            ),
            // terra
            Positioned(
              top: 5,
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: EarthMoon(
                    childRadius: 4,
                    parentRadius: widget.radius,
                    color: widget.color,
                    shadowColor: widget.shadowColor,
                    angle:
                    (widget.currentDt.minute + widget.currentDt.hour * 60) /
                        1440.0,
                    currentDt: widget.currentDt,
                  )),
            ),
            // sol
            Container(
              width: widget.parentRadius,
              height: widget.parentRadius,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFFFE5B4),
                    Color(0xFFFBCEB1),
                    Color(0xFFFF5F1F),
                  ],
                  stops: [0.0, 0.6, 1.0],
                  radius: 0.6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xAAF4BB44),
                    blurRadius: 40,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
            // orbita
            Container(
              width: 400 - 30 - widget.radius,
              height: 400 - 30 - widget.radius,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white54.withOpacity(0.1), width: 0.5)),
            ),
          ],
        ),
        Transform.rotate(
          angle: widget.angle,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 400,
                height: 400,
              ),
              // terra
              Positioned(
                top: 5,
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ShadowEarthMoon(
                      childRadius: 4,
                      parentRadius: widget.radius,
                      color: const Color(0xFF3C3E64),
                      shadowColor: const Color(0xFF13233D),
                      angle: (widget.endDt.minute + widget.endDt.hour * 60) / 1440.0,
                      currentDt: widget.endDt,
                    ),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
