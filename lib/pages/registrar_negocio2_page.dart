import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pidenomas/pages/registrar_negocio1_page.dart';
import 'package:pidenomas/pages/registrar_negocio3_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/button_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

import '../ui/widgets/grid_type_of_house_widget.dart';
import '../ui/widgets/icon_form_button_widget.dart';
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

  final _formKey = GlobalKey<FormState>();
  int typeOfHousing = 0;

  void _handleSelectedIndex(int index) {
    setState(() {
      typeOfHousing = index;
    });
  }

  String _locationMessage = "";
  late GoogleMapController mapController;
  static const LatLng initialPosition =
      LatLng(-12.0630149, -77.0296179); // Lima
  LatLng currentPosition = initialPosition;
  String address = ''; // Variable para almacenar la dirección

  @override
  void initState() {
    super.initState();
    print("PAGINA 2");
    print('''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password}''');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    currentPosition = position.target;
    _getAddressFromLatLng(); // Obtener la dirección al mover el mapa
    setState(() {}); // Actualiza el estado para reflejar el movimiento del mapa
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          _direccionController.text = placemark.street ?? '...';
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El servicio de ubicación está deshabilitado.")),
      );
      return;
    }

    // Verificar permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Los permisos de ubicación están denegados.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Los permisos de ubicación están denegados permanentemente.")),
      );
      return;
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
      _latController.text = position.latitude.toString();
      _lngController.text = position.longitude.toString();
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentPosition, zoom: 16.4746),
        ),
      );
    });
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: currentPosition,
      zoom: 15.7746,
      bearing: 0,
      tilt: 0,
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    // Fondo gris
                    GoogleMap(
                      mapType: MapType.terrain,
                      zoomControlsEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: _kGooglePlex,
                      onCameraMove: _onCameraMove,
                    ),
                    Center(
                      child: Icon(
                        Icons.location_pin,
                        color: kBrandPrimaryColor1,
                        size: 40,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pop(); // Esto hace que vuelvas a la pantalla anterior
                            },
                            child: Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(2,2),
                                    ),
                                  ]),
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width-(36*2)-20,
                            // Ancho del contenedor
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            // Espaciado horizontal
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Buscar...',
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
                          GestureDetector(
                            onTap: () {
                              // Acción al presionar el botón
                              _getCurrentLocation();
                            },
                            child: Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(2,2),
                                    ),
                                  ]),
                              child: Icon(Icons.location_searching),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                          ],
                        ),
                        divider12(),
                        const Text(
                          "Dirección",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
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
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                        ),
                        InputTextFieldWidget(
                          hintText:
                              "Puerta Calle/ Block B - Dpto 405/ Interior A",
                          icon: (Icons.map_sharp),
                          controller: _detalleDireccionController,
                          maxLength: 250,
                          minLines: 2,
                          maxLines: null,
                          count: 250,
                        ),
                        divider30(),
                        const Text(
                          "Referencia de su ubicación",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                        ),
                        InputTextFieldWidget(
                          hintText:
                              "Ejm: A una cuadra de la Municipalidad de Lince",
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
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconFormButtonWidget(
                              icon: Icon(FontAwesomeIcons.arrowLeft),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegistrarNegocio1Page(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 20.0),
                            IconFormButtonWidget(
                              icon: Icon(FontAwesomeIcons.arrowRight),
                              onPressed: () {
                                final formState = _formKey.currentState;
                                if (formState != null && formState.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrarNegocio3Page(
                                          nombre: widget.nombre,
                                          apellidos: widget.apellidos,
                                          fechaDeNacimiento:
                                              widget.fechaDeNacimiento,
                                          celular: widget.celular,
                                          tipoDocumento: widget.tipoDocumento,
                                          documentoIdentidad:
                                              widget.documentoIdentidad,
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
                                }
                              },
                            ),
                          ],
                        ),
                        divider40(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
