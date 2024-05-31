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

  Future<void> _openDatePicker(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime maxAllowedDate = DateTime(now.year - 18, now.month, now.day);
    DateTime minAllowedDate = DateTime(now.year - 120, now.month, now.day);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: minAllowedDate,
      lastDate: maxAllowedDate,
      locale: const Locale('es', 'ES'), // Configurar la localización a español
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kBrandPrimaryColor1, // Color del encabezado
              onPrimary: Colors.white, // Color del texto del encabezado
              surface: Colors.white, // Color de fondo de la selección
              onSurface: Colors.black, // Color del texto del contenido
            ),
            dialogBackgroundColor: Colors.white, // Color de fondo del cuadro de diálogo
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // Color de los botones de aceptar y cancelar
            ),),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      String formattedDate = DateFormat('yyyy-MM-dd', 'es').format(pickedDate);
      widget.controller.text = formattedDate;
    }
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
