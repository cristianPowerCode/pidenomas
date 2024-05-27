import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/test2_page.dart';
import '../ui/widgets/general_widgets.dart';

class Test1Page extends StatefulWidget {
  @override
  _Test1PageState createState() => _Test1PageState();
}

class _Test1PageState extends State<Test1Page> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _displayNameController;

  late final StreamSubscription<User?> _firebaseStreamEvents;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _displayNameController = TextEditingController(); // Inicializa _displayNameController

    // Suscribirse a los cambios en el estado de autenticación de Firebase
    _firebaseStreamEvents = FirebaseAuth.instance.authStateChanges().listen((user) {
      print(user);
      if (user != null) {
        // Si el usuario está autenticado, enviar correo de verificación
        user.sendEmailVerification();
      }
    });
  }

  @override
  void dispose() {
    // Cancelar la suscripción para evitar fugas de memoria
    _firebaseStreamEvents.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _displayNameController, // Usa _displayNameController en TextField
              decoration: InputDecoration(
                labelText: 'Nombre de usuario',
              ),
            ),
            divider20(),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            divider20(),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            divider40(),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Registrar el usuario en Firebase Auth
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ).then((userCredential) async {
                    // Obtén el nombre de usuario desde el TextField y actualiza el nombre de usuario en Firebase
                    String displayName = _displayNameController.text.trim();
                    await userCredential.user!.updateDisplayName(displayName);

                    // Navegar a la siguiente página
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Test2Page()),
                    );
                  }).catchError((error) {
                    // Manejar errores durante el registro
                    print('Error durante el registro: $error');
                  });

                } on FirebaseAuthException catch (e) {
                  if (e.code == "weak-password") {
                    print('La contraseña proporcionada es demasiado débil.');
                  } else if (e.code == "email-already-in-use") {
                    print('Ya existe una cuenta para ese correo electrónico.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Registrarse"),
            ),
          ],
        ),
      ),
    );
  }
}