import 'dart:async';
import 'package:flutter/material.dart';
import '../helps/sp.global.dart';
import 'home_page.dart';
import 'principal_page.dart';
import '../ui/widgets/background_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimer() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PreInit(),), (route) => false,);
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

  SPGlobal spglobal  = SPGlobal();

  @override
  Widget build(BuildContext context) {
    return spglobal.isLogin ? PrincipalPage() : HomePage();
  }
}