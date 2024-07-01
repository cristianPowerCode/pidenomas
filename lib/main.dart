import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pidenomas/pages/modulo4/agregar_producto_page.dart';
import 'package:pidenomas/pages/modulo4/clientes/inicio_clientes_page.dart';
import 'package:pidenomas/pages/modulo4/clientes/lista_negocios_clientes_page.dart';
import 'package:pidenomas/pages/modulo4/inicio_negocio_page.dart';
import 'package:pidenomas/pages/splash_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'helps/sp.global.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized(); //Necesario para iniciarlizar
  await Firebase.initializeApp(); // Inicializa Firebase
  SPGlobal spglobal = SPGlobal();
  await spglobal.initSharedPreferences(); // Inicializa SharedPreferences
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: kBrandPrimaryColor1,
          cursorColor: kBrandPrimaryColor1,
          selectionColor: kBrandPrimaryColor1,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kBrandPrimaryColor1, // Color de los botones de aceptar y cancelar
          ),
        ),
      ),
      title: 'Guardar en Firestore',
      // home: SplashPage(),
      home: SplashPage(),
    );
  }
}