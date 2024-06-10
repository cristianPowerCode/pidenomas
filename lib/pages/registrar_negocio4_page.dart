import 'package:flutter/material.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/photo_widget.dart';

import '../ui/general/colors.dart';
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
  State<RegistrarNegocio4Page> createState() => _RegistrarNegocio4PageState();
}

class _RegistrarNegocio4PageState extends State<RegistrarNegocio4Page> {
  @override
  void initState() {
    super.initState();
    print("PAGINA 4");
    print('''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password},
lat: ${widget.lat}, lng: ${widget.lng}, direccion: ${widget.direccion},
detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaUbicacion},
tipo de inmueble: ${widget.typeOfHousing}, category: ${widget.categoria}''');
  }

  String? fachadaUrl;
  String? docAnversoUrl;
  String? docReversoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackGroundWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrincipalText(string: "Ya falta poco..."),
              divider40(),
              PrincipalText(string: "Suba una foto de la fachada del negocio"),
              PhotoWidget(
                tipo: 1,
                icon: Icons.storefront,
                docIdentidad: widget.documentoIdentidad,
                onPressedTakePhoto: (){},
                onPressedUploadPhoto: (){},
              ),
              divider40(),
              PrincipalText(
                  string: "Suba una foto de su documento de indentidad"),
              Text("La foto debe ser lo más nitido posible para contrastar sus datos",style: TextStyle(color: Colors.black45,fontStyle: FontStyle.italic),textAlign: TextAlign.justify,),
              divider12(),
              PhotoWidget(
                tipo: 2,
                assetDefault: "assets/images/docIdentidadAnverso.jpg",
                docIdentidad: widget.documentoIdentidad,
                onPressedUploadPhoto: (){},
                onPressedTakePhoto: (){},
              ),
              divider40(),
              PrincipalText(
                  string:
                      "Suba una foto del reverso de su documento de indentidad"),
              Text("Esta foto tambien debe ser lo más nitido posible para contrastar sus datos",style: TextStyle(color: Colors.black45,fontStyle: FontStyle.italic),textAlign: TextAlign.justify,),
              divider12(),
              PhotoWidget(
                tipo: 2,
                assetDefault: "assets/images/docIdentidadReverso.jpg",
                docIdentidad: widget.documentoIdentidad,
                onPressedTakePhoto: (){},
                onPressedUploadPhoto: (){},
              ),
              divider30(),
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
              divider40(),
              divider30(),
            ],
          ),
        ),
      ),
    );
  }
}
