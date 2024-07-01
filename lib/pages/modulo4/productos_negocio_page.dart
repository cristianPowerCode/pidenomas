import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/obtener_productos_model.dart';
import '../../services/get/obtener_productos_agregados_service.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widgets.dart';
import '../../utils/functions/mostrar_snack_bar.dart';
import 'agregar_producto_page.dart';
import 'detalle_producto_negocio_page.dart';

class ProductosNegocioPage extends StatefulWidget {
  @override
  State<ProductosNegocioPage> createState() => _ProductosNegocioPageState();
}

class _ProductosNegocioPageState extends State<ProductosNegocioPage> {
  List<ObtenerProductosModel> productos = [];
  int productosCount = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    obtenerProductos();
    isLoading = true;
  }

  final List<String> imgList = [
    'https://acortar.link/Xw6Hzx',
    'https://acortar.link/Xw6Hzx',
  ];

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
        isLoading = false;
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
      isLoading = false;
    } catch (e) {
      String errorMessage = e.toString();
      print("Error en _obtenerProductos(): $errorMessage");
      mostrarSnackBar(context,
          "Hubo un problema al obtener los productos: $errorMessage", 3);
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Productos",
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
                divider40(),
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                            color: kBrandPrimaryColor1))
                    : (productosCount == 0
                        ? Center(
                            child: Text("No tiene ningún producto registrado"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: productosCount,
                            itemBuilder: (context, index) {
                              final item = productos[index];
                              return GestureDetector(
                                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ProductoNegocioPage(),));},
                                child: Container(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                                    decoration: TextDecoration
                                                        .lineThrough,
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                item.stock == true
                                                    ? Text("En Stock")
                                                    : Text(
                                                        "Sin Stock",
                                                        style: TextStyle(
                                                            color:
                                                                kBrandErrorColor),
                                                      ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color: kBrandPrimaryColor2,
                                                  ),
                                                  child: Text(
                                                    item.subCategoria,
                                                    style: TextStyle(
                                                      color: kBrandWhiteColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
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
