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
  bool isEnable = false;

  TextEditingController precioRegularController = TextEditingController();
  TextEditingController precioDescuentoController = TextEditingController();

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
        precioRegularController.text = precioRegular.toStringAsFixed(2);
        precioDescuentoController.text = precioDescuento.toStringAsFixed(2);
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
        title: Text(""),
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
                  ),
                ),
                divider40(),
                PriceRow(
                  label: "Precio Regular",
                  labelText: "Precio Regular",
                  controller: precioRegularController,
                  labelColor: kBrandGreyColor,
                  enable: isEnable,
                ),
                divider12(),
                PriceRow(
                  label: "Precio con Descuento",
                  labelText: "Precio con Descuento",
                  controller: precioRegularController,
                  labelColor: kBrandPrimaryColor1,
                  enable: isEnable,
                ),
                divider20(),
                Text(
                  "Descripcion:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  descripcion,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.lightBlue[400],
                  ),
                ),
                divider20(),
                Row(
                  children: [
                    Text(
                      "Categoria: ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    divider12(),
                    Text(
                      subCategoria,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                divider12(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: isStock
                              ? kBrandPrimaryColor1
                              : kBrandGreyColor,
                          width: 1.0,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "En Stock",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isStock
                            ? kBrandPrimaryColor1
                            : kBrandGreyColor,
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
                        border: Border.all(
                          color: isStock
                              ? kBrandGreyColor
                              : kBrandErrorColor,
                          width: 1.0,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sin Stock",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isStock
                                ? kBrandGreyColor
                                : kBrandErrorColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Color labelColor;
  final String labelText;
  final bool enable;

  PriceRow({
    required this.label,
    required this.controller,
    required this.labelColor,
    required this.labelText,
    required this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: labelColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enable,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              hintStyle: TextStyle(color: kBrandPrimaryColor1),
              labelText: labelText,
              prefixText: 'S/. ',
              prefixStyle: TextStyle(
                color: enable == true ? kBrandPrimaryColor1 : kBrandGreyColor,
              ),
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
      ],
    );
  }
}
