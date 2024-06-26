import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pidenomas/pages/modulo4/inicio_negocio_page.dart';
import '../helps/sp.global.dart';
import '../services/login_negocio_service.dart';
import '../ui/general/type_messages.dart';
import 'principal_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/input_textfield_password_widget.dart';
import '../ui/widgets/input_textfield_email_widget.dart';
import 'registrar_negocio1_page.dart';

class LoginNegocioPage extends StatefulWidget {
  const LoginNegocioPage({Key? key}) : super(key: key);

  @override
  State<LoginNegocioPage> createState() => _LoginNegocioPageState();
}

class _LoginNegocioPageState extends State<LoginNegocioPage> {
  final LoginNegocioService _loginNegocioService = LoginNegocioService();

  final TextEditingController _emailBusinessOwnerController =
      TextEditingController();
  final TextEditingController _passwordBusinessOwnerController =
      TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isRegistered = false;

  void _iniciarSesionNegocio() async {
    print("funcion iniciar sesion negocio");
    if (_formKey.currentState!.validate()) {
      print("formulario completado");
      setState(() {
        isLoading = true;
      });
      try {
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailBusinessOwnerController.text.trim(),
          password: _passwordBusinessOwnerController.text.trim(),
        );

        // Verificar si el correo electrónico está verificado
        if (!userCredential.user!.emailVerified) {
          mostrarSnackBar("Por favor, verifica si tiene el correo de confirmacion del registro de su negocio");
          await _auth.signOut(); // Cerrar sesión del usuario no verificado
          setState(() {
            isLoading = false;
          });
          return;
        }

        // Intentar login en el negocio
        final Map<String, dynamic> responseBody = await _loginNegocioToDB();
        final int? statusCode = responseBody['status'];

        if (statusCode == null) {
          mostrarSnackBar("Error al iniciar sesión: respuesta inválida del servidor");
          setState(() {
            isLoading = false;
          });
          return;
        }

        // Verificar el statusCode
        if (statusCode == 200) {
          final int negocioId = responseBody['id'] ?? 0; // Proporcionar un valor predeterminado

          // Configurar isLogin, userType y token en SPGlobal
          SPGlobal spglobal = SPGlobal();
          await spglobal.initSharedPreferences();
          spglobal.isLogin = true;
          spglobal.userType = "negocio";
          spglobal.token = negocioId.toString();
          print("SPGLOBALES:::::::::::::::::::::");
          print("spglobal.isLogin: ${spglobal.isLogin}");
          print("spglobal.userType: ${spglobal.userType}");
          print("spglobal.token: ${spglobal.token}");

          // Logueo con Éxito
          snackBarMessage(context, Typemessage.loginSuccess);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => InicioNegocioPage()),
                (route) => false,
          );
        } else {
          // Mostrar AlertDialog si el login al negocio falla
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(
                  child: PrincipalText(string: "Bienvenido a Pide Nomás"),
                ),
                content: Text(
                    textAlign: TextAlign.center,
                    "Espere la validacion del administrador para hacer uso del aplicativo"),
                actions: [
                  ButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: "Aceptar")
                ],
              );
            },
          );
          await _auth.signOut(); // Cerrar sesión del usuario no registrado
          setState(() {
            isLoading = false;
          });
          return; // Salir de la función
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'wrong-password':
            errorMessage = "La contraseña es incorrecta.";
            break;
          case 'user-not-found':
            errorMessage = "No se encontró un usuario con ese correo electrónico.";
            break;
          case 'user-disabled':
            errorMessage = "El usuario con este correo ha sido deshabilitado.";
            break;
          case 'too-many-requests':
            errorMessage = "Demasiados intentos. Inténtalo más tarde.";
            break;
          case 'operation-not-allowed':
            errorMessage = "El inicio de sesión con contraseña está deshabilitado.";
            break;
          default:
            errorMessage = "Error de autenticación: ${e.message}";
        }
        snackBarMessage2(context, Typemessage.incomplete, errorMessage);
        print("Error de autenticación: $e");
      } on SocketException catch (_) {
        // Error de conexión de red
        snackBarMessage(context, Typemessage.networkError);
        print("Error de conexión de red");
      } catch (e) {
        // Otros errores
        mostrarSnackBar("Error al iniciar sesión: $e");
        print("Error al iniciar sesión: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print("formulario incompleto");
    }
  }

  void mostrarSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<Map<String, dynamic>> _loginNegocioToDB() async {
    if (_formKey.currentState!.validate()) {
      print("El formulario no tiene campos vacíos");
      setState(() {
        isLoading = true;
      });
      try {
        print("Llamando a loginNegocioToDB...");
        final ApiResponse response = await _loginNegocioService.loginNegocio(
          _emailBusinessOwnerController.text.trim(),
          _passwordBusinessOwnerController.text.trim(),
        );

        final int statusCode = response.statusCode;
        final Map<String, dynamic> responseBody = response.data ?? {};

        if (statusCode == 200) {
          print("Registro exitoso en la BD");
          // Puedes manejar la lógica adicional aquí si es necesario
        } else {
          print("Error: Código de Estado no es 200");
          // Puedes manejar otros códigos de estado aquí si es necesario
        }

        return responseBody; // Retornar el responseBody para su uso externo
      } catch (error) {
        print("Error en catch: $error");
        mostrarSnackBar("Error en el inicio de sesión: $error");
        return {}; // Retornar un valor predeterminado o código de error
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      mostrarSnackBar("Por favor, complete todos los campos del formulario");
      setState(() {
        isLoading = false;
      });
      return {}; // Retornar un valor predeterminado o código de error
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: isLoading,
              child: BackGroundWidget(
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrincipalText(string: "Iniciar sesión"),
                          PrincipalText(string: "como Dueño de Negocio"),
                          divider20(),
                          const Text(
                            "Correo electrónico",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          InputTextFieldEmailWidget(
                            hintText: "Correo electrónico",
                            controller: _emailBusinessOwnerController,
                            textInputType: TextInputType.text,
                          ),
                          divider30(),
                          const Text(
                            "Contraseña",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xffB1B1B1)),
                          ),
                          InputTextFieldPasswordWidget(
                            controller: _passwordBusinessOwnerController,
                          ),
                          divider20(),
                          const Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "¿Olvidaste tu contraseña?",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: kBrandPrimaryColor1,
                              ),
                            ),
                          ),
                          divider20(),
                          ButtonWidget(
                            onPressed: () {
                              print("INICIANDO SESION");
                              FocusScope.of(context)
                                  .unfocus(); // esto minimiza el teclado
                              _iniciarSesionNegocio();
                            },
                            text: "Iniciar Sesión",
                            width: double.infinity,
                          ),
                          divider20(),
                          Row(
                            children: [
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Divider(color: Color(0xffB1B1B1))),
                              ),
                              Text(
                                "O",
                                style: TextStyle(color: Color(0xffB1B1B1)),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(color: Color(0xffB1B1B1))),
                              ),
                            ],
                          ),
                          divider40(),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "¿No tienes una cuenta?",
                                  style: TextStyle(
                                    color: kBrandPrimaryColor1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrarNegocio1Page(),
                                        ));
                                  },
                                  child: Text(
                                    "Registrate",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
}
