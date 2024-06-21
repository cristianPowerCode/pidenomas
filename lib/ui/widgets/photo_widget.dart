import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/shimmer_loading_widget.dart';

class PhotoWidget extends StatefulWidget {
  final int tipo;
  final IconData? icon;
  final String? imageUrl;
  final String? assetDefault;
  void Function() onPressedUploadPhoto;
  void Function() onPressedTakePhoto;
  final bool loading;

  PhotoWidget({
    required this.tipo,
    this.icon,
    this.imageUrl,
    this.assetDefault = "assets/images/perfil.jpg",
    required this.onPressedUploadPhoto,
    required this.onPressedTakePhoto,
    required this.loading,
  });

  @override
  _PhotoWidgetState createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var containerSize = screenWidth * 0.3;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: widget.tipo == 1
          ? Stack(
              children: [
                Container(
                  width: containerSize,
                  height: containerSize,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: kBrandPrimaryColor1,
                      width: 2.0,
                    ),
                  ),
                  child: widget.loading == false
                      ? (widget.imageUrl == null
                          ? Icon(
                              widget.icon,
                              color: kBrandPrimaryColor1,
                              size: containerSize * 0.5,
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(containerSize / 2),
                              child: Image.network(
                                widget.imageUrl!,
                                fit: BoxFit.contain,
                                width: containerSize,
                                height: containerSize,
                              ),
                            ))
                      : Center(
                          child: CircularProgressIndicator(
                          color: kBrandPrimaryColor1,
                        )),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton.filled(
                    icon: Icon(Icons.image, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: kBrandPrimaryColor1,
                    ),
                    color: kBrandPrimaryColor1,
                    iconSize: containerSize * 0.2,
                    onPressed: () {
                      print("SUBIR FOTO");
                      widget.onPressedUploadPhoto();
                      // Lógica para subir una foto
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton.filled(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: kBrandPrimaryColor1,
                    ),
                    color: kBrandPrimaryColor1,
                    iconSize: containerSize * 0.2,
                    onPressed: () {
                      print("SUBIR FOTO");
                      widget.onPressedTakePhoto();
                      // Lógica para tomar una foto
                    },
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                Positioned(
                  child: Container(
                    width: containerSize * 0.9,
                    height: containerSize * 0.8,
                    margin: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(
                        color: kBrandPrimaryColor1,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: widget.loading == false
                        ? (widget.imageUrl == null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.asset(
                                  widget.assetDefault!,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: Image.network(
                                  widget.imageUrl!,
                                ),
                              ))
                        : Center(
                            child: CircularProgressIndicator(
                            color: kBrandPrimaryColor1,
                          )),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton.filled(
                    icon: Icon(Icons.image, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: kBrandPrimaryColor1,
                    ),
                    color: kBrandPrimaryColor1,
                    iconSize: containerSize * 0.2,
                    onPressed: () {
                      print("SUBIR FOTO");
                      widget.onPressedUploadPhoto();
                      // Lógica para subir una foto
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton.filled(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: kBrandPrimaryColor1,
                    ),
                    color: kBrandPrimaryColor1,
                    iconSize: containerSize * 0.2,
                    onPressed: () {
                      print("SUBIR FOTO");
                      widget.onPressedTakePhoto();
                      // Lógica para tomar una foto
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
