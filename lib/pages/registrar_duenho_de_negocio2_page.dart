import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import '../models/categories_model.dart';

class RegistrarDuenhoDeNegocio2Page extends StatefulWidget {
  @override
  _RegistrarDuenhoDeNegocio2PageState createState() =>
      _RegistrarDuenhoDeNegocio2PageState();
}

class _RegistrarDuenhoDeNegocio2PageState
    extends State<RegistrarDuenhoDeNegocio2Page> {
  String? selectedCategoryId;
  late Future<List<Map<String, dynamic>>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();
    return categoriesSnapshot.docs.map((doc) {
      String id = doc.id;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {'id': id, 'data': data};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: kBrandPrimaryColor1,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final List<Map<String, dynamic>> categories = snapshot.data!;
              return GridView.count(
                crossAxisCount: 2,
                children: categories.map((category) {
                  final String id = category['id'];
                  final Map<String, dynamic> data = category['data'];
                  bool isSelected = selectedCategoryId == id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryId = id;
                        print(selectedCategoryId);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            getIconData(data['icon']),
                            color: isSelected ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.green : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case "shoppingBasket":
        return FontAwesomeIcons.shoppingBasket;
      case "pills":
        return FontAwesomeIcons.pills;
      case "wineBottle":
        return FontAwesomeIcons.wineBottle;
      case "paw":
        return FontAwesomeIcons.paw;
      case "headphonesAlt":
        return FontAwesomeIcons.headphonesAlt;
      case "tshirt":
        return FontAwesomeIcons.tshirt;
      case "dumbbell":
        return FontAwesomeIcons.dumbbell;
      case "spa":
        return FontAwesomeIcons.spa;
      case "couch":
        return FontAwesomeIcons.couch;
      case "baby":
        return FontAwesomeIcons.baby;
      case "bookOpen":
        return FontAwesomeIcons.bookOpen;
      case "userSecret":
        return FontAwesomeIcons.userSecret;
      case "leaf":
        return FontAwesomeIcons.leaf;
      case "gift":
        return FontAwesomeIcons.gift;
      case "smoking":
        return FontAwesomeIcons.smoking;
      default:
        return FontAwesomeIcons.questionCircle; // Icono por defecto
    }
  }
}
