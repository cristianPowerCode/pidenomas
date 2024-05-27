import 'package:flutter/material.dart';
import '../general/colors.dart';

class AppBarDegradeWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  AppBarDegradeWidget({
    required this.text,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kBrandPrimaryColor2, kBrandPrimaryColor1],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: AppBar(
        title: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
