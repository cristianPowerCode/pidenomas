import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../general/colors.dart';

class UnderLineInputTextFieldWidget extends StatelessWidget {
  String hintText;

  UnderLineInputTextFieldWidget({
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kBrandPrimaryColor1,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        alignLabelWithHint: false,
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: kBrandPrimaryColor1,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffB1B1B1)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: kBrandErrorColor,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: kBrandErrorColor),
      ),
    );
  }
}