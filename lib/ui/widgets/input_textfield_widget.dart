import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../general/colors.dart';

class InputTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String? hintText;
  final String? labelText;
  final Function(String?)? validator;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final int? count;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final bool? isEnabled;
  final List<(RegExp, String)>? optionRegex;

  InputTextFieldWidget({
    this.hintText,
    this.labelText,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.count,
    this.textInputType,
    this.inputFormatters,
    required this.controller,
    required this.icon,
    this.onTap,
    this.onSaved,
    this.validator,
    this.isEnabled = true,
    this.optionRegex,
  });

  @override
  State<InputTextFieldWidget> createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: TextFormField(
        enabled: widget.isEnabled,
        // activa/desactiva el ingreso de texto
        controller: widget.controller,
        keyboardType: widget.textInputType,
        //tipo de teclado
        inputFormatters: widget.inputFormatters,
        maxLength: widget.maxLength,
        //tamaño maximo del input
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(widget.icon, color: Color(0xffB1B1B1)),
          filled: true,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Color(0xffB1B1B1),
          ),
          hintText: widget.hintText,
          hintMaxLines: widget.minLines ?? 1,
          //Texto de entrada color gris
          hintStyle: TextStyle(
            color: Color(0xffB1B1B1),
            fontSize: 14.0,
          ),
          counterText: widget.count == null
              ? ""
              : "${widget.controller.text.length}/${widget.count!}",
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
            borderSide: BorderSide(
              color: kBrandErrorColor,
            ),
          ),
          errorStyle: TextStyle(color: kBrandErrorColor),
        ),
        onTap: widget.onTap,
        onChanged: (text) {
          setState(() {
            widget.controller.value = TextEditingValue(
              text: text,
              selection: TextSelection.collapsed(offset: text.length),
            );
          });
        },
        validator: (String? value) {
          // Validación si el campo está vacío
          if (value == null || value.isEmpty) {
            return "El campo es obligatorio";
          }

          // Validación personalizada
          if (widget.validator != null) {
            return widget.validator!(value);
          }

          // Validación con expresiones regulares
          if (widget.optionRegex != null) {
            for (var option in widget.optionRegex!) {
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
