import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pidenomas/pages/modulo4/clientes/lista_negocios_clientes_page.dart';
import 'package:pidenomas/pages/modulo4/clientes/lista_productos_negocios_clientes_page.dart';
import 'package:pidenomas/pages/modulo4/clientes/perfil_clientes_page.dart';
import '../../../helps/sp.global.dart';
import '../../../ui/general/colors.dart';
import '../../../ui/widgets/background_widget.dart';
import '../../../ui/widgets/button_widget.dart';
import '../../home_page.dart';
import '../chat_negocio_page.dart';

class InicioClientesPage extends StatefulWidget {

  @override
  State<InicioClientesPage> createState() => _InicioClientesPageState();
}

class _InicioClientesPageState extends State<InicioClientesPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    ListaNegociosClientesPage(),
    ListaProductosNegociosClientesPage(),
    ChatNegocioPage(),
    PerfilClientesPage(),
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
              backgroundColor: kBrandSecundaryColor1,
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
                  icon: Icon(Icons.home),
                  label: "Inicio",
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
