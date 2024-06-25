import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pidenomas/ui/general/colors.dart';

import 'chat_negocio_page.dart';
import 'inventario_negocio_page.dart';
import 'pedidos_negocio_page.dart';
import 'perfil_negocio_page.dart';

class InicioNegocioPage extends StatefulWidget {
  @override
  State<InicioNegocioPage> createState() => _InicioNegocioPageState();
}

class _InicioNegocioPageState extends State<InicioNegocioPage> {
  int current_index = 0;

  final List<Widget> pages = [
    InventarioNegocioPage(),
    PedidosNegocioPage(),
    ChatNegocioPage(),
    PerfilNegocioPage(),
  ];

  void onTapped(int index) {
    setState(() {
      current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[current_index],
      bottomNavigationBar: Container(
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
              currentIndex: current_index,
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
              ]),
        ),
      ),
    );
  }
}