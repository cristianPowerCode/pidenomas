import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/models/agregar_productos_model.dart';
import 'package:pidenomas/pages/modulo4/pedidos_negocio_page.dart';
import 'package:pidenomas/pages/modulo4/productos_negocio_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/button_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/photo_widget.dart';

import '../../models/response_model.dart';
import '../../services/agregar_productos_service.dart';
import '../../utils/functions/mostrar_snack_bar.dart';

const List<String> list = <String>['Lácteos'];

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

  AgregarProductosModel _addProducts() {
    return AgregarProductosModel(
      nombre: nombreController.text,
      precioRegular: double.parse(precioController.text),
      categoria: 1,
      imagen:
      "https://d20f60vzbd93dl.cloudfront.net/uploads/tienda_010816/tienda_010816_e6b8b7d7936401e3dd55db5a01aaf1b49386710d_producto_large_90.png",
      stock: _selectedValue,
      precioDescuento: double.parse(descuentoController.text),
      marca: marcaController.text,
      descripcion: "lorem ipsum",
    );
  }

  Future<void> _agregarProductosEnBD() async {
    try {
      print("Calling agregarProductosEnBD...");
      final AgregarProductosService service = AgregarProductosService();
      final ResponseModel response = await service.agregarProductosEnBD(_addProducts());
      if (response.status == 200) {
        print("Producto registrado exitosamente: ${response.message}");
        mostrarSnackBar(context, response.message, 3);
      } else {
        print("Error al registrar el producto: ${response.message}");
        mostrarSnackBar(context, "Hubo un problema al registrar en la BD: ${response.message}", 3);
      }
    } catch (e) {
      String errorMessage = e.toString();
      print("Error en _agregarProductosEnBD(): $errorMessage");
      mostrarSnackBar(context, "Hubo un problema al registrar en la BD: $errorMessage", 3);
    }
  }

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
                  color: kBrandPrimaryColor1,
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
              Navigator.pop(context);
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
                  TextField(
                    cursorColor: kBrandPrimaryColor1,
                    controller: nombreController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Nombre',
                      hintText: 'Ingrese el nombre del producto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(
                          color: kBrandPrimaryColor1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(
                          color: kBrandPrimaryColor1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(
                          color: kBrandPrimaryColor1,
                        ),
                      ),
                    ),
                  ),
                  divider20(),
                  Container(
                    width: size.width,
                    child: TextField(
                      cursorColor: kBrandPrimaryColor1,
                      controller: marcaController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'Marca',
                        hintText: 'Ingrese el nombre de la marca',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  divider20(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Inventario Disponible"),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12.0),
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
                                      ? kBrandPrimaryColor1
                                      : Colors.white,
                                  child: _selectedValue
                                      ? Icon(Icons.brightness_1_outlined,
                                          color: Colors.white, size: 16.0)
                                      : Icon(Icons.brightness_1_outlined,
                                          color: kBrandPrimaryColor1,
                                          size: 21.0),
                                ),
                              ),
                            ),
                            title: Text('Stock'),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
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
                                      ? kBrandPrimaryColor1
                                      : Colors.white,
                                  child: !_selectedValue
                                      ? Icon(Icons.brightness_1_outlined,
                                          color: Colors.white, size: 16.0)
                                      : Icon(Icons.brightness_1_outlined,
                                          color: kBrandPrimaryColor1,
                                          size: 21.0),
                                ),
                              ),
                            ),
                            title: Text('Sin Stock'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider20(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Precio Regular"),
                  ),
                  divider12(),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: kBrandPrimaryColor1,
                          width: 1.0,
                        ),
                        bottom: BorderSide(
                          color: kBrandPrimaryColor1,
                          width: 1.0,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: TextField(
                      cursorColor: kBrandPrimaryColor1,
                      controller: precioController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(color: kBrandPrimaryColor1),
                        labelText: 'Precio',
                        prefixText: 'S/. ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: kBrandPrimaryColor1,
                          ),
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                    ),
                  ),
                  divider20(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Precio con Descuento"),
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
                              activeColor: kBrandPrimaryColor1,
                              value: 3,
                              groupValue: _selectedValue2,
                              onChanged: (int? value) {
                                setState(() {
                                  _selectedValue2 = value;
                                });
                              },
                            ),
                            title: Text('Aplicar descuento'),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 170,
                          child: TextField(
                            cursorColor: kBrandPrimaryColor1,
                            controller: descuentoController,
                            enabled: _selectedValue2 == 3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: 'Precio con dscto',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: kBrandPrimaryColor1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: kBrandPrimaryColor1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(
                                  color: kBrandPrimaryColor1,
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
                    width: size.width,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      border: Border.all(
                        color: kBrandPrimaryColor1,
                        width: 1,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: kBrandPrimaryColor1,
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
                  Center(
                      child: PhotoWidget(
                          tipo: 1,
                          onPressedUploadPhoto: () {},
                          onPressedTakePhoto: () {},
                          loading: _isLoading)),
                  divider30(),
                  ButtonWidget(
                    onPressed: () {
                      _agregarProductosEnBD();
                    },
                    text: "Aceptar",
                    width: size.width,
                  ),
                  divider40(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
