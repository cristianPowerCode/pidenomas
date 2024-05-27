import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../general/colors.dart';

class InputTextFieldNameWidget extends StatelessWidget {
  String hintText;
  TextInputType? textInputType;
  TextEditingController controller;

  RegExp numberRegex = RegExp(r'[0-9]');

  InputTextFieldNameWidget({
    required this.hintText,
    this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        controller: controller,
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
              color: kErrorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(color: kErrorColor),
        ),
        validator: (String? value) {
          if (value!.isEmpty) return "El campo es obligatorio"; //isEmpty = esVacio
          if (!numberRegex.hasMatch(value)) {
            return 'Debe ingresar un correo válido';
          }
          return null;
        },
      ),
    );
  }
}
