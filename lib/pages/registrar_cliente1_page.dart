import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pidenomas/pages/registrar_cliente2_page.dart';
import 'package:pidenomas/pages/registrar_negocio2_page.dart';
import 'package:pidenomas/ui/general/type_messages.dart';
import 'package:pidenomas/ui/widgets/check_box1_widget.dart';
import 'package:pidenomas/ui/widgets/radio_button_widget.dart';
import '../models/register_client_model.dart';
import '../services/api_service.dart';
import '../services/verficar_email_dni_negocio_service.dart';
import '../ui/general/constant_responsive.dart';
import '../ui/widgets/check_box2_widget.dart';
import '../ui/widgets/icon_form_button_widget.dart';
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
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String uidForFirebase = '';
  String photoURLforFirebase =
      'https://images.pexels.com/photos/1878687/pexels-photo-1878687.jpeg';
  String phoneNumberForFirebase = '';

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _fechaDeNacimientoController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  TextEditingController _tipoDocumentoController = TextEditingController();
  TextEditingController _documentoIdentidadController = TextEditingController();
  TextEditingController _generoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String agreeError = '';
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;
  VerificarEmailDniCelNegocioService verificarEmailDniCelNegocio =
      VerificarEmailDniCelNegocioService();

  Future<Map<String, dynamic>> checkIfEmailExists() async {
    print("Calling verificarEmailDniNegocioEnBD...");
    try {
      final response =
          await verificarEmailDniCelNegocio.verificarEmailDniCelNegocioEnBD(
        _emailController.text,
        _documentoIdentidadController.text,
        _celularController.text,
      );

      // Verificar el estado y el mensaje del response
      return {
        "exists": response.status != 200,
        // Si no es 200, email y/o documento ya existen
        "message": response.message,
      };
    } catch (e) {
      // Manejar errores de red o excepciones aquí
      print("Error al verificar email y DNI: $e");
      mostrarSnackBar("Error al verificar email y DNI");
      return {
        "exists": false,
        "message": "Error al verificar email y DNI",
      };
    }
  }

  void mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: kBrandErrorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: isLoading,
              child: BackGroundWidget(
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
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
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
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
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
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                      ),
                      DataBirthWidget(
                        controller: _fechaDeNacimientoController,
                      ),
                      divider20(),
                      const Text(
                        "Nro de Celular",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                      ),
                      InputTextFieldWidget(
                        icon: Icons.phone,
                        hintText: "Celular",
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
                          } else if (value.length == 9 && value[0] != '9') {
                            return 'El primer dígito debe ser 9';
                          }
                          return null;
                        },
                      ),
                      divider30(),
                      const Text(
                        "Seleccione su documento de identidad",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                      ),
                      RadioButtonWidget(
                        controller: _documentoIdentidadController,
                        onOptionChanged: (option) {
                          setState(() {
                            _tipoDocumentoController.text = option.toString();
                          });
                        },
                      ),
                      divider30(),
                      const Text(
                        "Género",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                      ),
                      GenderDropdownWidget(
                        controller: _generoController,
                      ),
                      divider30(),
                      const Text(
                        "Correo electrónico",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
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
                        style:
                            TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                      ),
                      InputTextFieldPasswordWidget(
                        controller: _passwordController,
                      ),
                      divider40(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconFormButtonWidget(
                            icon: Icon(FontAwesomeIcons.arrowLeft),
                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginClientePage(),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 20.0),
                          IconFormButtonWidget(
                            icon: Icon(FontAwesomeIcons.arrowRight),
                            isFormComplete: true,
                            onPressed: () async {
                              final formState = _formKey.currentState;
                              if (formState != null && formState.validate()) {
                                Map<String, dynamic> result =
                                    await checkIfEmailExists();
                                bool isEmailDniExists = result["exists"];
                                String message = result["message"];
                                if (isEmailDniExists) {
                                  print("Existe? $isEmailDniExists");
                                  print(message);
                                  mostrarSnackBar(message);
                                } else {
                                  print("Existe? $isEmailDniExists");
                                  print(message);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrarCliente2Page(
                                        nombre: _nombreController.text,
                                        apellidos: _apellidoController.text,
                                        fechaDeNacimiento:
                                            _fechaDeNacimientoController.text,
                                        celular: _celularController.text,
                                        tipoDocumento:
                                            _tipoDocumentoController.text,
                                        documentoIdentidad:
                                            _documentoIdentidadController.text,
                                        genero: _generoController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                snackBarMessage(context, Typemessage.error);
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
                  builder: (context) => LoginClientePage(),
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
                  builder: (context) => LoginClientePage(),
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
