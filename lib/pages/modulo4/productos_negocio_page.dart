import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../ui/general/colors.dart';
import '../../ui/widgets/general_widgets.dart';
import 'agregar_producto_page.dart';

class ProductosNegocioPage extends StatelessWidget {
  final List<String> imgList = [
    'https://acortar.link/Xw6Hzx',
    'https://acortar.link/PPSBbp',
    'https://acortar.link/Xw6Hzx',
    'https://acortar.link/PPSBbp',
    'https://acortar.link/Xw6Hzx',
    'https://acortar.link/PPSBbp',
    'https://acortar.link/Xw6Hzx',
    'https://acortar.link/PPSBbp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Align(
                  alignment: Alignment.center,
                  child: Text("No tiene ningún producto registrado")),
            ],
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
