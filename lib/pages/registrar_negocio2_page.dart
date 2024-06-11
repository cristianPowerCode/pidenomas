import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pidenomas/pages/registrar_negocio3_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
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
  State<RegistrarNegocio2Page> createState() => _RegistrarNegocio2PageState();
}

class _RegistrarNegocio2PageState extends State<RegistrarNegocio2Page> {
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
    print('''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password}''');
  }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-12.0422754,-77.057543); // Coordenadas de San Francisco

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: _center,
      zoom: 14.4746,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    kBrandPrimaryColor2,
                    kBrandPrimaryColor1,
                  ],
                ),
              ),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 26.0, 16.0, 16.0),
                    // Añade padding para respetar el espacio del leading
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Colors.white,
                    ),
                  )),
            ),
            Container(
              width: double.infinity,
              height: 400,
              child: Stack(
                children: [
                  // Fondo gris
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    // color: Colors.grey,
                    child: GoogleMap(
                      mapType: MapType.terrain,
                      zoomControlsEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: _kGooglePlex,
                      markers: {
                        Marker(
                          markerId: MarkerId("_currentLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: _center,
                        ),
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            // Ancho del contenedor
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            // Espaciado horizontal
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Buscar...',
                                prefixIcon: Icon(Icons.search),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: kBrandPrimaryColor1,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        // Acción al presionar el botón
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Colors.blue.withOpacity(0.5), // Color del círculo
                        ),
                        padding: EdgeInsets.all(8),
                        // Espaciado para el icono dentro del círculo
                        child: Icon(Icons.location_searching,
                            color: Colors.white,
                            size: 30), // Icono dentro del círculo
                      ),
                    ),
                  ),
                ],
              ),
            ),
            divider30(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Direccion",
                    style: TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                  ),
                  InputTextFieldWidget(
                    hintText: "Latitud",
                    icon: Icons.location_on,
                    textInputType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
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
                    textInputType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
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
          ],
        ),
      ),
    );
  }
}
