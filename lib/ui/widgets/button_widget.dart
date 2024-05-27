import 'package:flutter/material.dart';
import '../general/colors.dart';

class ButtonWidget extends StatelessWidget {
  final IconData? icon;
  final double? width;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final String text;

  ButtonWidget({
    this.icon,
    this.width,
    this.gradient = degradado1,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return icon == null ? Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    ):
    Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          icon: Icon(icon, color: Colors.white),
          label: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
