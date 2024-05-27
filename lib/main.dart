import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'firebase_options.dart';
import 'package:pidenomas/pages/splash_page.dart';
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
      ),
      title: 'Guardar en Firestore',
      home: SplashPage(),
    );
  }
}