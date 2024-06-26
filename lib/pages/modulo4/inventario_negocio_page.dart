import 'package:flutter/material.dart';
import 'package:pidenomas/pages/modulo4/productos_negocio_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/button_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

class InventarioNegocioPage extends StatefulWidget {
  @override
  _InventarioNegocioPageState createState() => _InventarioNegocioPageState();
}

class _InventarioNegocioPageState extends State<InventarioNegocioPage> {
  int _selectedValue = 1;
  bool isSelected = false;

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
                  child: Image.asset("assets/images/logo.png"),
                ),
                SizedBox(height: 30),
                Text(
                  "Bienvenido",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Rosario Chavez Torres",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(
                      width: 2,
                      color: kBrandPrimaryColor1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedValue = 1;
                              print(_selectedValue);
                            });
                          },
                          child: Container(
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
                                Container(
                                  width: 150,
                                  child: Text(
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      'Usar plantilla preterminada'),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: _selectedValue,
                                  activeColor: kBrandSecundaryColor1,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedValue = 2;
                              print(_selectedValue);
                            });
                          },
                          child: Container(
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
                                Container(
                                  width: 150,
                                  child: Text(
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                      'Agregar Manualmante'),
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: _selectedValue,
                                  activeColor: kBrandSecundaryColor1,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  kBrandSecundaryColor1),
                            ),
                            onPressed: () {
                              if (_selectedValue == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductosNegocioPage(),
                                  ),
                                );
                              } else {
                                print('primer contenedor');
                              }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
