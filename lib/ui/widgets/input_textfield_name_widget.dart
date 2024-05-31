import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../general/colors.dart';

class InputTextFieldNameWidget extends StatelessWidget {
  String hintText;
  int? maxLength;
  TextInputType? textInputType;
  TextEditingController controller;
  Function(String?)? onSaved;

  RegExp nameRegex = RegExp(r'^[A-Za-zÑñáéíóúÁÉÍÓÚ\s]+(?<!\s)$');
  RegExp emptySpaceRegex = RegExp(r'\s+$');



  InputTextFieldNameWidget({
    required this.hintText,
    this.maxLength = 50,
    this.textInputType,
    required this.controller,
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
        // inputFormatters: maxLength != null
        //     ? [
        //         FilteringTextInputFormatter(nameRegex, allow: true),
        //       ]
        //     : [],
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
          if (emptySpaceRegex.hasMatch(value)) {
            if(!nameRegex.hasMatch(value)){
              return 'hay un espacio en blanco al final';
            }
            return 'no se admiten números';
          }
          return null;
        },
      ),
    );
  }
}
