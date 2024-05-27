import 'package:flutter/material.dart';
import '../general/colors.dart';

class InputTextFieldPasswordWidget extends StatefulWidget {

  TextEditingController? controller;
  Function(String?)? onSaved;

  InputTextFieldPasswordWidget({
    this.controller,
    this.onSaved,
  });

  @override
  State<InputTextFieldPasswordWidget> createState() => _InputTextFieldPasswordWidgetState();
}

class _InputTextFieldPasswordWidgetState extends State<InputTextFieldPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        controller: widget.controller,
        onSaved: widget.onSaved,
        obscureText: isInvisible,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.lock, color: Color(0xffB1B1B1)),
          filled: true,
          hintText: "Contraseña",
          hintStyle: TextStyle(
            color: Color(0xffB1B1B1),
            fontSize: 14.0,
          ),
          counterText: "",
          suffixIcon: IconButton(
            onPressed: () {
              setState((){
                isInvisible = !isInvisible;
              });
            },
            icon: Icon(
              isInvisible ? Icons.visibility : Icons.visibility_off,
              color: Color(0xffB1B1B1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide(
              color: kBrandPrimaryColor1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(
                color: Color(0xffB1B1B1)
            ),
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
        validator: (String? value){
          if(value!.isEmpty) return "El campo es obligatorio";
          return null;
        },
      ),
    );
  }
}
