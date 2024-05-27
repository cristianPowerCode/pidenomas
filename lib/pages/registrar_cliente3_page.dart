import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'registrar_cliente_4_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/appbar_degrade_widget.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/underline_input_textfield_widget.dart';
// import 'package:location/location.dart';

class RegistrarCliente3Page extends StatefulWidget {
  const RegistrarCliente3Page({super.key});

  @override
  State<RegistrarCliente3Page> createState() => _RegistrarCliente3PageState();
}

class _RegistrarCliente3PageState extends State<RegistrarCliente3Page> {
  // final Completer<GoogleMapController> _mapController =
  // Completer<GoogleMapController>();
  late double _currentLatitude;
  late double _currentLongitude;
  bool isLoading = false;
  // Location _locationController = new Location();
  // LatLng? _currentP = null;

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _cameraToPosition(LatLng pos) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   CameraPosition _newCameraPosition = CameraPosition(
  //     target: pos,
  //     zoom: 13,
  //   );
  //   await controller.animateCamera(
  //     CameraUpdate.newCameraPosition(_newCameraPosition),
  //   );
  // }

  // Future<void> getLocationUpdates() async {
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await _locationController.serviceEnabled();
  //   if (_serviceEnabled) {
  //     _serviceEnabled = await _locationController.requestService();
  //   } else {
  //     return;
  //   }
  //
  //   _permissionGranted = await _locationController.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await _locationController.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _locationController.onLocationChanged
  //       .listen((LocationData currentLocation) {
  //     if (currentLocation.latitude != null &&
  //         currentLocation.longitude != null) {
  //       setState(() {
  //         _currentP =
  //             LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //         _cameraToPosition(_currentP!);
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // CameraPosition _kGooglePlex = CameraPosition(
    //   target: LatLng(_currentLatitude, _currentLongitude),
    //   zoom: 14.4746,
    // );
    return !isLoading
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
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
          )
        : Scaffold(
            appBar: AppBarDegradeWidget(
              text: "Crear nueva dirección",
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue.withOpacity(0.4),
                      height: 400,
                      child: Stack(
                        children: [
                          // GoogleMap(
                          //   mapType: MapType.terrain,
                          //   zoomControlsEnabled: false,
                          //   initialCameraPosition: _kGooglePlex,
                          //   onMapCreated: ((GoogleMapController controller) =>
                          //       _mapController.complete(controller)),
                          //   markers: {
                          //     Marker(
                          //       markerId: MarkerId("_currentLocation"),
                          //       icon: BitmapDescriptor.defaultMarker,
                          //       position: LatLng(_currentLatitude, _currentLongitude)
                          //     ),
                          //   },
                          // ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton.small(
                                onPressed: (){},
                                child: Icon(
                                  Icons.location_searching,
                                  color: Colors.white,
                                ),
                                backgroundColor: kBrandSecundaryColor1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    divider40(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Text("Ubicación del negocio"),
                          divider12(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Indica la dirección de tu negocio"),
                          ),
                          UnderLineInputTextFieldWidget(
                            hintText: "Calle Real #1550 Huancayo",
                          ),
                          divider40(),
                          ButtonWidget(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrarCliente4Page(),
                                  ));
                            },
                            text: "CONTINUAR",
                            width: double.infinity,
                            gradient: LinearGradient(
                              colors: [
                                kBrandSecundaryColor1,
                                kBrandSecundaryColor2,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}