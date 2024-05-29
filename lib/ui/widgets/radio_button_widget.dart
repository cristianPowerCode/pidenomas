import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/utils/constants.dart';

import 'input_textfield_widget.dart';

class RadioButtonWidget extends StatefulWidget {
  TextEditingController controller;
  Function(int) onOptionChanged;

  RadioButtonWidget({
    required this.controller,
    required this.onOptionChanged,
  });

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  int? selectedOption;

  @override
  Widget build(BuildContext context) {
    int maxLength = selectedOption == 1 ? 8 : 9;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Radio(
              value: 1,
              activeColor: kBrandPrimaryColor1,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value as int?;
                  widget.onOptionChanged(selectedOption!);
                });
              },
            ),
            Text('DNI'),
            SizedBox(width: 20),
            Radio(
              value: 2,
              activeColor: kBrandPrimaryColor1,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value as int?;
                  widget.onOptionChanged(selectedOption!);
                });
              },
            ),
            Text('Carnet de Extranjería'),
          ],
        ),
        divider20(),
        const Text(
          "Nro del documento de identidad",
          style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
        ),
        InputTextFieldWidget(
          icon: Icons.credit_card_sharp,
          hintText: selectedOption == null ? 'Seleccione su tipo de documento' : (selectedOption == 1 ? 'DNI' : 'Carnet de Extranjería'),
          controller: widget.controller,
          textInputType: TextInputType.number,
          maxLength: selectedOption == 1 ? 8 : 9,
          validator: (value) {
            if (selectedOption == null) {
              return {'Por favor seleccione una opción'};
            }
            if (selectedOption == 1 && (value == null || value.length != 8)) {
              return 'El DNI debe tener 8 dígitos';
            } else if (selectedOption == 2 &&
                (value == null || value.length != 9)) {
              return 'El Carnet de Extranjería debe tener 9 dígitos';
            }
            return null;
          },
        ),
      ],
    );
  }
}
