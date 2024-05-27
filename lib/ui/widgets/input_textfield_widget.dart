import 'package:flutter/material.dart';
import '../general/colors.dart';

class InputTextFieldWidget extends StatelessWidget {
  String hintText;
  Function(String?)? validator;
  int? maxLength;
  TextInputType? textInputType;
  TextEditingController controller;
  IconData icon;
  Function()? onTap;
  Function(String?)? onSaved;

  RegExp? nameRegex = RegExp(r'^[A-Za-zÑñ\s]+(?<!\s)$');

  InputTextFieldWidget({
    required this.hintText,
    this.maxLength = 50,
    this.textInputType,
    required this.controller,
    required this.icon,
    this.onTap,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        cursorColor: kBrandPrimaryColor1,

        controller: controller,
        onSaved: onSaved,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        // inputFormatters: maxLength != null
        //     ? [
        //         FilteringTextInputFormatter(nameRegex, allow: true),
        //       ]
        //     : [],
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Color(0xffB1B1B1)),
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
        onTap: onTap,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            // Validación si el campo está vacío
            return "El campo es obligatorio";
          }
          if (validator != null) {
            // Validación adicional si se proporciona una función de validación personalizada
            return validator!(value);
          }
          return null;
        },
      ),
    );
  }
}
