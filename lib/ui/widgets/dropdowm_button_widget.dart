import 'package:flutter/material.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

import '../general/colors.dart';

class GenderDropdownWidget extends StatefulWidget {
  TextEditingController controller;
  GenderDropdownWidget({
    required this.controller,
  });

  @override
  State<GenderDropdownWidget> createState() => _GenderDropdownWidgetState();
}

class _GenderDropdownWidgetState extends State<GenderDropdownWidget> {
  int? selectedGenderIndex; // Inicialmente no se selecciona ninguna opción

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      child: DropdownButtonFormField<int>(
        value: selectedGenderIndex, // Valor inicial
        items: <DropdownMenuItem<int>>[
          DropdownMenuItem<int>(
            value: 1,
            child: Text('Masculino'),
          ),
          DropdownMenuItem<int>(
            value: 2,
            child: Text('Femenino'),
          ),
          DropdownMenuItem<int>(
            value: 3,
            child: Text('Sin Especificar'),
          ),
        ],
        decoration: InputDecoration(
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.accessibility, color: Color(0xffB1B1B1)),
          filled: true,
          labelText: 'Seleccione su género', // HintText que se muestra inicialmente
          labelStyle: TextStyle(color: Colors.grey),
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
        onChanged: (int? value) {
          setState(() {
            selectedGenderIndex = value; // Actualiza la opción seleccionada
            widget.controller.text = selectedGenderIndex?.toString() ?? '3'; // Actualiza el valor del controlador
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Por favor, seleccione su género';
          }
          return null;
        },
      ),
    );
  }
}
