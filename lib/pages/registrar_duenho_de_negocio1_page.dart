import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pidenomas/pages/login_negocio_page.dart';
import 'package:pidenomas/pages/registrar_duenho_de_negocio2_page.dart';
import 'package:pidenomas/ui/general/type_messages.dart';
import 'package:pidenomas/ui/widgets/check_box1_widget.dart';
import 'package:pidenomas/ui/widgets/icon_form_button_widget.dart';
import 'package:pidenomas/ui/widgets/radio_button_widget.dart';
import '../models/register_client_model.dart';
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

class RegistrarDuenhoDeNegocioPage extends StatefulWidget {
  const RegistrarDuenhoDeNegocioPage({super.key});

  @override
  State<RegistrarDuenhoDeNegocioPage> createState() =>
      _RegistrarDuenhoDeNegocioPageState();
}

class _RegistrarDuenhoDeNegocioPageState
    extends State<RegistrarDuenhoDeNegocioPage> {
  final _formKey = GlobalKey<FormState>();

  final CollectionReference _clientsCollection =
  FirebaseFirestore.instance.collection('clients');

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  String uidForFirebase = '';
  String photoURLforFirebase = '';
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

  String agreeError = "";
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: BackGroundWidget(
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          PrincipalText(string: "Completa tus datos"),
                          PrincipalText(string: "como titular del negocio"),
                          divider20(),
                          const Text(
                            "Nombres",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          InputTextFieldNameWidget(
                            hintText: "Ingresa tu nombre",
                            textInputType: TextInputType.name,
                            controller: _nombreController,
                          ),
                          divider20(),
                          const Text(
                            "Apellidos Completos",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          InputTextFieldNameWidget(
                            hintText: "Ingresa apellidos",
                            textInputType: TextInputType.name,
                            controller: _apellidoController,
                          ),
                          divider30(),
                          const Text(
                            "Fecha de Nacimiento",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          DataBirthWidget(
                            controller: _fechaDeNacimientoController,
                          ),
                          divider30(),
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
                          InputTextFieldEmailWidget(
                            hintText: "example@email.com",
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
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
                            hintText: "Latitud",
                            icon: Icons.location_on,
                            textInputType: TextInputType.number,
                            controller: _latController,
                          ),
                          divider12(),
                          InputTextFieldWidget(
                            hintText: "Longitud",
                            icon: Icons.location_on,
                            textInputType: TextInputType.number,
                            controller: _lngController,
                          ),
                          divider12(),
                          InputTextFieldWidget(
                            hintText: "Dirección",
                            icon: Icons.location_on,
                            textInputType: TextInputType.text,
                            controller: _direccionController,
                          ),
                          divider30(),
                          const Text(
                            "Detalle su ubicacion",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          InputTextFieldWidget(
                            hintText: "1er piso / Ofic 201 / Dpto 301",
                            icon: (Icons.map_sharp),
                            controller: _detalleUbicacionController,
                          ),
                          divider30(),
                          const Text(
                            "Referencia de su ubicacion",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          InputTextFieldWidget(
                            hintText:
                            "Ejm: Casa de 2 pisos color verde frente a bodega.",
                            icon: Icons.maps_ugc,
                            controller: _referenciaUbicacionController,
                          ),
                          divider40(),
                          Center(
                            child: Row(
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
                                              LoginNegocioPage(),
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
                            ),
                          ),
                          divider40(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconFormButtonWidget(
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginNegocioPage(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(width: 20.0),
                              IconFormButtonWidget(
                                icon: Icon(FontAwesomeIcons.arrowRight),
                                isFormComplete: true,
                                onPressed: () {
                                  final formState = _formKey.currentState;
                                  if (formState != null &&
                                      formState.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrarDuenhoDeNegocio2Page(
                                              nombre: _nombreController.text,
                                              apellidos: _apellidoController.text,
                                              fechaDeNacimiento:
                                              _fechaDeNacimientoController.text,
                                              celular: _celularController.text,
                                              tipoDocumento:
                                              _tipoDocumentoController.text,
                                              documentoIdentidad:
                                              _documentoIdentidadController
                                                  .text,
                                              genero: _generoController.text,
                                              email: _emailController.text,
                                              password: _passwordController.text,
                                              lat: _latController.text,
                                              lng: _lngController.text,
                                              direccion: _direccionController.text,
                                              detalleDireccion:
                                              _detalleUbicacionController.text,
                                              referenciaDireccion:
                                              _referenciaUbicacionController
                                                  .text,
                                              agreeNotifications:
                                              agreeNotifications.toString(),
                                            ),
                                      ),
                                    );
                                  } else {
                                    snackBarMessage(
                                        context, Typemessage.incomplete);
                                  }
                                },
                              ),
                            ],
                          ),
                          divider40(),
                          divider40(),
                          divider40(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}