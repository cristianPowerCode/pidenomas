import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verificar que user no sea nulo antes de acceder a su propiedad uid
      if (userCredential.user != null) {
        // Guardar información adicional en Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
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
      // Implementar la autenticación con Google
      // Puedes utilizar plugins como google_sign_in para esto
      // Después de la autenticación exitosa, guarda la información adicional en Firestore
    } catch (e) {
      print('Error al registrar con Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
