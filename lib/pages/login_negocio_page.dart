import 'package:flutter/material.dart';
import '../ui/widgets/background_widget.dart';

class LoginNegocioPage extends StatelessWidget {
  const LoginNegocioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        child: Center(
          child: Text("Logueo de Negocio"),
        ),
      ),
    );
  }
}
