import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../helps/sp.global.dart';
import '../../ui/widgets/background_widget.dart';
import '../../ui/widgets/button_widget.dart';
import '../home_page.dart';

class PerfilNegocioPage extends StatelessWidget {

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _salirSesion(BuildContext context) async {
    await _auth.signOut();

    // Modificar SPGlobal para actualizar isLogin y userType
    SPGlobal spglobal = SPGlobal();
    await spglobal.initSharedPreferences();

    spglobal.isLogin = false;
    spglobal.userType = "";
    spglobal.token = ""; // Limpiar el token también

    print("spglobal.isLogin: ${spglobal.isLogin}");
    print("spglobal.userType: ${spglobal.userType}");
    print("spglobal.token: ${spglobal.token}");
    mostrarSnackBar(context, "Sesión cerrada");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
    );
  }

  void mostrarSnackBar(BuildContext context, String message) {
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
      body: BackGroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Informacion personal del usuario"),
              SizedBox(height: 40),
              ButtonWidget(
                onPressed: () {
                  _salirSesion(context);
                },
                text: "Salir",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
