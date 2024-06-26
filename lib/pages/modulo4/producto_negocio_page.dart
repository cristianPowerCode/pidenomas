import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/pages/modulo4/pedidos_negocio_page.dart';
import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widgets.dart';

class ProductoNegocioPage extends StatelessWidget {
  const ProductoNegocioPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            "Productos"),
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
                divider40(),
                divider20(),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Image.asset("assets/images/img_product.png")),
                ),
                divider40(),
                divider20(),
                Container(
                  child: Row(
                    children: [
                      Text(
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                          "Descuento"),
                      SizedBox(width: 30),
                      Container(
                        alignment: Alignment.center,
                        width: 165,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        child: Text(
                            style: TextStyle(
                              color: Colors.lightBlue[400],
                              fontWeight: FontWeight.bold,
                            ),
                            "52% OFF ends in 3 days"),
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
