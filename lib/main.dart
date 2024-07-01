import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pidenomas/pages/login_negocio_page.dart';
import 'package:pidenomas/pages/registrar_cliente1_page.dart';
import 'package:pidenomas/pages/registrar_negocio2_page.dart';
import 'package:pidenomas/pages/registrar_negocio4_page.dart';
import 'package:pidenomas/pages/registrar_negocio5_page.dart';
import 'package:pidenomas/pages/test1_page.dart';
import 'package:pidenomas/pages/test2_page.dart';

// import 'package:intl/date_symbol_data_local.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/pages/splash_page.dart';
import 'helps/sp.global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Necesario para iniciarlizar
  await Firebase.initializeApp(); // Inicializa Firebase
  SPGlobal spglobal = SPGlobal();
  await spglobal.initSharedPreferences(); // Inicializa SharedPreferences
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // colorSchemeSeed: Color(0xff6750A4),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: kBrandPrimaryColor1,
          cursorColor: kBrandPrimaryColor1,
          selectionColor: kBrandPrimaryColor1,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                kBrandPrimaryColor1, // Color de los botones de aceptar y cancelar
          ),
        ),
      ),
      title: 'Guardar en Firestore',
      home: SplashPage(),
      // home: Test2Page(),
      // home: RegistrarNegocio2Page(
      // nombre: "nombre",
      // apellidos: "apellidos",
      // fechaDeNacimiento: "fechaDeNacimiento",
      // celular: "celular",
      // tipoDocumento: "tipoDocumento",
      // documentoIdentidad: "documentoIdentidad",
      // genero: "genero",
      // email: "email",
      // password: "password"),
      //   home: RegistrarNegocio4Page(
      //       nombre: "Erick",
      //       apellidos: "Helera",
      //       fechaDeNacimiento: "1988-09-08",
      //       celular: "12021806",
      //       tipoDocumento: "1",
      //       documentoIdentidad: "12021806",
      //       genero: "1",
      //       email: "humbertpt14@gmail.com",
      //       password: "12345678",
      //       lat: "12.12",
      //       lng: "12.12",
      //       direccion: "Centenario 1000",
      //       detalleDireccion: "Av. Centenario N 1000",
      //       referenciaUbicacion: "antes del Av Centenario N 1010",
      //       typeOfHousing: "1",
      //       categoria: "2"),
      //   home: RegistrarNegocio5Page(
      //       nombre: "Nicolas",
      //       apellidos: "De Las Casas",
      //       fechaDeNacimiento: "1988-09-08",
      //       celular: "919072606",
      //       tipoDocumento: "1",
      //       documentoIdentidad: "919072606",
      //       genero: "1",
      //       email: "bowekog761@joeroc.com",
      //       password: "12345678",
      //       lat: "12.12",
      //       lng: "12.12",
      //       direccion: "Centenario 1000",
      //       detalleDireccion: "Detallado",
      //       referenciaUbicacion: "la referencia",
      //       typeOfHousing: "3",
      //       categoria: "6",
      //       fachadaExterna:
      //           "foto1",
      //       fachadaInterna:
      //           "foto2",
      //       docAnversoUrl:
      //           "foto3",
      //       docReversoUrl:
      //           "foto4"),
      // home: Test1Page()
    );
  }
}
