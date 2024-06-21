import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

class InventarioNegocioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Image.asset("assets/images/logo.png")),
                divider30(),
                Text(
                  "Bienvenido",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Rosario Chavez Torres",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                divider40(),
                Container(
                  width: double.infinity,
                  height: 250,
                  color: kBrandPrimaryColor1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
