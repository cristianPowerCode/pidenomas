import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pidenomas/pages/login_negocio_page.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/input_textfield_widget.dart';

import '../models/register_business_owner_model.dart';
import '../ui/general/colors.dart';
import '../ui/general/type_messages.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/check_box1_widget.dart';
import '../ui/widgets/check_box2_widget.dart';

class RegistrarDuenhoDeNegocio3Page extends StatefulWidget {
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
  String referenciaDireccion;
  String agreeNotifications;
  String categoria;

  RegistrarDuenhoDeNegocio3Page({
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
    required this.referenciaDireccion,
    required this.agreeNotifications,
    required this.categoria,
  });

  @override
  State<RegistrarDuenhoDeNegocio3Page> createState() =>
      _RegistrarDuenhoDeNegocio3PageState();
}

class _RegistrarDuenhoDeNegocio3PageState
    extends State<RegistrarDuenhoDeNegocio3Page> {

  @override
  void initState() {
    super.initState();
    print("DATOS CAPTURADOS");
    print(
        "nombre: ${widget.nombre}, apellidos: ${widget.apellidos}, fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular}, tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad}, genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password}, lat: ${widget.lat}, lng: ${widget.lng}, direccion: ${widget.direccion}, detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaDireccion}, agreeNotifications: ${widget.agreeNotifications}");
    print("DATOS ACTUALIZADOS");
    print("categoria: ${widget.categoria}");
  }

  final _formKey = GlobalKey<FormState>();

  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('business_owner');

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  String uidForFirebase = '';
  String photoURLforFirebase = '';
  String phoneNumberForFirebase = '';
  TextEditingController _rucController = TextEditingController();
  TextEditingController _razSocialNegocioController = TextEditingController();
  TextEditingController _nombreNegocioController = TextEditingController();

  String agreeError = "";
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;

  Future<void> _registroYGuardarDatos() async {
    setState(() {
      isLoading = true; // Establece isLoading en true al iniciar el proceso
    });
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      if (userCredential.user != null) {
        User? user = userCredential.user;
        uidForFirebase = user!.uid;
        photoURLforFirebase = user.photoURL ?? '';
        phoneNumberForFirebase = user.phoneNumber ?? '';

        print('Negocio registrado con éxito.');
        print(uidForFirebase);
        print(photoURLforFirebase);
        print(phoneNumberForFirebase);

        // Enviar correo de verificación
        await user.sendEmailVerification();

        // Guardar datos en Firestore
        await _guardarDatos();
        print(_guardarDatos());

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
                          builder: (context) => LoginNegocioPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
      setState(() {
        isLoading =
            false; // Establece isLoading en false al completar con éxito el proceso
      });
    } catch (e) {
      setState(() {
        isLoading =
            false; // Establece isLoading en false si ocurre un error durante el proceso
      });
      print('Error al registrar el negocio: $e');
      // Mostrar SnackBar de error
      snackBarMessage(context, Typemessage.error);
    }
  }

  Future<void> _guardarDatos() async {
    print("!!!!!!!!!!!!!!");
    print("{Nombre: ${widget.nombre}, ${_rucController} }");

    BusinessOwnerModel businessOwnerModel = BusinessOwnerModel(
      uid: uidForFirebase,
      nombre: widget.nombre,
      apellidos: widget.apellidos,
      email: widget.email,
      isVerified: false,
      celular: widget.celular,
      tipoDocumento: int.parse(widget.tipoDocumento),
      fechaDeNacimiento: DateTime.parse(widget.fechaDeNacimiento),
      documentoIdentidad: widget.documentoIdentidad,
      genero: int.parse(widget.genero),
      password: widget.password,
      lat: double.parse(widget.lat),
      lng: double.parse(widget.lng),
      direccion: widget.direccion,
      detalleDireccion: widget.detalleDireccion,
      referenciaDireccion: widget.referenciaDireccion,
      photoUrl: photoURLforFirebase,
      fechaDeCreacion: DateTime.now(),
      categoria: int.parse(widget.categoria),
      rucNegocio: _rucController.text,
      razSocNegocio: _razSocialNegocioController.text,
      nombNegocio: _nombreNegocioController.text,
    );

    try {
      await _clientsCollection
          .doc(uidForFirebase)
          .set(businessOwnerModel.toJson());
      print("RESULTADO DE REGISTRO");
      print(businessOwnerModel.toJson());
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PrincipalText(string: "Completa"),
                        PrincipalText(string: "tus datos del negocio"),
                        divider30(),
                        InputTextFieldWidget(
                          hintText: "RUC",
                          controller: _rucController,
                          icon: Icons.check_circle_outline,
                        ),
                        divider20(),
                        InputTextFieldWidget(
                          labelText: "Razon Social del Negocio",
                          controller: _razSocialNegocioController,
                          icon: Icons.check_circle_outline,
                        ),
                        divider20(),
                        InputTextFieldWidget(
                          labelText: "Nombre del negocio o emprendimiento",
                          controller: _nombreNegocioController,
                          icon: Icons.check_circle_outline,
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
                                        builder: (context) => LoginNegocioPage(),
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
                        divider20(),
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
                            if (formState != null && formState.validate() && agreeTerms) {
                              await _registroYGuardarDatos();
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading ?
          Container(
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
}
