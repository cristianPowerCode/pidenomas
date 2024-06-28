import 'package:flutter/material.dart';
import 'package:pidenomas/pages/modulo4/agregar_producto_page.dart';
import 'package:pidenomas/pages/modulo4/productos_negocio_page.dart';
import 'package:pidenomas/ui/general/colors.dart';

import 'chat_negocio_page.dart';
import 'inventario_negocio_page.dart';
import 'pedidos_negocio_page.dart';
import 'perfil_negocio_page.dart';
import '../home_page.dart'; // Asegúrate de importar correctamente la HomePage si está en otro archivo

class InicioNegocioPage extends StatefulWidget {
  @override
  State<InicioNegocioPage> createState() => _InicioNegocioPageState();
}

class _InicioNegocioPageState extends State<InicioNegocioPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    InventarioNegocioPage(),
    PedidosNegocioPage(),
    ChatNegocioPage(),
    PerfilNegocioPage(),
    AgregarProductoPage(),
    ProductosNegocioPage(),
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Visibility(
        visible:
            !(ModalRoute.of(context)?.settings?.name == HomePage().toString()),
        // Oculta el BottomNavigationBar solo si la página actual es HomePage
        child: Container(
          height: 70,
          child: ClipRRect(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: kBrandPrimaryColor1,
              iconSize: 20.0,
              selectedIconTheme: IconThemeData(size: 28.0),
              selectedItemColor: Colors.white,
              unselectedItemColor: Color(0xff393939),
              selectedFontSize: 16.0,
              unselectedFontSize: 12.0,
              currentIndex: currentIndex,
              onTap: onTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined),
                  label: "Inventario",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag_outlined),
                  label: "Pedidos",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_outlined),
                  label: "Chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined),
                  label: "Perfil",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
