import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import '../models/register_business_model.dart';
import '../models/register_client_model.dart';
import '../models/response_model.dart';
import '../services/api_service.dart';
import '../ui/general/type_messages.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/check_box1_widget.dart';
import '../ui/widgets/check_box2_widget.dart';
import '../ui/widgets/circular_loading_widget.dart';
import '../ui/widgets/grid_type_of_house_widget.dart';
import '../ui/widgets/icon_form_button_widget.dart';
import '../ui/widgets/input_textfield_widget.dart';
import '../utils/constants.dart';
import 'login_cliente_page.dart';
import 'registrar_cliente3_page.dart';
import 'registrar_cliente_4_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/general_widgets.dart';

class RegistrarCliente2Page extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String fechaDeNacimiento;
  final String celular;
  final String tipoDocumento;
  final String documentoIdentidad;
  final String genero;
  final String email;
  final String password;

  RegistrarCliente2Page({
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
  State<RegistrarCliente2Page> createState() => _RegistrarCliente2PageState();
}

class _RegistrarCliente2PageState extends State<RegistrarCliente2Page> {
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _detalleDireccionController = TextEditingController();
  TextEditingController _referenciaUbicacionController =
  TextEditingController();

  String agreeError = "";
  bool agreeTerms = false;
  bool agreeNotifications = false;
  bool isLoading = false;
  String uidForFirebase = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final APIService _apiService = APIService();

  final CollectionReference _clientsCollection =
  FirebaseFirestore.instance.collection('business_owner');

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

  RegisterClientModel _createClientModel() {
    return RegisterClientModel(
      uid: uidForFirebase,
      nombre: widget.nombre,
      apellidos: widget.apellidos,
      fechaDeNacimiento: DateTime.parse(widget.fechaDeNacimiento),
      celular: widget.celular,
      tipoDocumento: int.parse(widget.tipoDocumento),
      docIdentidad: widget.documentoIdentidad,
      genero: int.parse(widget.genero),
      email: widget.email,
      password: widget.password,
      isVerifiedEmail: false,
      agreeNotifications: false,
      lat: double.parse(_latController.text),
      lng: double.parse(_lngController.text),
      direccion: _direccionController.text,
      detalleDireccion: _detalleDireccionController.text,
      referenciaDireccion: _referenciaUbicacionController.text,
      tipoDeInmueble: typeOfHousing,
      fechaDeCreacion: DateTime.now(),
    );
  }

  Future<void> _guardarDatos() async {
    print("!!!!!!!!!!!!!!");
    print("GUARDANDO DATOS EN FIREBASE");
    RegisterClientModel businessOwnerModel = _createClientModel();

    try {
      await _clientsCollection
          .doc(uidForFirebase)
          .set(businessOwnerModel.toJson());
      print("RESULTADO DE REGISTRO");
      print(jsonEncode(businessOwnerModel.toJson()));
      print("Datos guardados en Firestore para UID: $uidForFirebase");
    } catch (e) {
      print("Error al guardar datos en Firestore: $e");
      mostrarSnackBar("Hubo un problema al guardar datos en Firestore: $e", 2);

      // Eliminar la cuenta en Firebase Authentication
      await _auth.currentUser?.delete();

      // Eliminar el documento en Firestore si se creó antes
      if (uidForFirebase.isNotEmpty) {
        await _clientsCollection.doc(uidForFirebase).delete();
      }

      // Establecer uidForFirebase en vacío
      uidForFirebase = "";

      throw Exception("Error al guardar datos en Firestore: $e");
    }
  }

  Future<void> _registrarNegocioToDB() async {
    print("Entró a la funcion _registerNegocioToDB()");
    if (uidForFirebase.isNotEmpty) {
      print("uid capturado desde Firebase: $uidForFirebase");
      print("el uid fue capturado con exito de Firebase");
      setState(() {
        isLoading = true;
      });
      try {
        print("Calling registerClienteToDB...");
        final ResponseModel response =
        await _apiService.registrarClienteToDB(_createClientModel());

        if (response.status == 200) {
          print("Negocio registrado exitosamente: ${response.message}");
          mostrarSnackBar(response.message, 2);
        } else {
          print("Error al registrar negocio: ${response.message}");
          mostrarSnackBar(
              "Hubo un problema al registrar en la BD: ${response.message}", 3);

          // Eliminar la cuenta en Firebase Authentication
          await _auth.currentUser?.delete();

          // Eliminar el documento en Firestore
          await _clientsCollection.doc(uidForFirebase).delete();
        }
      } catch (e) {
        // Manejar errores específicos del servidor
        String errorMessage = e.toString();
        print("Error en _registrarNegocioToDB(): $errorMessage");
        mostrarSnackBar(
            "Hubo un problema al registrar en la BD: $errorMessage", 3);

        // Eliminar la cuenta en Firebase Authentication
        await _auth.currentUser?.delete();

        // Eliminar el documento en Firestore
        await _clientsCollection.doc(uidForFirebase).delete();
      }
      setState(() {
        isLoading = false;
      });
    } else {
      mostrarSnackBar("Hubo problemas al registrar en Firebase", 3);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _registrarYGuardarDatos() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: widget.email,
          password: widget.password,
        );
        print('Correo registrado en Firebase con éxito.');

        if (userCredential.user != null) {
          User? user = userCredential.user;
          uidForFirebase = user!.uid;
          print("uid capturado: $uidForFirebase");

          // Enviar correo de verificación
          await user.sendEmailVerification();
          print("Email de verificacion enviado");

          // Guardar datos en Firestore y registrar en la base de datos
          print("GUARDANDO DATOS EN FIREBASE - Function _guardarDatos()");
          await _guardarDatos();
          print(
              "REGISTRANDO A LA BASE DE DATOS - Function _registroYGuardarDatos()");
          await _registrarNegocioToDB();
          // Mostrar AlertDialog para informar al usuario que verifique su correo
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Registro Exitoso"),
                content: Text(
                    "Se ha enviado un correo de verificación a ${user.email}. Por favor verifica tu correo antes de iniciar sesión."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Redirigir a la pantalla de login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginClientePage()),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        setState(() {
          isLoading =
          false; // Establece isLoading en false si ocurre un error durante el proceso
        });
        print('Error al registrar el negocio: $e');
        mostrarSnackBar("Error al registrar el negocio: $e", 3);
        // Si hubo un error, eliminar la cuenta en Firebase Authentication y el documento en Firestore
        await _auth.currentUser?.delete();
        await _clientsCollection.doc(uidForFirebase).delete();

        // Establecer uidForFirebase en vacío
        uidForFirebase = "";
      }
    } else {
      setState(() {
        isLoading = false;
      });
      mostrarSnackBar("No tiene el formulario validado", 2);
    }
  }

  void mostrarSnackBar(String message, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  void _onCheckbox1Changed(bool value) {
    setState(() {
      agreeTerms = value;
      if (agreeTerms) {
        agreeError = '';
      } else {
        agreeError = 'Este campo es obligatorio';
      }
    });
  }

  void _onCheckbox2Changed(bool value) {
    setState(() {
      agreeNotifications = value;
    });
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
      resizeToAvoidBottomInset: false,
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
                              child: GooglePlaceAutoCompleteTextField(
                                textEditingController: _searchController,
                                googleAPIKey: kPlaceApiKey,
                                inputDecoration: InputDecoration(
                                  hintText: "Buscar...",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                debounceTime: 400,
                                countries: ["pe"],
                                isLatLngRequired: true,
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

                                itemClick: (Prediction prediction) {
                                  _searchController.text = prediction
                                      .description ??
                                      "intente con otra direccion cercana";
                                  _searchController.selection =
                                      TextSelection.fromPosition(
                                          TextPosition(
                                              offset: prediction
                                                  .description
                                                  ?.length ??
                                                  0));
                                },
                                seperatedBuilder: Divider(),
                                containerHorizontalPadding: 10,

                                // OPTIONAL// If you want to customize list view item builder
                                itemBuilder: (context, index,
                                    Prediction prediction) {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(
                                            child: Text(
                                                "${prediction.description ?? "..."}"))
                                      ],
                                    ),
                                  );
                                },

                                isCrossBtnShown: true,

                                // default 600 ms ,
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
                        const Text(
                          "   Edite su dirección si no es precisa",
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
                            minLines: 1,
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
                          textInputType: TextInputType.text,
                          maxLength: 250,
                          minLines: 1,
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
                        CheckBox1Widget(
                          error: agreeError,
                          onChanged: _onCheckbox1Changed,
                        ),
                        CheckBox2Widget(
                          onChanged: _onCheckbox2Changed,
                        ),
                        divider40(),
                        ButtonWidget(
                          onPressed: () async {
                            final formState = _formKey.currentState;
                            if (formState != null &&
                                formState.validate() &&
                                agreeTerms) {
                              await _registrarYGuardarDatos();
                            } else {
                              if (!agreeTerms) {
                                setState(() {
                                  agreeError = 'Este campo es obligatorio';
                                });
                              }
                              snackBarMessage(context, Typemessage.incomplete);
                            }
                          },
                          text: "Registrar",
                        ),
                        divider20(),
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
