import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pidenomas/pages/modulo4/clientes/inicio_clientes_page.dart';
import '../services/login_negocio_service.dart';
import '../ui/general/type_messages.dart';
import 'principal_page.dart';
import 'registrar_cliente1_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/input_textfield_password_widget.dart';
import '../ui/widgets/input_textfield_email_widget.dart';

class LoginClientePage extends StatefulWidget {
  const LoginClientePage({Key? key}) : super(key: key);

  @override
  State<LoginClientePage> createState() => _LoginClientePageState();
}

class _LoginClientePageState extends State<LoginClientePage> {
  final TextEditingController _emailClientController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  _iniciarSesionCliente() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
          email: _emailClientController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Verificar si el correo electrónico está verificado
        if (!userCredential.user!.emailVerified) {
          mostrarSnackBar("Por favor, verifica tu correo electrónico antes de iniciar sesión.");
          await _auth.signOut(); // Cerrar sesión del usuario no verificado
          setState(() {
            isLoading = false;
          });
          return;
        }

        // Logueo con Éxito
        snackBarMessage(context, Typemessage.loginSuccess);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PrincipalPage()),
              (route) => false,
        );
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
        // Otros Errores
        mostrarSnackBar("Error al iniciar sesión");
        print("Error al iniciar sesión: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackGroundWidget(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrincipalText(string: "Iniciar sesión"),
                    PrincipalText(string: "como Cliente"),
                    divider20(),
                    const Text(
                      "Correo electrónico",
                      style:
                          TextStyle(fontSize: 12, color: Color(0xffB1B1B1)),
                    ),
                    InputTextFieldEmailWidget(
                      hintText: "Correo electrónico",
                      controller: _emailClientController,
                      textInputType: TextInputType.text,
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
                        _iniciarSesionCliente();
                        FocusScope.of(context).unfocus(); // esto minimiza el teclado
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
                          "Or",
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
                                        RegistrarCliente1Page(),
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
            ),
            isLoading
                ? Container(
              height: size.height,
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
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}
