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
    String photoUploaded = "";

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: widget.tipo == 1
          ? Row(
        children: [
          GestureDetector(
            onTap: () {
              // Lógica para subir una foto
              print('Subir una foto');
            },
            child: Stack(
              children: [
                Container(
                  width: containerSize,
                  height: containerSize,
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
                    borderRadius: BorderRadius.circular(containerSize / 2),
                    child: Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.contain,
                      width: containerSize,
                      height: containerSize,
                    ),
                  )
                  )
                      : Center(child: CircularProgressIndicator(
                    color: kBrandPrimaryColor1,
                  )),


                ),
                // Si hay una imagen subida desaparece el circulo con (+)
                if(widget.loading == false)
                  if (widget.imageUrl == null)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: containerSize * 0.3,
                        height: containerSize * 0.3,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kBrandPrimaryColor1,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: containerSize * 0.2,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          // Botones SUBIR FOTO Y TOMAR FOTO
          widget.loading == false ? (
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [kBrandPrimaryColor1, kBrandPrimaryColor2],
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        print("SUBIR FOTO");
                        widget.onPressedUploadPhoto();
                        // Lógica para subir una foto
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        "Subir foto",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  const Text(
                    'desde la galería',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  divider20(),
                  Container(
                    width: screenWidth * 0.4,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [kBrandPrimaryColor1, kBrandPrimaryColor2],
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onPressedTakePhoto();
                        // Lógica para tomar una foto
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        "Tomar foto",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  const Text(
                    "con la cámara",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              )
          ): Row(
            children: [
              SizedBox(width: 16),
              ShimmerLoadingWidget(),
            ],
          ),
        ],
      )
          : Row(
        children: [
          Container(
            height: containerSize,
            width: containerSize,
            child: widget.imageUrl == null ?
            Stack(
              children: [
                Positioned(
                  bottom: containerSize * 0.1,
                  child: Container(
                    width: containerSize * 0.9,
                    height: containerSize * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(
                        color: kBrandPrimaryColor1,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: widget.loading == false ? ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        widget.assetDefault!,
                      ),
                    ) : Center(child: CircularProgressIndicator(
                      color: kBrandPrimaryColor1,
                    )),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: containerSize * 0.3,
                    height: containerSize * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kBrandPrimaryColor1,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: containerSize * 0.2,
                    ),
                  ),
                ),
              ],
            ):
            Stack(
              children: [
                Positioned(
                  bottom: containerSize * 0.1,
                  child: Container(
                    width: containerSize * 0.9,
                    height: containerSize * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(
                        color: kBrandPrimaryColor1,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        widget.imageUrl!,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(width: 16.0),
          // BOTONES SUBIR FOTO Y TOMAR FOTO
          widget.loading == false ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kBrandPrimaryColor1, kBrandPrimaryColor2],
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: ElevatedButton(
                  onPressed: widget.onPressedUploadPhoto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Subir foto",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Text(
                'desde la galería',
                style: TextStyle(fontSize: 16.0),
              ),
              divider20(),
              Container(
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kBrandPrimaryColor1, kBrandPrimaryColor2],
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: ElevatedButton(
                  onPressed: widget.onPressedTakePhoto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Tomar foto",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Text(
                "con la cámara",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ) : Row(
            children: [
              SizedBox(width: 16),
              ShimmerLoadingWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
