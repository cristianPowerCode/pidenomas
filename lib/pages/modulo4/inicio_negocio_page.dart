import 'package:flutter/material.dart';
import 'package:pidenomas/pages/modulo4/agregar_producto_page.dart';
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
  int currentIndex = 0;

  final List<Widget> pages = [
    InventarioNegocioPage(),
    PedidosNegocioPage(),
    ChatNegocioPage(),
    PerfilNegocioPage(),
    AgregarProductoPage(),
  ];

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => pages[currentIndex],
          );
        },
      ),
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
    );
  }
}
