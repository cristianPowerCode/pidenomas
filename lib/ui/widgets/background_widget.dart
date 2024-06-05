import 'package:flutter/material.dart';
import 'dart:math';

class BackGroundWidget extends StatelessWidget {
  final Widget child;

  const BackGroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          const Positioned(
            top: -80,
            left: -140,
            child: GradientCircle(
              radius: 100.0,
              colors: [Color(0xff00B53E), Color(0xff40D891)],
            ),
          ),
          const Positioned(
            top: -50,
            left: -12,
            child: GradientCircle(
              radius: 50.0,
              colors: [Color(0xffFECC34), Color(0xffFFA800)],
            ),
          ),
          const Positioned(
            bottom: -50,
            right: 50,
            child: GradientCircle(
              radius: 50.0,
              colors: [Color(0xffFECC34), Color(0xffFFA800)],
            ),
          ),
          const Positioned(
            bottom: -80,
            right: -100,
            child: GradientCircle(
              radius: 100.0,
              colors: [Color(0xff00B53E), Color(0xff40D891)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90.0, right: 50.0, bottom: 40.0, left: 50.0),
            child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: size.height-140,
                  maxHeight: double.infinity,
                ),
                child: child),
          ),
        ],
      ),
    );
  }
}

class GradientCircle extends StatelessWidget {
  final double radius;
  final List<Color> colors;

  const GradientCircle({
    super.key,
    required this.radius,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            transform: const GradientRotation(pi / 4)),
      ),
    );
  }
}
