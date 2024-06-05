import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pidenomas/ui/general/type_messages.dart';
import 'package:pidenomas/ui/widgets/check_box1_widget.dart';
import 'package:pidenomas/ui/widgets/radio_button_widget.dart';
import '../models/register_client_model.dart';
import '../services/api_service.dart';
import '../ui/general/constant_responsive.dart';
import '../ui/widgets/check_box2_widget.dart';
import 'login_cliente_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/data_birth_widget.dart';
import '../ui/widgets/dropdowm_button_widget.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/input_textfield_name_widget.dart';
import '../ui/widgets/input_textfield_password_widget.dart';
import '../ui/widgets/input_textfield_email_widget.dart';
import '../ui/widgets/input_textfield_widget.dart';

class RegistrarCliente1Page extends StatefulWidget {
  @override
  State<RegistrarCliente1Page> createState() => _RegistrarCliente1PageState();
}

class _RegistrarCliente1PageState extends State<RegistrarCliente1Page> {
  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('clients');

  FirebaseAuth _auth = FirebaseAuth.instance;
  final APIService _apiService = APIService();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String photoURLforFirebase =
      'https://images.pexels.com/photos/1878687/pexels-photo-1878687.jpeg';
  String uidForFirebase = '';
  String phoneNumberForFirebase = '';

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _fechaDeNacimientoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _tipoDocumentoController = TextEditingController();
  TextEditingController _documentoIdentidadController = TextEditingController();
  TextEditingController _generoController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _detalleUbicacionController = TextEditingController();
  TextEditingController _referenciaUbicacionController =
      TextEditingController();

  String agreeError = '';
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;

  Future<void> _registerClienteToDB() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        print("Calling registerClienteToDB...");
        final value = await _apiService.registerClienteToDB(
          uidForFirebase,
          _nombreController.text,
          _apellidoController.text,
          _emailController.text,
          false,
          _celularController.text,
          int.parse(_tipoDocumentoController.text),
          DateTime.parse(_fechaDeNacimientoController.text),
          _documentoIdentidadController.text,
          int.parse(_generoController.text),
          _passwordController.text,
          double.parse(_latController.text),
          double.parse(_lngController.text),
          _direccionController.text,
          _detalleUbicacionController.text,
          _referenciaUbicacionController.text,
          photoURLforFirebase,
          DateTime.now(),
          agreeNotifications,
        );
        if (value != null) {
          print("REGISTRADO A LA DB");
          snackBarMessage(context, Typemessage.loginSuccess);
        } else {
          print("Error: Value is null");
          // snackBarMessage(context, Typemessage.error);
        }
      } catch (error) {
        print("Catch Error: $error");
        // snackBarMessage(context, Typemessage.error);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _registroYGuardarDatos() async {
    setState(() {
      isLoading = true; // Establece isLoading en true al iniciar el proceso
    });
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      snackBarMessage(context, Typemessage.loginSuccess);

      if (userCredential.user != null) {
        User? user = userCredential.user;
        uidForFirebase = user!.uid;
        photoURLforFirebase = user.photoURL ?? '';
        phoneNumberForFirebase = user.phoneNumber ?? '';

        print('Usuario registrado con éxito.');

        // Enviar correo de verificación
        await user.sendEmailVerification();

        // Guardar datos en Firestore
        print("GUARDAR DATOS");
        await _guardarDatos();
        print(_guardarDatos());
        print("REGISTRADO A LA BASE DE DATOS");
        await _registerClienteToDB();
        print(_registerClienteToDB);

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
      print('Error al registrar usuario: $e');
      snackBarMessage(context, Typemessage.error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _guardarDatos() async {
    print("!!!!!!!!!!!!!!");
    print(
        "{tipoDeGenero: ${int.parse(_generoController.text)}, ${int.parse(_generoController.text).runtimeType} }");

    RegisterClientModel registerClientModel = RegisterClientModel(
      uid: uidForFirebase,
      nombre: _nombreController.text,
      apellidos: _apellidoController.text,
      email: _emailController.text,
      isVerified: false,
      celular: _celularController.text,
      tipoDocumento: int.parse(_tipoDocumentoController.text),
      fechaDeNacimiento: DateTime.parse(_fechaDeNacimientoController.text),
      documentoIdentidad: _documentoIdentidadController.text,
      genero: int.parse(_generoController.text),
      password: _passwordController.text,
      lat: double.parse(_latController.text),
      lng: double.parse(_lngController.text),
      direccion: _direccionController.text,
      detalleDireccion: _detalleUbicacionController.text,
      referenciaDireccion: _referenciaUbicacionController.text,
      photoUrl: photoURLforFirebase,
      fechaDeCreacion: DateTime.now(),
      agreeNotifications: agreeNotifications,
    );

    try {
      await _clientsCollection
          .doc(uidForFirebase)
          .set(registerClientModel.toJson());
      print("RESULTADO DE REGISTRO");
      print(registerClientModel.toJson());
    } catch (e) {
      print("Error al guardar datos en cloud firestore: $e");
    }
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
    double height = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                BackGroundWidget(
                  child: Stack(
                    children: [
                      AbsorbPointer(
                        absorbing: isLoading,
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PrincipalText(string: "Regístrate"),
                              PrincipalText(string: "como Cliente"),
                              divider20(),
                              const Text(
                                "Nombres",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldWidget(
                                controller: _nombreController,
                                icon: Icons.person,
                                optionRegex: [
                                  (
                                    RegExp(r'^[A-Za-zÑñáéíóúÁÉÍÓÚ\s]+$'),
                                    "No ingrese números o símbolos",
                                  ),
                                  (
                                    RegExp(r'(?<!\s)$'),
                                    "No deje espacios al final",
                                  ),
                                ],
                              ),
                              divider20(),
                              const Text(
                                "Apellidos Completos",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldWidget(
                                controller: _apellidoController,
                                icon: Icons.person,
                                optionRegex: [
                                  (
                                    RegExp(r'^[A-Za-zÑñáéíóúÁÉÍÓÚ\s]+$'),
                                    "No ingrese números o símbolos",
                                  ),
                                  (
                                    RegExp(r'(?<!\s)$'),
                                    "No deje espacios al final",
                                  ),
                                ],
                              ),
                              divider20(),
                              const Text(
                                "Fecha de Nacimiento",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              DataBirthWidget(
                                controller: _fechaDeNacimientoController,
                              ),
                              divider20(),
                              const Text(
                                "Nro de Celular",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldWidget(
                                icon: Icons.phone,
                                hintText: "Telefono",
                                controller: _celularController,
                                textInputType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 9,
                                validator: (value) {
                                  if (value!.length < 9) {
                                    if (value[0] != '9') {
                                      return 'El primer dígito debe ser 9';
                                    } else {
                                      return 'Ingrese 9 dígitos';
                                    }
                                  } else if (value.length == 9 &&
                                      value[0] != '9') {
                                    return 'El primer dígito debe ser 9';
                                  }
                                  return null;
                                },
                              ),
                              divider30(),
                              const Text(
                                "Seleccione su documento de identidad",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              RadioButtonWidget(
                                controller: _documentoIdentidadController,
                                onOptionChanged: (option) {
                                  setState(() {
                                    _tipoDocumentoController.text =
                                        option.toString();
                                  });
                                },
                              ),
                              divider30(),
                              const Text(
                                "Género",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              GenderDropdownWidget(
                                controller: _generoController,
                              ),
                              divider30(),
                              const Text(
                                "Correo electrónico",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldWidget(
                                controller: _emailController,
                                icon: Icons.person,
                                textInputType: TextInputType.emailAddress,
                                optionRegex: [
                                  (
                                    (RegExp(
                                        r'[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,5}')),
                                    "Debe ingresar un correo válido"
                                  ),
                                  (
                                    RegExp(r'(?<!\s)$'),
                                    "No deje espacios al final",
                                  ),
                                ],
                              ),
                              divider30(),
                              const Text(
                                "Contraseña",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldPasswordWidget(
                                controller: _passwordController,
                              ),
                              divider30(),
                              const Text(
                                "Direccion",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldWidget(
                                controller: _latController,
                                hintText: "Latitud",
                                icon: Icons.location_on,
                                textInputType: TextInputType.numberWithOptions(
                                    decimal: true, signed: false),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],
                                maxLength: 12,
                                optionRegex: [
                                  (
                                    RegExp(r'^[0-9]*\.?[0-9]+$'),
                                    "Use el punto decimal"
                                  ),
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
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*')),
                                ],
                                controller: _lngController,
                                maxLength: 12,
                                optionRegex: [
                                  (
                                    RegExp(r'^[0-9]*\.?[0-9]+$'),
                                    "Use el punto decimal"
                                  ),
                                  (RegExp(r'[0-9]'), "Ingresar solo números"),
                                ],
                              ),
                              divider12(),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 500.0,
                                ),
                                child: InputTextFieldWidget(
                                  hintText:
                                      "Dirección del Negocio o Punto de Venta",
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
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
                              ),
                              InputTextFieldWidget(
                                hintText:
                                    "Puerta Calle/ Block B - Dpto 405/ Interior A",
                                icon: (Icons.map_sharp),
                                controller: _detalleUbicacionController,
                                maxLength: 250,
                                minLines: 2,
                                maxLines: null,
                                count: 250,
                              ),
                              divider30(),
                              const Text(
                                "Referencia de su ubicacion",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xffB1B1B1)),
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
                              divider40(),
                              Center(
                                child: screenWidth > ResponsiveConfig.widthResponsive ? buildRowLoginAgain(context) : buildColumnLoginAgain(context),
                              ),
                              divider40(),
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
                                    await _registroYGuardarDatos();
                                    // await _registerClienteToDB();
                                    // print(_registerClienteToDB);
                                  } else {
                                    if (!agreeTerms) {
                                      setState(() {
                                        agreeError =
                                            'Este campo es obligatorio';
                                      });
                                    }
                                    snackBarMessage(
                                        context, Typemessage.incomplete);
                                  }
                                },
                                text: "Registrar",
                              ),
                              divider40(),
                              divider30(),
                              divider20(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
                height: height,
                color: kDefaultIconDarkColor.withOpacity(0.85),
                child: Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: kBrandPrimaryColor1,
                      strokeWidth: 5,
                    ),
                  ),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget buildRowLoginAgain(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿Ya tienes una cuenta?",
          style: TextStyle(
            color: kBrandPrimaryColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoginClientePage(),
                ));
          },
          child: Text(
            "Inicia sesión aquí",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildColumnLoginAgain(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿Ya tienes una cuenta?",
          style: TextStyle(
            color: kBrandPrimaryColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LoginClientePage(),
                ));
          },
          child: Text(
            "Inicia sesión aquí",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
