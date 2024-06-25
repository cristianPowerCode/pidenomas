import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/pages/login_negocio_page.dart';
import 'package:pidenomas/pages/registrar_negocio4_page.dart';
import 'package:pidenomas/ui/widgets/circular_loading_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/input_textfield_widget.dart';

import '../models/register_business_model.dart';
import '../models/response_model.dart';
import '../services/api_service.dart';
import '../ui/general/colors.dart';
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
    Horario(dia: "lunes", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "martes", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "miercoles", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "jueves", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "viernes", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "sabado", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "domingo", horaInicia: "07:59:59", horaFin: "06:02:02"),
    Horario(dia: "feriado", horaInicia: "07:59:59", horaFin: "06:02:02")
  ];
  TextEditingController _rucController = TextEditingController();
  TextEditingController _razSocialNegocioController = TextEditingController();
  TextEditingController _nombreNegocioController = TextEditingController();

  String agreeError = "";
  bool agreeTerms = false;
  bool isChanged = false;
  bool agreeNotifications = false;

  List<bool> _checkboxSelected = List.generate(8, (index) => false);

  String capitalize(String s) {
    return s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : "";
  }

  // Función para editar hora de inicio
  void _editHoraInicia(BuildContext context, int index) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Hora de Inicio',
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kBrandPrimaryColor1, // Color primario para el tema
              onPrimary: Colors.white, // Color del texto cuando se selecciona
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      setState(() {
        horarios[index].horaInicia =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00";
      });
      _editHoraFin(context, index);
    } else {
      setState(() {
        _checkboxSelected[index] = false;
        horarios[index].horaInicia = "null";
        horarios[index].horaFin = "null";
      });
    }
  }

  void _editHoraFin(BuildContext context, int index) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Hora de Cierre',
      initialEntryMode: TimePickerEntryMode.dial,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: kBrandSecundaryColor2, // Color primario para el tema
              onPrimary: Colors.white, // Color del texto cuando se selecciona
            ),
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      setState(() {
        horarios[index].horaFin =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00";
      });
    } else {
      setState(() {
        _checkboxSelected[index] = false;
        horarios[index].horaInicia = "null";
        horarios[index].horaFin = "null";
      });
    }
  }

  // Función para verificar si todos los días están cerrados
  bool isAllClosed(List<Horario> horarios) {
    for (int i = 0; i < horarios.length; i++) {
      if (horarios[i].horaInicia != "null" && horarios[i].horaFin != "null") {
        return false;
      }
    }
    return true;
  }

  // Función para manejar la acción del botón
  void handleGuardarCambios() {
    bool todosCerrados = isAllClosed(horarios);

    if (todosCerrados) {
      // Mostrar SnackBar si todos los días están cerrados
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Debe ingresar al menos un día de atencion'),
        ),
      );
    } else {
      // Imprimir todos los días si no todos están cerrados
      print("Horarios actuales:");
      horarios.forEach((horario) {
        print("${horario.dia}: ${horario.horaInicia} - ${horario.horaFin}");
      });
    }
  }

  RegisterBusinessModel _createBusinessModel() {
    return RegisterBusinessModel(
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
  }

  Future<void> _guardarDatos() async {
    print("!!!!!!!!!!!!!!");
    print("GUARDANDO DATOS EN FIREBASE");
    RegisterBusinessModel businessOwnerModel = _createBusinessModel();

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
            await _apiService.registrarNegocioToDB(_createBusinessModel());

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
                            builder: (context) => LoginNegocioPage()),
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
                                    typeOfHousing:
                                        widget.typeOfHousing.toString(),
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
                          textInputType: TextInputType.text,
                          maxLines: null,
                          maxLength: 250,
                          count: 250,
                        ),
                        divider20(),
                        InputTextFieldWidget(
                          labelText: "Nombre del negocio o emprendimiento",
                          controller: _nombreNegocioController,
                          icon: Icons.check_circle_outline,
                          textInputType: TextInputType.text,
                          maxLines: null,
                          maxLength: 250,
                          count: 250,
                        ),
                        divider40(),
                        Text("Dias de Atención"),
                        ListView.builder(
                          itemCount: horarios.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    offset: Offset(4, 4),
                                    blurRadius: 12.0,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: Checkbox(
                                  value: _checkboxSelected[index],
                                  activeColor: Colors.green,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _checkboxSelected[index] = value!;
                                      if (!_checkboxSelected[index]) {
                                        horarios[index].horaInicia = "null";
                                        horarios[index].horaFin = "null";
                                      } else {
                                        _editHoraInicia(context, index);
                                      }
                                    });
                                  },
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(capitalize(horarios[index].dia),
                                        style: TextStyle(fontSize: 18)),
                                    if (_checkboxSelected[index])
                                      Text(
                                        "${horarios[index].horaInicia} - ${horarios[index].horaFin}",
                                        style: TextStyle(fontSize: 14),
                                      )
                                    else
                                      Text(
                                        "Cerrado",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                  ],
                                ),
                                trailing: _checkboxSelected[index]
                                    ? IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () =>
                                            _editHoraInicia(context, index),
                                      )
                                    : Container(margin: EdgeInsets.only(right: 12.0),child: Icon(Icons.edit, color: Colors.grey)),
                              ),
                            );
                          },
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
                              bool todosCerrados = isAllClosed(horarios);
                              if (todosCerrados) {
                                mostrarSnackBar(
                                    "Debe ingresar al menos un día de atencion",
                                    2);
                              } else {
                                await _registrarYGuardarDatos();
                              }
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
          isLoading ? CircularLoadingWidget() : SizedBox(),
        ],
      ),
    );
  }
}
