import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pidenomas/pages/registrar_duenho_de_negocio1_page.dart';
import 'package:pidenomas/pages/registrar_duenho_de_negocio3_page.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/icon_form_button_widget.dart';
import '../models/categories_model.dart';
import '../ui/general/type_messages.dart';

class RegistrarDuenhoDeNegocio2Page extends StatefulWidget {
  final String nombre;
  final String apellidos;
  final String fechaDeNacimiento;
  final String celular;
  final String tipoDocumento;
  final String documentoIdentidad;
  final String genero;
  final String email;
  final String password;
  final String lat;
  final String lng;
  final String direccion;
  final String detalleDireccion;
  final String referenciaDireccion;
  final String agreeNotifications;
  final String typeOfHousing;

  RegistrarDuenhoDeNegocio2Page({
    required this.nombre,
    required this.apellidos,
    required this.fechaDeNacimiento,
    required this.celular,
    required this.tipoDocumento,
    required this.documentoIdentidad,
    required this.genero,
    required this.email,
    required this.password,
    required this.lat,
    required this.lng,
    required this.direccion,
    required this.detalleDireccion,
    required this.referenciaDireccion,
    required this.agreeNotifications,
    required this.typeOfHousing,
  });

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
    print("DATOS CAPTURADOS");
    print(
        "nombre: ${widget.nombre}, apellidos: ${widget.apellidos}, fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular}, tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad}, genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password}, lat: ${widget.lat}, lng: ${widget.lng}, direccion: ${widget.direccion}, detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaDireccion}, agreeNotifications: ${widget.agreeNotifications}, typeOfHousing: ${widget.typeOfHousing}");
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final QuerySnapshot categoriesSnapshot =
    await FirebaseFirestore.instance.collection('categories').get();
    return categoriesSnapshot.docs.map((doc) {
      String id = doc.id;
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {'id': id, 'data': data};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackGroundWidget(
          child: Column(
            children: [
              PrincipalText(string: "Cual categoria se adapta mejor a tu tienda"),
              divider12(),
              FutureBuilder<List<Map<String, dynamic>>>(
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
                    final List<Map<String, dynamic>> categories =
                    snapshot.data!;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
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
                                color: isSelected
                                    ? kBrandPrimaryColor1
                                    : Colors.grey,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  getIconData(data['icon']),
                                  color: isSelected
                                      ? kBrandPrimaryColor1
                                      : Colors.grey,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected
                                        ? kBrandPrimaryColor1
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              divider30(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconFormButtonWidget(
                    icon: Icon(FontAwesomeIcons.arrowLeft),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrarDuenhoDeNegocioPage(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 20.0),
                  IconFormButtonWidget(
                    isFormComplete: selectedCategoryId != null,
                    icon: Icon(FontAwesomeIcons.arrowRight),
                    onPressed: () {
                      if (selectedCategoryId != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrarDuenhoDeNegocio3Page(
                              nombre: widget.nombre,
                              apellidos: widget.apellidos,
                              fechaDeNacimiento: widget.fechaDeNacimiento,
                              celular: widget.celular,
                              tipoDocumento: widget.tipoDocumento,
                              documentoIdentidad: widget.documentoIdentidad,
                              genero: widget.genero,
                              email: widget.email,
                              password: widget.password,
                              lat: widget.lat,
                              lng: widget.lng,
                              direccion: widget.direccion,
                              detalleDireccion: widget.detalleDireccion,
                              referenciaDireccion: widget.referenciaDireccion,
                              agreeNotifications: widget.agreeNotifications,
                              categoria: selectedCategoryId!,
                            ),
                          ),
                        );
                      } else {
                        snackBarMessage(context, Typemessage.incomplete);
                      }
                    },
                  ),
                ],
              ),
              divider40(),
            ],
          ),
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
