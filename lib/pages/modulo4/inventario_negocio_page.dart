import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/button_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

class InventarioNegocioPage extends StatefulWidget {
  @override
  _InventarioNegocioPageState createState() => _InventarioNegocioPageState();
}

class _InventarioNegocioPageState extends State<InventarioNegocioPage> {
  int _selectedValue = 1;

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
                    width: MediaQuery.of(context).size.width / 2,
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
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        width: 1,
                        color: kBrandPrimaryColor1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            padding: EdgeInsets.all(25.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Usar plantilla",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Predeterminada",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Radio<int>(
                                      activeColor: kBrandSecundaryColor1,
                                      fillColor: WidgetStateProperty
                                          .resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return Colors.yellow;
                                          }
                                          return Colors.yellow;
                                        },
                                      ),
                                      value: 1,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          divider20(),
                          Container(
                            width: double.infinity,
                            height: 120,
                            padding: EdgeInsets.all(25.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Agregar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Manualmente",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Radio<int>(
                                      activeColor: kBrandSecundaryColor1,
                                      fillColor: WidgetStateProperty
                                          .resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return Colors.yellow;
                                          }
                                          return Colors.yellow;
                                        },
                                      ),
                                      value: 2,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          divider12(),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kBrandSecundaryColor1),
                              ),
                              onPressed: () {
                                // Acción del botón aceptar
                              },
                              child: Text(
                                'Aceptar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
