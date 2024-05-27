import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/input_textfield_widget.dart';

class DataBirthWidget extends StatefulWidget {
  final TextEditingController controller;

  const DataBirthWidget({
    required this.controller,
  });

  @override
  _DataBirthWidgetState createState() => _DataBirthWidgetState();
}

class _DataBirthWidgetState extends State<DataBirthWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Inicializar _selectedDate con la fecha actual menos 18 años
    DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year - 18, now.month, now.day);
  }

  void _openDatePicker(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime maxAllowedDate = DateTime(now.year - 18, now.month, now.day);
    DateTime minAllowedDate = DateTime(now.year - 120, now.month, now.day);

    // Asegurarse de que la fecha inicial no sea después de la fecha máxima permitida
    if (_selectedDate.isAfter(maxAllowedDate)) {
      _selectedDate = maxAllowedDate;
    }

    BottomPicker.date(
      pickerTitle: const Text("Selecciona tu fecha de nacimiento"),
      dateOrder: DatePickerDateOrder.ymd,
      initialDateTime: _selectedDate,
      pickerTextStyle: const TextStyle(
        color: kBrandPrimaryColor1,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      onChange: (date) {
        // Actualizar _selectedDate en tiempo real cuando cambia la fecha
        setState(() {
          _selectedDate = date!;
        });
      },
      onSubmit: (date) {
        // Usar la fecha seleccionada o la fecha por defecto
        setState(() {
          _selectedDate = date!;
        });
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);
        widget.controller.text = formattedDate;
      },
      bottomPickerTheme: BottomPickerTheme.heavyRain,
      buttonStyle: BoxDecoration(
        color: kBrandSecundaryColor1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: kBrandSecundaryColor2,
        ),
      ),
      buttonWidth: 200,
      buttonContent: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'SELECCIONAR',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      minDateTime: minAllowedDate,
      maxDateTime: maxAllowedDate,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return InputTextFieldWidget(
      hintText: "Selecciona tu fecha de nacimiento",
      controller: widget.controller,
      icon: Icons.calendar_month,
      textInputType: TextInputType.none,
      onTap: () {
        _openDatePicker(context);
      },
    );
  }
}
