import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';

class IconFormButtonWidget extends StatelessWidget {
  Icon icon;
  VoidCallback onPressed;
  final bool isFormComplete;

  IconFormButtonWidget({
    required this.icon,
    required this.onPressed,
    this.isFormComplete = true,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = isFormComplete ? kBrandPrimaryColor1: Colors.grey;
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      color: iconColor,
      iconSize: 40.0,
    );
  }
}
