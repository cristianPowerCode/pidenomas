import 'package:flutter/material.dart';

import '../../../ui/general/colors.dart';
import '../../../ui/widgets/general_widgets.dart';

class ListaProductosNegociosClientesPage extends StatelessWidget {
  const ListaProductosNegociosClientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Yoba",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 80,
                    height: 60,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ],
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
              // Add the new Column here
              divider12(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            divider12(),
                            Container(
                              height: 150,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Image.network(
                                    "https://acortar.link/xbDhri",
                                    fit: BoxFit.cover,
                                    width: double.infinity,

                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kBrandSecundaryColor1,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 40.0,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            divider12(),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'S/.13.00',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'S/.30.00',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '52% Of',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Bell Pepper Nutella karmen lopu..',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            divider12(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
