import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/general_widgets.dart';

class RegistrarCliente4Page extends StatefulWidget {
  const RegistrarCliente4Page({super.key});

  @override
  State<RegistrarCliente4Page> createState() => _RegistrarCliente4PageState();
}

class _RegistrarCliente4PageState extends State<RegistrarCliente4Page> {
  bool _showBottomSheet = false;
  late double _currentLatitude;
  late double _currentLongitude;

  // void _checkLocationPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permisos de ubicación denegados permanentemente, muestra mensaje al usuario.
  //   }
  //   if (permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always) {
  //     // Servicios de ubicación habilitados, establece _showBottomSheet en true.
  //     _getCurrentLocation();
  //     setState(() {
  //       _showBottomSheet = true;
  //     });
  //   }
  // }

  // void _getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     setState(() {
  //       _currentLatitude = position.latitude;
  //       _currentLongitude = position.longitude;
  //     });
  //   } catch (e) {
  //     print("!!!!!!!!!!!!!!!!!!!!!");
  //     print(e);
  //     print("!!!!!!!!!!!!!!!!!!!!!");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: kDefaultIconDarkColor.withOpacity(0.85),
            child: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: kBrandPrimaryColor1,
                  strokeWidth: 5,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: !_showBottomSheet
          ? Container(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Active su ubicación para continuar con el registro de su dirección',
                      ),
                      divider40(),
                      ButtonWidget(
                        onPressed: () {
                          // _checkLocationPermission();
                        },
                        text: "ACTIVAR UBICACIÓN",
                        width: double.infinity,
                        gradient: LinearGradient(
                          colors: [
                            kBrandSecundaryColor1,
                            kBrandSecundaryColor2
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }

}
