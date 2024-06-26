import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/general/constant_responsive.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        screenWidth > ResponsiveConfig.widthResponsive ? buildRowLayout(context) : buildColumnLayout(context),
        divider20(),
        const Text(
          "Nro del documento de identidad",
          style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
        ),
        InputTextFieldWidget(
          icon: Icons.credit_card_sharp,
          isEnabled: selectedOption == null ? false : true,
          hintText: selectedOption == null
              ? 'Seleccione su tipo de documento'
              : (selectedOption == 1 ? 'DNI' : 'Carnet de Extranjería'),
          controller: widget.controller,
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: selectedOption == 1 ? 8 : 9,
          optionRegex: [
            (RegExp(r'^\d+$'), "Ingrese solo números"),
          ],
          validator: (value) {
            if (selectedOption == null) {
              return 'Por favor seleccione el tipo de su documento';
            }
            if (selectedOption == 1 && (value!.length != 8)) {
              return 'Ingrese 8 dígitos';
            } else if (selectedOption == 2 && (value!.length != 9)) {
              return 'Ingrese 9 dígitos';
            }
            return null;
          },
        ),
      ],
    );
  }
  Widget buildRowLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
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
          ],
        ),
        SizedBox(width: 20),
        Row(
          children: [
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
      ],
    );
  }
  Widget buildColumnLayout(BuildContext context) {
    return Column(
      children: [
        Row(
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
          ],
        ),
        Row(
          children: [
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
      ],
    );
  }
}
