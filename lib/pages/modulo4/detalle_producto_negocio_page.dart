import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/models/obtener_detalle_productos_model.dart';
import 'package:pidenomas/pages/modulo4/pedidos_negocio_page.dart';
import 'package:pidenomas/services/get/obtener_detalle_producto_service.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widgets.dart';
import '../../utils/functions/mostrar_snack_bar.dart';

class ProductoNegocioPage extends StatefulWidget {
  final int idProducto;

  ProductoNegocioPage({required this.idProducto});

  @override
  State<ProductoNegocioPage> createState() => _ProductoNegocioPageState();
}

class _ProductoNegocioPageState extends State<ProductoNegocioPage> {
  @override
  void initState() {
    super.initState();
    detalleProducto();
  }

  String nombreProducto = "?????";
  String imagenProducto = "";
  bool isStock = false;
  double precioRegular = 0;
  double precioDescuento = 0;
  String marcaProducto = "";
  String subCategoria = "?????";
  String descripcion = "?????";

  TextEditingController precioController = TextEditingController();

  Future<void> detalleProducto() async {
    try {
      print("Calling obtenerProductos...");
      final ObtenerDetalleProductoService service =
          ObtenerDetalleProductoService();
      final ObtenerDetalleProductoModel detalleProducto =
          await service.obtenerDetalleProducto(widget.idProducto);
      setState(() {
        nombreProducto = detalleProducto.nombre;
        imagenProducto = detalleProducto.imagen;
        isStock = detalleProducto.stock;
        precioRegular = detalleProducto.precioRegular;
        precioDescuento = detalleProducto.precioDescuento;
        marcaProducto = detalleProducto.marca;
        subCategoria = detalleProducto.subCategoria;
        descripcion = detalleProducto.descripcion;
        // isLoading = false;
      });
      // isLoading = false;
    } catch (e) {
      String errorMessage = e.toString();
      print("Error en _obtenerProductos(): $errorMessage");
      mostrarSnackBar(context,
          "Hubo un problema al obtener los productos: $errorMessage", 3);
      // isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            // "Productos"),
            ""),
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
                divider20(),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      nombreProducto,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    )),
                divider40(),
                Center(
                  child: Container(
                    color: kBrandWhiteColor,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      child: Image.network(imagenProducto),
                ),),
                divider40(),
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 60,
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.lightBlue[400],
                              fontWeight: FontWeight.bold,
                            ),
                            "Precio Regular"),
                      ),
                      SizedBox(width: 30),
                      Container(
                        alignment: Alignment.center,
                        width: 175,
                        height: 50,
                        child: Text(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            "Bell Pepper Nutella karmen lopu Karmen mon"),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 60,
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.lightBlue[400],
                              fontWeight: FontWeight.bold,
                            ),
                            "Nombre del producto"),
                      ),
                      SizedBox(width: 30),
                      Container(
                        alignment: Alignment.center,
                        width: 175,
                        height: 50,
                        child: Text(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            "Bell Pepper Nutella karmen lopu Karmen mon"),
                      ),
                    ],
                  ),
                ),
                divider12(),
                Text(
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.lightBlue[400],
                    ),
                    "Presentacion: 1kg"),
                Text(
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    "Categories : solip , kolimatrio , hellop , mafirat , mop lopiranto"),
                divider12(),
                Container(
                  width: size.width,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.lightBlue),
                      hintStyle: TextStyle(color: Colors.lightBlue),
                      labelText: 'Precio:',
                      prefixText: 'S/. ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                divider12(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border:
                              Border.all(color: Colors.lightBlue, width: 1.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Stock",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue, // Color del texto
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18.0),
                          border:
                              Border.all(color: Colors.lightBlue, width: 1.0),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Fuera de Stock",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue, // Color del texto
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
      ),
    );
  }
}
