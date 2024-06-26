import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/pages/modulo4/pedidos_negocio_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/button_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/photo_widget.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() => runApp(const AgregarProductoPage());

class AgregarProductoPage extends StatefulWidget {
  const AgregarProductoPage({super.key});

  @override
  State<AgregarProductoPage> createState() => _AgregarProductoPageState();
}

class _AgregarProductoPageState extends State<AgregarProductoPage> {
  bool _isLoading = false;
  bool _selectedValue = true;
  int? _selectedValue2;
  String dropdownValue = list.first;

  TextEditingController nombreController = TextEditingController();
  TextEditingController marcaController = TextEditingController();
  TextEditingController descuentoController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  @override
  void dispose() {
    // Limpiar los controladores al finalizar
    nombreController.dispose();
    marcaController.dispose();
    descuentoController.dispose();
    precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: TextField(
                      cursorColor: Colors.green,
                      controller: nombreController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Nombre',
                        hintText: 'Nombre del producto',
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
                  SizedBox(height: 20),
                  Container(
                    width: size.width,
                    child: TextField(
                      cursorColor: Colors.green,
                      controller: marcaController,
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Inventario Disponible"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            leading: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedValue = true;
                                });
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                child: CircleAvatar(
                                  backgroundColor: _selectedValue
                                      ? kBrandPrimaryColor2
                                      : Colors.white,
                                  child: _selectedValue
                                      ? Icon(Icons.brightness_1_outlined,
                                          color: Colors.white, size: 16.0)
                                      : Icon(Icons.brightness_1_outlined,
                                          color: Colors.green, size: 21.0),
                                ),
                              ),
                            ),
                            title: Text('Stock'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 0.0),
                            leading: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedValue = false;
                                });
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                child: CircleAvatar(
                                  backgroundColor: !_selectedValue
                                      ? kBrandPrimaryColor2
                                      : Colors.white,
                                  child: !_selectedValue
                                      ? Icon(Icons.brightness_1_outlined,
                                          color: Colors.white, size: 16.0)
                                      : Icon(Icons.brightness_1_outlined,
                                          color: Colors.green, size: 21.0),
                                ),
                              ),
                            ),
                            title: Text('Sin Stock'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Descuento"),
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
                              groupValue: _selectedValue2,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue2 = value;
                                });
                              },
                            ),
                            title: Text('Aplicar Descuento'),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 170,
                          child: TextField(
                            cursorColor: Colors.green,
                            controller: descuentoController,
                            enabled: _selectedValue2 == 3,
                            keyboardType: TextInputType.number,
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
                  SizedBox(height: 20),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ),
                        bottom: BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: TextField(
                      cursorColor: Colors.green,
                      controller: precioController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(color: Colors.green),
                        labelText: 'Precio',
                        prefixText: 'S/. ',
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
                  SizedBox(height: 20),
                  Container(
                    width: size.width,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.green,
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18.0),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                  divider40(),
                  PhotoWidget(tipo: 1, onPressedUploadPhoto: (){}, onPressedTakePhoto: (){}, loading: _isLoading ),
                  ButtonWidget(
                    onPressed: () {
                      print('Nombre: ${nombreController.text}');
                      print('Marca: ${marcaController.text}');
                      print(
                          'Inventario Disponible: ${_selectedValue ? "Stock" : "Sin Stock"}');
                      print('Aplicar Descuento: ${_selectedValue2 == 3}');
                      if (_selectedValue2 == 3) {
                        print('Descuento: ${descuentoController.text}');
                      }
                      print('Precio: ${precioController.text}');
                      print('Dropdown Value: $dropdownValue');
                    },
                    text: "Aceptar",
                    width: size.width,
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
