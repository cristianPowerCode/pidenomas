import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _correoController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isLogin = false;
  bool _isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  iniciarSesion() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: _correoController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isLogin = true;
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inicio de sesión exitoso")),
      );
    } catch (e) {
      print("Error al iniciar sesión: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al iniciar sesión")),
      );
      setState(() {
        _isLogin = false;
        _isLoading = false;
      });
    }
  }
  // Función para iniciar sesión con Google
  iniciarSesionConGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Intentar iniciar sesión con las credenciales de Google
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      setState(() {
        _isLogin = true;
        _isLoading = false;
      });
      mostrarSnackbar("Inicio de sesión con Google exitoso");
    } catch (e) {
      if (e is FirebaseAuthException) {
        mostrarSnackbar("Error al iniciar sesión con Google: ${e.message}");
      } else {
        mostrarSnackbar("Error inesperado al iniciar sesión con Google.");
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Función para cerrar sesión
  salirSesion() async {
    await _auth.signOut();
    setState(() {
      _isLogin = false;
    });
    mostrarSnackbar("Sesión cerrada");
  }

  // Función para mostrar el Snackbar
  void mostrarSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Iniciar Sesion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Inicie Sesion"),
            SizedBox(height: 10.0),
            Text(
              "STATUS ${_isLogin ? "ON" : "OFF"}",
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Column(
                children: [
                  TextField(
                    controller: _correoController,
                    decoration: InputDecoration(labelText: 'Correo'),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  _isLoading ? null : (_isLogin ? salirSesion : iniciarSesionConGoogle),
              child: _isLoading
                  ? CircularProgressIndicator() // Muestra el CircularProgressIndicator si isLoading es true
                  : Text(_isLogin ? 'Cerrar Sesión' : 'Iniciar Sesión'),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
