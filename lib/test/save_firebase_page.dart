import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pidenomas/test/login_page.dart';

class SaveFirbasePage extends StatefulWidget {
  @override
  State<SaveFirbasePage> createState() => _SaveFirbasePageState();
}

class _SaveFirbasePageState extends State<SaveFirbasePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _correoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _guardarDatos(String email, String password) async {
    try {
      // Accede a la instancia de Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Guarda un documento en la colección 'usuarios'
      DocumentReference<Map<String, dynamic>> user =
          await firestore.collection('users').add({
        'correo': email,
        'contraseña': password,
      });
      // Obtiene el correo del documento que acabas de guardar
      String correoRegistrado = (await user.get()).data()?['correo'];
      print('Datos guardados correctamente en Firestore.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Correo registrado: $correoRegistrado')),
      );
    } catch (e) {
      print('Error al guardar datos en Firestore: $e');
    }
  }

  Future<void> _registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verificar que user no sea nulo antes de acceder a su propiedad uid
      if (userCredential.user != null) {
        // Guardar información adicional en Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'password': password,
          // Otros campos que quieras almacenar
        });

        print('Usuario registrado con éxito.');
      }
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  Future<void> _registerWithGoogle() async {
    try {
      // Inicializar GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Sign in with Google
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Obtain the authentication details from the GoogleSignInAccount
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print(userCredential.user);

        // Verificar que user no sea nulo antes de acceder a su propiedad uid
        if (userCredential.user != null) {
          // Guardar información adicional en Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'displayName': userCredential.user!.displayName,
            'email': userCredential.user!.email,
            'IsVerified': userCredential.user!.emailVerified,
            'phoneNumber': userCredential.user!.phoneNumber,
            'photoURL': userCredential.user!.photoURL,
            'uid': userCredential.user!.uid,
            // Otros campos que desees almacenar
          });
          print('Usuario registrado con éxito.');
        }
      } else {
        // User canceled the sign-in process
        print('Inicio de sesión con Google cancelado.');
      }
    } catch (e) {
      print('Error al registrar con Google: $e');
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      print('Error2 al registrar con Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Registros"),
            SizedBox(height: 30.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Column(
                children: [
                  TextField(
                    controller: _correoController,
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para el registro con correo electrónico
                _registerWithEmail(
                  _correoController.text,
                  _passwordController.text,
                );
              },
              child: Text('Registrar con Correo Electrónico'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para el registro con Google
                // _registerWithGoogle();
                _registerWithGoogle();
              },
              child: Text('Registrar con Google'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _guardarDatos(
                  _correoController.text,
                  _passwordController.text,
                );
              },
              child: Text('Guardar en Firestore'),
            ),SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              },
              child: Text('Iniciar Sesion'),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
