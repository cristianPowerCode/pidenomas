import 'package:flutter/material.dart';
import '../ui/widgets/background_widget.dart';
import 'login_cliente_page.dart';
import 'login_negocio_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/general_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackGroundWidget(
          child: Column(
            children: [
              Image.asset("assets/images/logo.png",),
              divider40(),
              Center(
                child: Column(
                  children: [
                    const Text("Bienvenido a",
                        style: TextStyle(
                          fontSize: 24.0,
                        )),
                    divider12(),
                    const Text("Pide Nomás",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        )),
                    divider40(),
                    SizedBox(
                      width: double.infinity,
                      height: 54.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(
                            width: 1,
                            color: kBrandSecundaryColor1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginNegocioPage(),
                                ));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Test1Page()));
                          },
                          child: Text(
                            "Soy Negocio",
                            style: TextStyle(
                                fontSize: 20.0, color: kBrandSecundaryColor1),
                          ),
                        ),
                      ),
                    ),
                    divider30(),
                    SizedBox(
                      width: double.infinity,
                      height: 54.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              kBrandSecundaryColor1,
                              kBrandSecundaryColor2,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginClientePage(),
                                ));
                          },
                          child: Text(
                            "Soy Cliente",
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
