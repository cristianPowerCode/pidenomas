import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/pages/registrar_negocio3_page.dart';
import 'package:pidenomas/ui/widgets/button_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

import '../ui/widgets/grid_type_of_house_widget.dart';
import '../ui/widgets/input_textfield_widget.dart';

class RegistrarNegocio2Page extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String fechaDeNacimiento;
  final String celular;
  final String tipoDocumento;
  final String documentoIdentidad;
  final String genero;
  final String email;
  final String password;

  RegistrarNegocio2Page({
    required this.nombre,
    required this.apellidos,
    required this.fechaDeNacimiento,
    required this.celular,
    required this.tipoDocumento,
    required this.documentoIdentidad,
    required this.genero,
    required this.email,
    required this.password,
  });

  @override
  State<RegistrarNegocio2Page> createState() =>
      _RegistrarNegocio2PageState();
}

class _RegistrarNegocio2PageState
    extends State<RegistrarNegocio2Page> {
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _detalleDireccionController = TextEditingController();
  TextEditingController _referenciaUbicacionController =
      TextEditingController();

  int typeOfHousing = 0;

  void _handleSelectedIndex(int index) {
    setState(() {
      typeOfHousing = index;
    });
  }
  @override
  void initState() {
    super.initState();
    print("PAGINA 2");
    print(
        '''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password}''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              divider40(),
              divider30(),
              divider20(),
              const Text(
                "Direccion",
                style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
              ),
              InputTextFieldWidget(
                hintText: "Latitud",
                icon: Icons.location_on,
                textInputType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: _latController,
                maxLength: 12,
                optionRegex: [
                  (RegExp(r'^[0-9]*\.?[0-9]+$'), "Use el punto decimal"),
                  (RegExp(r'[0-9]'), "Ingresar solo números"),
                ],
              ),
              divider12(),
              InputTextFieldWidget(
                hintText: "Longitud",
                icon: Icons.location_on,
                textInputType:
                    TextInputType.numberWithOptions(decimal: true, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: _lngController,
                maxLength: 12,
                optionRegex: [
                  (RegExp(r'^[0-9]*\.?[0-9]+$'), "Use el punto decimal"),
                  (RegExp(r'[0-9]'), "Ingresar solo números"),
                ],
              ),
              divider12(),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 500.0,
                ),
                child: InputTextFieldWidget(
                  hintText: "Dirección del Negocio o Punto de Venta",
                  icon: Icons.location_on,
                  textInputType: TextInputType.text,
                  controller: _direccionController,
                  maxLength: 250,
                  minLines: 2,
                  maxLines: null,
                  count: 250,
                ),
              ),
              divider30(),
              const Text(
                "Detalle si es puerta calle o Interior",
                style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
              ),
              InputTextFieldWidget(
                hintText: "Puerta Calle/ Block B - Dpto 405/ Interior A",
                icon: (Icons.map_sharp),
                controller: _detalleDireccionController,
                maxLength: 250,
                minLines: 2,
                maxLines: null,
                count: 250,
              ),
              divider30(),
              const Text(
                "Referencia de su ubicacion",
                style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
              ),
              InputTextFieldWidget(
                hintText: "Ejm: A una cuadra de la Municipalidad de Lince",
                icon: Icons.maps_ugc,
                controller: _referenciaUbicacionController,
                maxLength: 250,
                minLines: 2,
                maxLines: null,
                count: 250,
              ),
              divider12(),
              const Text(
                "Tipo de Inmueble",
                style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
              ),
              GridTypeOfHousingWidget(
                options: {
                  Icons.house: "Casa",
                  Icons.local_cafe: "Oficina",
                  Icons.favorite: "Pareja",
                  Icons.add: "Otro",
                },
                onSelected: _handleSelectedIndex,
              ),
              divider30(),
              Center(
                child: ButtonWidget(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrarNegocio3Page(
                            nombre: widget.nombre,
                            apellidos: widget.apellidos,
                            fechaDeNacimiento: widget.fechaDeNacimiento,
                            celular: widget.celular,
                            tipoDocumento: widget.tipoDocumento,
                            documentoIdentidad: widget.documentoIdentidad,
                            genero: widget.genero,
                            email: widget.email,
                            password: widget.password,
                            lat: _latController.text,
                            lng: _lngController.text,
                            direccion: _direccionController.text,
                            detalleDireccion:
                            _detalleDireccionController.text,
                            referenciaUbicacion:
                            _referenciaUbicacionController.text,
                            typeOfHousing: typeOfHousing.toString(),
                          ),
                        ));
                  },
                  text: "Ir a Registro 3",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
