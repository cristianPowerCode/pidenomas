import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pidenomas/pages/modulo4/clientes/inicio_clientes_page.dart';
import '../helps/sp.global.dart';
import 'home_page.dart';
import 'modulo4/inicio_negocio_page.dart';
import '../ui/widgets/background_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PreInit()),
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        child: Center(
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}

class PreInit extends StatelessWidget {
  SPGlobal spglobal = SPGlobal();

  @override
  Widget build(BuildContext context) {
    if (!spglobal.isLogin) {
      return HomePage();
    } else {
      if (spglobal.userType == "negocio") {
        return InicioNegocioPage();
      } else if (spglobal.userType == "cliente") {
        return InicioClientesPage();
      } else {
        // En caso de que userType no esté configurado o sea inválido, volver a HomePage
        return HomePage();
      }
    }
  }
}
