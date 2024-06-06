import 'package:flutter/material.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

import '../ui/widgets/button_widget.dart';
import 'registrar_duenho_de_negocio5_page.dart';

class RegistrarDuenhoDeNegocio4Page extends StatefulWidget {
  String nombre;
  String apellidos;
  String email;
  String celular;
  String tipoDocumento;
  String fechaDeNacimiento;
  String documentoIdentidad;
  String genero;
  String password;
  String lat;
  String lng;
  String direccion;
  String detalleDireccion;
  String referenciaDireccion;
  String typeOfHousing;
  String categoria;

  RegistrarDuenhoDeNegocio4Page({
    required this.nombre,
    required this.apellidos,
    required this.fechaDeNacimiento,
    required this.celular,
    required this.tipoDocumento,
    required this.documentoIdentidad,
    required this.genero,
    required this.email,
    required this.password,
    required this.lat,
    required this.lng,
    required this.direccion,
    required this.detalleDireccion,
    required this.referenciaDireccion,
    required this.typeOfHousing,
    required this.categoria,
  });

  @override
  State<RegistrarDuenhoDeNegocio4Page> createState() =>
      _RegistrarDuenhoDeNegocio4PageState();
}

class _RegistrarDuenhoDeNegocio4PageState
    extends State<RegistrarDuenhoDeNegocio4Page> {

  @override
  void initState() {
    super.initState();
    print("PAGINA 4");
    print(
        '''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password},
lat: ${widget.lat}, lng: ${widget.lng}, direccion: ${widget.direccion},
detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaDireccion},
tipo de inmueble: ${widget.typeOfHousing}, category: ${widget.categoria}''');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          divider40(),
          divider30(),
          divider20(),
          Center(
            child: ButtonWidget(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrarDuenhoDeNegocio5Page(
                        nombre: widget.nombre,
                        apellidos: widget.apellidos,
                        fechaDeNacimiento: widget.fechaDeNacimiento,
                        celular: widget.celular,
                        tipoDocumento: widget.tipoDocumento,
                        documentoIdentidad: widget.documentoIdentidad,
                        genero: widget.genero,
                        email: widget.email,
                        password: widget.password,
                        lat: widget.lat,
                        lng: widget.lng,
                        direccion: widget.direccion,
                        detalleDireccion: widget.detalleDireccion,
                        referenciaDireccion: widget.referenciaDireccion,
                        typeOfHousing: widget.typeOfHousing,
                        categoria: widget.categoria,
                      ),
                    ));
              },
              text: "Ir a Registro 5",
            ),
          ),
        ],
      ),
    );
  }
}
