import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/pages/modulo4/pedidos_negocio_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() => runApp(const AgregarProductoPage());

class AgregarProductoPage extends StatefulWidget {
  const AgregarProductoPage({super.key});

  @override
  State<AgregarProductoPage> createState() => _AgregarProductoPageState();
}

class _AgregarProductoPageState extends State<AgregarProductoPage> {
  int _selectedValue = 1;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
              style: TextStyle(
                  color: kBrandPrimaryColor2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              "Añadir Producto"),
          centerTitle: true,
          leading: IconButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(kBrandSecundaryColor1),
              padding: WidgetStateProperty.all(EdgeInsets.only(left: 7.0)),
            ),
            icon: Icon(
              color: Colors.white,
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PedidosNegocioPage(),
                  ));
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  divider30(),
                  Container(
                    width: 330,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  divider20(),
                  Container(
                    width: 330,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Marca',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  divider20(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Inventario Disponible",
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            leading: Radio<int>(
                              activeColor: kBrandPrimaryColor2,
                              value: 1,
                              groupValue: _selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                            ),
                            title: Text('Stock'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            leading: Radio<int>(
                              activeColor: kBrandPrimaryColor2,
                              value: 2,
                              groupValue: _selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                            ),
                            title: Text('Sin Stock'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Inventario Disponible",
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            leading: Radio<int>(
                              activeColor: kBrandPrimaryColor2,
                              value: 3,
                              groupValue: _selectedValue,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue = value!;
                                });
                              },
                            ),
                            title: Text('Descuento'),
                          ),
                        ),
                        Container(
                          width: 170,
                          child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: 'Descuento',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: kBrandPrimaryColor2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: kBrandPrimaryColor2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: kBrandPrimaryColor2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider20(),
                  Container(
                    width: 330,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Precio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor2,
                          ),
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  divider20(),
                  Container(
                    width: 330,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.green,
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
