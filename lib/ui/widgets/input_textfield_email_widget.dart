import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../general/colors.dart';

class InputTextFieldEmailWidget extends StatelessWidget {
  String hintText;
  TextInputType? textInputType;
  TextEditingController? controller;
  Function(String?)? onSaved;

  RegExp emailRegex = RegExp(r'[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,5}');

  InputTextFieldEmailWidget({
    required this.hintText,
    this.textInputType,
    this.controller,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        controller: controller,
        onSaved: onSaved,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.person, color: Color(0xffB1B1B1)),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xffB1B1B1),
            fontSize: 14.0,
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(
              color: kBrandPrimaryColor1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Color(0xffB1B1B1)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(
              color: kBrandErrorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(color: kBrandErrorColor),
        ),
        validator: (String? value) {
          if (value!.isEmpty) return "El campo es obligatorio"; //isEmpty = esVacio
          if (!emailRegex.hasMatch(value)) {
            return 'Debe ingresar un correo válido';
          }
          return null;
        },
      ),
    );
  }
}
