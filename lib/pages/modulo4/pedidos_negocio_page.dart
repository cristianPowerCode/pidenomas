import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pidenomas/models/agregar_productos_model.dart';
import 'package:pidenomas/pages/modulo4/agregar_producto_page.dart';
import 'package:pidenomas/pages/modulo4/producto_negocio_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:flutter/services.dart';

import '../../models/obtener_productos_model.dart';
import '../../models/response_model.dart';
import '../../services/agregar_productos_service.dart';
import '../../services/get/obtener_productos_agregados_service.dart';
import '../../utils/functions/mostrar_snack_bar.dart';

class PedidosNegocioPage extends StatefulWidget {
  @override
  State<PedidosNegocioPage> createState() => _PedidosNegocioPageState();
}

class _PedidosNegocioPageState extends State<PedidosNegocioPage> {
  List<ObtenerProductosModel> productos = [];
  int productosCount = 0;

  @override
  void initState() {
    super.initState();
    obtenerProductos();
  }

  Future<void> obtenerProductos() async {
    try {
      print("Calling obtenerProductos...");
      final ObtenerProductosAgregadosService service =
          ObtenerProductosAgregadosService();
      final List<ObtenerProductosModel> productosObtenidos =
          await service.obtenerProductos();
      setState(() {
        productos = productosObtenidos;
        productosCount = productosObtenidos.length;
      });
      if (productosCount > 0) {
        print("Productos obtenidos exitosamente: $productosCount productos");
        for (var producto in productos) {
          print("Producto ID: ${producto.id}, Nombre: ${producto.nombre}");
        }
        mostrarSnackBar(context, "Productos obtenidos exitosamente", 3);
      } else {
        print("No se encontraron productos.");
        mostrarSnackBar(context, "No se encontraron productos.", 3);
      }
    } catch (e) {
      String errorMessage = e.toString();
      print("Error en _obtenerProductos(): $errorMessage");
      mostrarSnackBar(context,
          "Hubo un problema al obtener los productos: $errorMessage", 3);
    }
  }

  final List<String> imgList = [
    'https://via.placeholder.com/600/92c952',
    'https://via.placeholder.com/600/771796',
    'https://via.placeholder.com/600/24f355',
    'https://via.placeholder.com/600/d32776',
    'https://via.placeholder.com/600/f66b97',
    'https://via.placeholder.com/600/56a8c2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Inventario",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                divider12(),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 150.0,
                    autoPlay: true,

                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 400),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    viewportFraction:
                        0.9, // Agregado para tener espacio entre las imágenes
                  ),
                  items: imgList
                      .map((item) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            // Margen para separar las imágenes
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    item,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  right: 40,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Obtener Oferta',
                                      style:
                                          TextStyle(color: kBrandPrimaryColor2),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 4.0),
                                      // Personalizar el padding
                                      minimumSize: Size(0, 0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                divider12(),
                SearchBar(
                  hintText: "Buscar Categoria...",
                  leading: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: kBrandPrimaryColor1,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: kBrandPrimaryColor1.withOpacity(0.4),
                          offset: const Offset(4, 4),
                          blurRadius: 7.0,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
                divider20(),
                ElevatedButton(
                  onPressed: () {
                    for (var producto in productos) {
                      print("Producto subCategoria: ${producto.subCategoria}, Nombre: ${producto.nombre}");
                    }
                  },
                  child: Text("GET"),
                ),
                divider20(),
                productosCount == 0
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productosCount,
                        itemBuilder: (context, index) {
                          final item = productos[index];
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: const Offset(4, 4),
                                  blurRadius: 7.0,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                    child: Image.network(
                                      item.imagen,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "S/${item.precioRegular.toString()}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: kBrandPrimaryColor2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(
                                            "S/${item.precioDescuento.toString()}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        item.nombre,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: kBrandPrimaryColor2,
                                          ),
                                          child: Text(
                                            item.subCategoria,
                                            style: TextStyle(
                                              color: kBrandWhiteColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                divider30(),
                divider20(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          color: Colors.white,
          Icons.add,
          size: 40.0,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgregarProductoPage(),
              ));
        },
        shape: CircleBorder(
          side: BorderSide(
            color: kBrandSecundaryColor1,
            width: 1.0,
          ),
        ),
        backgroundColor: kBrandSecundaryColor1,
      ),
    );
  }
}
