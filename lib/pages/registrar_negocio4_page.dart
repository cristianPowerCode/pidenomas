import 'package:flutter/material.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

import '../ui/widgets/button_widget.dart';
import 'registrar_negocio5_page.dart';

class RegistrarNegocio4Page extends StatefulWidget {
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
  String referenciaUbicacion;
  String typeOfHousing;
  String categoria;

  RegistrarNegocio4Page({
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
    required this.referenciaUbicacion,
    required this.typeOfHousing,
    required this.categoria,
  });

  @override
  State<RegistrarNegocio4Page> createState() =>
      _RegistrarNegocio4PageState();
}

class _RegistrarNegocio4PageState
    extends State<RegistrarNegocio4Page> {

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
detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaUbicacion},
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
                      builder: (context) => RegistrarNegocio5Page(
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
                        referenciaUbicacion: widget.referenciaUbicacion,
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
