import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:pidenomas/pages/login_negocio_page.dart';
import 'package:pidenomas/pages/registrar_negocio4_page.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/input_textfield_widget.dart';

import '../models/register_business_model.dart';
import '../services/api_service.dart';
import '../ui/general/colors.dart';
import '../ui/general/constant_responsive.dart';
import '../ui/general/type_messages.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/check_box1_widget.dart';
import '../ui/widgets/check_box2_widget.dart';
import 'package:http/http.dart' as http;

class RegistrarNegocio5Page extends StatefulWidget {
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
  String fachadaInterna;
  String fachadaExterna;
  String docAnversoUrl;
  String docReversoUrl;

  RegistrarNegocio5Page({
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
    required this.fachadaInterna,
    required this.fachadaExterna,
    required this.docAnversoUrl,
    required this.docReversoUrl,
  });

  @override
  State<RegistrarNegocio5Page> createState() => _RegistrarNegocio5PageState();
}

class _RegistrarNegocio5PageState extends State<RegistrarNegocio5Page> {
  @override
  void initState() {
    super.initState();
    print("PAGINA 5");
    print('''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password},
lat: ${widget.lat}, lng: ${widget.lng}, direccion: ${widget.direccion},
detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaUbicacion},
tipo de inmueble: ${widget.typeOfHousing}, category: ${widget.categoria},
photoFachadaInterna: ${widget.fachadaInterna}, photoFachadaExterna: ${widget.fachadaExterna}
photoDocIdentidadAnv: ${widget.docAnversoUrl}, photoDocIdentidadRev: ${widget.docReversoUrl}''');
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  final APIService _apiService = APIService();
  final _formKey = GlobalKey<FormState>();

  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('business_owner');

  bool isLoading = false;

  String uidForFirebase = '';
  List<Horario> horarios = [
    Horario(
      dia: "lunes",
      horaInicia: "13:09:53",
      horaFin: "13:09:54",
    ),
    Horario(
      dia: "viernes",
      horaInicia: "13:44:51",
      horaFin: "13:44:52",
    ),
    Horario(
      dia: "feriado",
      horaInicia: "13:44:51",
      horaFin: "13:44:52",
    ),
  ];
  TextEditingController _rucController = TextEditingController();
  TextEditingController _razSocialNegocioController = TextEditingController();
  TextEditingController _nombreNegocioController = TextEditingController();

  String agreeError = "";
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;

  Future<void> _registrarYGuardarDatos() async {
    setState(() {
      isLoading = true; // Establece isLoading en true al iniciar el proceso
    });
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: widget.email,
          password: widget.password,
        );

        if (userCredential.user != null) {
          User? user = userCredential.user;
          uidForFirebase = user!.uid;

          print('Negocio registrado con éxito.');
          print(uidForFirebase);

          // Enviar correo de verificación
          await user.sendEmailVerification();

          // Guardar datos en Firestore
          print("GUARDANDO DATOS EN FIREBASE - Function _guardarDatos()");
          try {
            await _guardarDatos();
            print("DATOS GUARDADOS EN FIREBASE- Function _guardarDatos()");
            print("REGISTRANDO A LA BASE DE DATOS - Function _registroYGuardarDatos()");
            await _registrarNegocioToDB();
            print("REGISTRADO A LA BASE DE DATOS - Function _registroYGuardarDatos()");

            // Mostrar AlertDialog para informar al usuario que verifique su correo
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Registro Exitoso"),
                  content: Text("Se ha enviado un correo de verificación a ${user.email}. Por favor verifica tu correo antes de iniciar sesión."),
                  actions: [
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Redirigir a la pantalla de login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginNegocioPage()),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          } catch (e) {
            print("Error al guardar datos en Firestore: $e");
            mostrarSnackBar("Hubo un problema al estructurar su registro: $e", 3);

            // Eliminar la cuenta en Firebase Authentication
            await user.delete();

            setState(() {
              isLoading = false;
            });
          }
        }
      } catch (e) {
        setState(() {
          isLoading = false; // Establece isLoading en false si ocurre un error durante el proceso
        });
        print('Error al registrar el negocio: $e');
        mostrarSnackBar("Error al registrar el negocio: $e", 3);
      }
    } else {
      setState(() {
        isLoading = false;
        mostrarSnackBar("No tiene el formulario validado", 2);
      });
    }
  }

  Future<void> _guardarDatos() async {
    print("!!!!!!!!!!!!!!");
    print("{Nombre: ${widget.nombre}, RUC${"10125514061"} }");

    RegisterBusinessModel businessOwnerModel = RegisterBusinessModel(
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
      isRegistered: 1,
      agreeNotifications: false,
      lat: double.parse(widget.lat),
      lng: double.parse(widget.lng),
      direccion: widget.direccion,
      detalleDireccion: widget.detalleDireccion,
      referenciaDireccion: widget.referenciaUbicacion,
      tipoDeInmueble: int.parse(widget.typeOfHousing),
      categoria: int.parse(widget.categoria),
      photoFachadaInterna: widget.fachadaInterna,
      photoFachadaExterna: widget.fachadaExterna,
      photoDocIdentidadAnv: widget.docAnversoUrl,
      photoDocIdentidadRev: widget.docReversoUrl,
      rucNegocio: _rucController.text,
      razSocNegocio: _razSocialNegocioController.text,
      nombreNegocio: _nombreNegocioController.text,
      fechaDeCreacion: DateTime.now(),
      horarios: horarios,
    );

    try {
      await _clientsCollection
          .doc(uidForFirebase)
          .set(businessOwnerModel.toJson());
      print("RESULTADO DE REGISTRO");
      print(jsonEncode(businessOwnerModel.toJson()));
    } catch (e) {
      print("Error al guardar datos en cloud firestore: $e");
      mostrarSnackBar("Error al guardar datos en Firestore: $e", 2);
      throw Exception("Error al guardar datos en Firestore: $e");
    }
  }

  Future<void> _registrarNegocioToDB() async {
    print("Entró a la funcion _registerNegocioToDB()");

    if (uidForFirebase.isNotEmpty) {
      print("el formulario no tiene campos vacios");
      setState(() {
        isLoading = true;
      });
      try {
        print("Calling registerClienteToDB...");
        final RegisterBusinessModel? value = await _apiService.registrarNegocioToDB(
          uidForFirebase,
          widget.nombre,
          widget.apellidos,
          widget.email,
          false,
          1,
          agreeNotifications,
          widget.celular,
          int.parse(widget.tipoDocumento),
          widget.documentoIdentidad,
          DateTime.parse(widget.fechaDeNacimiento),
          int.parse(widget.genero),
          widget.password,
          double.parse(widget.lat),
          double.parse(widget.lng),
          widget.direccion,
          widget.detalleDireccion,
          widget.referenciaUbicacion,
          widget.typeOfHousing,
          widget.fachadaInterna,
          widget.fachadaExterna,
          widget.docAnversoUrl,
          widget.docReversoUrl,
          DateTime.now(),
          int.parse(widget.categoria),
          _rucController.text,
          _razSocialNegocioController.text,
          _nombreNegocioController.text,
        );

        if (value != null) {
          print("REGISTRANDO A LA DB");
          // snackBarMessage(context, Typemessage.loginSuccess);
        } else {
          print("Error: Value is null");
          mostrarSnackBar("Hubo un problema al registrar en la BD: Value is null", 3);

          // Eliminar la cuenta en Firebase Authentication
          User? user = _auth.currentUser;
          await user?.delete();

          // Eliminar el documento en Firestore
          await _clientsCollection.doc(uidForFirebase).delete();

          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        // Manejar errores específicos del servidor
        String errorMessage;
        if (e is http.Response && e.statusCode == 400) {
          final errorData = json.decode(e.body);
          errorMessage = errorData['message'];
        } else {
          errorMessage = e.toString();
        }
        print("Catch Error: $errorMessage");
        mostrarSnackBar("Hubo un problema al registrar en la BD: $errorMessage", 3);

        // Eliminar la cuenta en Firebase Authentication
        User? user = _auth.currentUser;
        await user?.delete();

        // Eliminar el documento en Firestore
        await _clientsCollection.doc(uidForFirebase).delete();

        setState(() {
          isLoading = false;
        });
      }
    } else {
      mostrarSnackBar("Termine de rellenar el formulario por favor", 2);
      setState(() {
        isLoading = false;
      });
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
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
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
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 26.0, 16.0, 16.0),
                        // Añade padding para respetar el espacio del leading
                        child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            size: 40,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrarNegocio4Page(
                                    nombre: widget.nombre,
                                    apellidos: widget.apellidos,
                                    fechaDeNacimiento: widget.fechaDeNacimiento,
                                    celular: widget.celular,
                                    tipoDocumento: widget.tipoDocumento,
                                    documentoIdentidad:
                                        widget.documentoIdentidad,
                                    genero: widget.genero,
                                    email: widget.email,
                                    password: widget.password,
                                    lat: widget.lat,
                                    lng: widget.lng,
                                    direccion: widget.direccion,
                                    detalleDireccion: widget.detalleDireccion,
                                    referenciaUbicacion:
                                        widget.referenciaUbicacion,
                                    typeOfHousing: widget.typeOfHousing,
                                    categoria: widget.categoria,
                                  ),
                                ));
                          },
                        ),
                      )),
                ),
                divider12(),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 50.0, bottom: 40.0, left: 50.0),
                  child: Form(
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
                          textInputType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 11,
                          count: 11,
                          optionRegex: [
                            (RegExp(r'[0-9]'), ("Ingresar solo números")),
                            (RegExp(r'^\S+$'), ("No deje espacios vacios")),
                            (RegExp(r'^[^-_.,]+$'), ("Ingrese solo números")),
                          ],
                          validator: (value) {
                            if (value!.length != 11) {
                              return 'Ingrese 11 dígitos';
                            } else {
                              return null;
                            }
                          },
                        ),
                        divider20(),
                        InputTextFieldWidget(
                          labelText: "Razon Social del Negocio",
                          controller: _razSocialNegocioController,
                          icon: Icons.check_circle_outline,
                          maxLines: null,
                          maxLength: 250,
                          count: 250,
                        ),
                        divider20(),
                        InputTextFieldWidget(
                          labelText: "Nombre del negocio o emprendimiento",
                          controller: _nombreNegocioController,
                          icon: Icons.check_circle_outline,
                          maxLines: null,
                          maxLength: 250,
                          count: 250,
                        ),
                        divider40(),
                        // HorariosPage(),
                        divider40(),
                        Center(
                          child: screenWidth > ResponsiveConfig.widthResponsive
                              ? buildRowLoginAgain(context)
                              : buildColumnLoginAgain(context),
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
                        divider40(),
                        divider20(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Container(
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
    );
  }
}

////////////////

// class Horario {
//   String dia;
//   TimeOfDay horaInicio;
//   TimeOfDay horaFin;
//
//   Horario({required this.dia, required this.horaInicio, required this.horaFin});
//
//   Map<String, dynamic> toJson(BuildContext context) {
//     return {
//       'dia': dia,
//       'horaInicio': horaInicio.format(context),
//       'horaFin': horaFin.format(context),
//     };
//   }
// }
