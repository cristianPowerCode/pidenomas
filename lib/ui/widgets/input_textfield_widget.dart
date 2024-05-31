import 'package:flutter/material.dart';
import '../general/colors.dart';

class InputTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Function(String?)? validator;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController controller;
  final IconData icon;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final bool? isEnabled;
  final List<(RegExp, String)>? optionRegex;

  InputTextFieldWidget({
    this.hintText,
    this.labelText,
    this.maxLength,
    this.textInputType,
    required this.controller,
    required this.icon,
    this.onTap,
    this.onSaved,
    this.validator,
    this.isEnabled = true,
    this.optionRegex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        cursorColor: kBrandPrimaryColor1,
        enabled: isEnabled,
        controller: controller,
        onSaved: onSaved,
        keyboardType: textInputType,
        maxLength: maxLength,
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Color(0xffB1B1B1)),
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(0xffB1B1B1),
          ),
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
        onTap: onTap,
        validator: (String? value) {
          if (validator != null) {
            // Validación adicional si se proporciona una función de validación personalizada
            return validator!(value);
          } else if (value == null || value.isEmpty) {
            // Validación si el campo está vacío
            return "El campo es obligatorio";
          } else if (optionRegex != null) {
            for (var option in optionRegex!) {
              if (!option.$1.hasMatch(value)) {
                return option.$2;
              }
            }
          }
          return null; // Indica que no hay errores de validación
        },
      ),
    );
  }
}
