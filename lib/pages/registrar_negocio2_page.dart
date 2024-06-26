import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:pidenomas/pages/registrar_negocio1_page.dart';
import 'package:pidenomas/pages/registrar_negocio3_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/circular_loading_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/place_prediction_widget.dart';

import '../ui/widgets/grid_type_of_house_widget.dart';
import '../ui/widgets/icon_form_button_widget.dart';
import '../ui/widgets/input_textfield_widget.dart';
import '../utils/constants.dart';

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

  late GoogleMapController mapController;
  static const LatLng initialPosition =
      LatLng(-12.0630149, -77.0296179); // Lima
  LatLng currentPosition = initialPosition;
  String address = ''; // Variable para almacenar la dirección
  bool isLoading = false;
  TextEditingController _searchController =
      TextEditingController(); // Controlador para el campo de búsqueda

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
    print("PAGINA 2");
    print('''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password}''');
  }

  Future<void> _checkLocationPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    setState(() {
      isLoading = true;
    });

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("El servicio de ubicación está deshabilitado.")),
      );

      setState(() {
        currentPosition = initialPosition;
        isLoading = false;
      });
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
        setState(() {
          isLoading = false;
        });
        return;
      }
      // Aquí también debe actualizar isLoading en caso de que los permisos se otorguen después de estar denegados
      setState(() {
        isLoading = false;
      });
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Los permisos de ubicación están denegados permanentemente.")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    // Si llegamos aquí, los permisos están concedidos y el servicio de ubicación está habilitado
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Si el servicio de ubicación está deshabilitado después de otorgar permisos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Para una mejor experiencia, active la ubicación del dispositivo.")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
        _latController.text = position.latitude.toString();
        _lngController.text = position.longitude.toString();
        isLoading = false;
      });

      // Verifica si mapController está inicializado
      if (mapController != null) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: currentPosition, zoom: 16.4746),
          ),
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    currentPosition = position.target;
    // No actualizar la dirección aquí para evitar múltiples actualizaciones
  }

  void _onCameraIdle() {
    _getAddressFromLatLng(); // Obtener la dirección solo cuando la cámara deja de moverse
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = placemark.street ??
            '...'; // Usar operador de nulabilidad para manejar posibles valores nulos
        setState(() {
          _direccionController.text =
              address; // Asignar la dirección al controlador de texto
          _latController.text = currentPosition.latitude
              .toString(); // Asignar la latitud al controlador de texto
          _lngController.text = currentPosition.longitude
              .toString(); // Asignar la longitud al controlador de texto
        });
      }
    } catch (e) {
      print(e);
    }
  }

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
                child: !isLoading
                    ? SizedBox(
                        width: double.infinity,
                        height: size.height * 0.5,
                        child: Stack(
                          children: [
                            // Fondo gris
                            GoogleMap(
                              mapType: MapType.terrain,
                              zoomControlsEnabled: true,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: _kGooglePlex,
                              onCameraMove: _onCameraMove,
                              onCameraIdle: _onCameraIdle,
                            ),
                            Center(
                              child: Transform.translate(
                                offset: Offset(0, -32),
                                //El offset eleva 32 pixeles para que el icono de location esté al centro
                                child: _direccionController.text == ''
                                    ? Icon(
                                        Icons.location_pin,
                                        color: kBrandPrimaryColor1,
                                        size: 40,
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: kBrandPrimaryColor1,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1.0,
                                                      horizontal: 8.0),
                                              child: Text(
                                                _direccionController
                                                            .text.length >
                                                        25
                                                    ? _direccionController.text
                                                            .substring(0, 25) +
                                                        '...'
                                                    : _direccionController.text,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          divider12(),
                                          Icon(
                                            Icons.location_pin,
                                            color: kBrandPrimaryColor1,
                                            size: 40,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              offset: Offset(2, 2),
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
                                    width: size.width - 2 * (36 + 10),
                                    height: 40,
                                    // Ancho del contenedor menos
                                    // el ancho de los 2 iconos: 36 y el margin: 10
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    // Espaciado horizontal
                                    child: PlacePredictionWidget(
                                      textEditingController: _searchController,
                                      googleAPIKey: kPlaceApiKey,
                                      initialPosition: initialPosition,
                                      inputDecoration: InputDecoration(
                                        hintText: "Buscar...",
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                      countries: ["pe"],
                                      getPlaceDetailWithLatLng:
                                          (Prediction prediction) {
                                        double lat = double.parse(
                                            prediction.lat.toString());
                                        double lng = double.parse(
                                            prediction.lng.toString());
                                        setState(() {
                                          currentPosition = LatLng(lat, lng);
                                        });
                                        mapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: currentPosition,
                                                zoom: 16.0),
                                          ),
                                        );
                                      },
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
                                              offset: Offset(2, 2),
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
                      )
                    : CircularLoadingWidget()),
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
                          children: [],
                        ),
                        divider12(),
                        const Text(
                          "Dirección",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                        ),
                        divider12(),
                        IgnorePointer(
                          ignoring: true,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 500.0,
                            ),
                            child: TextFormField(
                              controller: _direccionController,
                              maxLength: 250,
                              minLines: 1,
                              maxLines: null,
                              style: TextStyle(color: Color(0xffB1B1B1), fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.location_on, color: Color(0xffB1B1B1)),
                                fillColor: Colors.white,
                                filled: true,
                                hintStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                                counterText: "${_direccionController.text.length}/250",
                                hintText: "Dirección del Negocio o Punto de Venta",

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(color: Color(0xffB1B1B1)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: const BorderSide(
                                    color: kErrorColor,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  borderSide: BorderSide(
                                    color: kErrorColor,
                                  ),
                                ),
                                errorStyle: TextStyle(color: kErrorColor),
                              ),
                            ),
                          ),
                        ),
                        divider12(),
                        const Text(
                          "Indica tu dirección con el siguiente formato",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: const Text(
                            "Nombre Avenida / #Número / Ciudad",
                            style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                        ),
                        InputTextFieldWidget(
                          hintText:
                              "Puerta Calle/ Block B - Dpto 405/ Interior A",
                          icon: (Icons.map_sharp),
                          controller: _detalleDireccionController,
                          textInputType: TextInputType.text,
                          maxLength: 250,
                          minLines: 1,
                          maxLines: null,
                          count: 250,
                        ),
                        divider12(),
                        const Text(
                          "Referencia de su ubicación",
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: const Text(
                            "Tu información detallada nos ayuda a encontrarte más rápido. ¡Cada detalle cuenta!",
                            style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                        ),
                        InputTextFieldWidget(
                          hintText:
                              "Ejm: A una cuadra de la Municipalidad de Lince",
                          icon: Icons.maps_ugc,
                          controller: _referenciaUbicacionController,
                          textInputType: TextInputType.text,
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
                            Icons.business: "Edificio",
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
                                    builder: (context) =>
                                        RegistrarNegocio1Page(),
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
                                              _referenciaUbicacionController
                                                  .text,
                                          typeOfHousing:
                                              typeOfHousing.toString(),
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
