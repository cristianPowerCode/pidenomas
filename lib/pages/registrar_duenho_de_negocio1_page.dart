import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pidenomas/pages/login_negocio_page.dart';
import 'package:pidenomas/pages/registrar_duenho_de_negocio2_page.dart';
import 'package:pidenomas/pages/registrar_duenho_de_negocio3_page.dart';
import 'package:pidenomas/ui/general/type_messages.dart';
import 'package:pidenomas/ui/widgets/grid_type_of_house_widget.dart';
import 'package:pidenomas/ui/widgets/icon_form_button_widget.dart';
import 'package:pidenomas/ui/widgets/radio_button_widget.dart';
import '../ui/general/constant_responsive.dart';
import 'login_cliente_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/data_birth_widget.dart';
import '../ui/widgets/dropdowm_button_widget.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/input_textfield_password_widget.dart';
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
  TextEditingController _celularController = TextEditingController();
  TextEditingController _tipoDocumentoController = TextEditingController();
  TextEditingController _documentoIdentidadController = TextEditingController();
  TextEditingController _generoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String agreeError = "";
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;

  void mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: kErrorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      PrincipalText(string: "Completa tus datos"),
                      PrincipalText(string: "como titular del negocio"),
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
                      divider30(),
                      Center(
                        child: screenWidth > ResponsiveConfig.widthResponsive
                            ? buildRowLoginAgain(context)
                            : buildColumnLoginAgain(context),
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
                              if (formState != null && formState.validate()) {
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
                                          _documentoIdentidadController.text,
                                      genero: _generoController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  ),
                                );
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
