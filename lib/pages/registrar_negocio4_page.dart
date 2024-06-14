import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pidenomas/pages/registrar_cliente3_page.dart';
import 'package:pidenomas/pages/registrar_negocio3_page.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/photo_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/button_widget.dart';
import '../ui/widgets/icon_form_button_widget.dart';
import 'registrar_negocio5_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class RegistrarNegocio4Page extends StatefulWidget {
  String nombre;
  String apellidos;
  String email;
  String celular;
  String tipoDocumento;
  String fechaDeNacimiento;
  String documentoIdentidad;
  String genero;
  String password;
  String lat;
  String lng;
  String direccion;
  String detalleDireccion;
  String referenciaUbicacion;
  String typeOfHousing;
  String categoria;

  RegistrarNegocio4Page({
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
    required this.referenciaUbicacion,
    required this.typeOfHousing,
    required this.categoria,
  });

  @override
  State<RegistrarNegocio4Page> createState() => _RegistrarNegocio4PageState();
}

class _RegistrarNegocio4PageState extends State<RegistrarNegocio4Page> {
  Future<void> _checkPermissions() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }

    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  @override
  void initState() {
    super.initState();
    print("PAGINA 4");
    print('''nombre: ${widget.nombre}, apellidos: ${widget.apellidos},
fechaDeNacimiento: ${widget.fechaDeNacimiento}, celular: ${widget.celular},
tipoDocumento: ${widget.tipoDocumento}, docIdentidad: ${widget.documentoIdentidad},
genero: ${widget.genero}, email: ${widget.email}, password: ${widget.password},
lat: ${widget.lat}, lng: ${widget.lng}, direccion: ${widget.direccion},
detalleDireccion: ${widget.detalleDireccion}, referencia: ${widget.referenciaUbicacion},
tipo de inmueble: ${widget.typeOfHousing}, category: ${widget.categoria}''');
    _checkPermissions();
  }

  String? fachadaInterna;
  String? fachadaExterna;
  String? docAnversoUrl;
  String? docReversoUrl;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePickerActive = false;
  bool loading = false;

  // Función _uploadPhoto
  void _uploadPhoto(Function(String) setUrl, String path) async {
    try {
      setState(() {
        loading = true; // Mostrar indicador de progreso
      });

      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print("Imagen seleccionada correctamente: ${pickedFile.path}");
        final url = await uploadImageToFirebase(File(pickedFile.path), path);
        if (url.isNotEmpty) {
          print("URL de imagen obtenida: $url");
          setState(() {
            setUrl(url);
            loading = false; // Ocultar indicador de progreso
          });
          print("URL asignada correctamente");
        } else {
          print("La URL de la imagen está vacía");
          setState(() {
            loading = false;
          });
        }
      } else {
        print("No se seleccionó ninguna imagen");
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print("Error en la carga de la imagen: $e");
      setState(() {
        loading = false; // Ocultar indicador de progreso en caso de error
      });
    }
  }

  // Función para tomar la foto con la cámara
  void takePhoto(Function(String) setUrl, String path) async {
    final ImagePicker _picker = ImagePicker();

    if (_isImagePickerActive) {
      print("El selector de imágenes ya está activo.");
      return;
    }

    setState(() {
      loading = true; // Mostrar indicador de progreso
      _isImagePickerActive = true;
    });

    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final url = await uploadImageToFirebase(File(pickedFile.path), path);
        setState(() {
          setUrl(url);
          loading = false; // Ocultar indicador de progreso
        });
      }
    } catch (e) {
      print("Error al tomar la foto: $e");
      setState(() {
        loading = false; // Ocultar indicador de progreso en caso de error
      });
    } finally {
      setState(() {
        _isImagePickerActive = false;
      });
    }
  }

  // Función para subir la imagen a Firebase Storage
  Future<String> uploadImageToFirebase(File image, String path) async {
    try {
      print("Subiendo imagen a Firebase...");
      final storageRef = FirebaseStorage.instance.ref().child(path);
      await storageRef.putFile(image);
      print("Imagen subida correctamente");
      return await storageRef.getDownloadURL();
    } catch (e) {
      print("Error al subir la imagen a Firebase: $e");
      return ""; // Retorna una cadena vacía en caso de error
    }
  }

  // Ajustamos la función mostrarSnackBar para aceptar la duración como parámetro
  void mostrarSnackBar(String message, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
        backgroundColor: kErrorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: BackGroundWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrincipalText(string: "Ya falta poco..."),
              divider40(),
              PrincipalText(
                  string: "Suba una foto de la fachada interna del negocio"),
              PhotoWidget(
                tipo: 1,
                icon: Icons.storefront,
                loading: loading,
                onPressedUploadPhoto: () => _uploadPhoto(
                    (url) => fachadaInterna = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-fachada-interna.jpg"),
                onPressedTakePhoto: () => takePhoto(
                    (url) => fachadaInterna = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-fachada-interna.jpg"),
                imageUrl: fachadaInterna,
              ),
              divider40(),
              PrincipalText(
                  string: "Suba una foto de la fachada externa del negocio"),
              PhotoWidget(
                tipo: 1,
                icon: Icons.storefront,
                loading: loading,
                onPressedUploadPhoto: () => _uploadPhoto(
                    (url) => fachadaExterna = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-fachada-externa.jpg"),
                onPressedTakePhoto: () => takePhoto(
                    (url) => fachadaExterna = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-fachada-externa.jpg"),
                imageUrl: fachadaExterna,
              ),
              divider40(),
              PrincipalText(
                  string: "Suba una foto de su documento de indentidad"),
              Text(
                "La foto debe ser lo más nitido posible para contrastar sus datos",
                style: TextStyle(
                    color: Colors.black45, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
              divider12(),
              PhotoWidget(
                tipo: 2,
                assetDefault: "assets/images/docIdentidadAnverso.jpg",
                loading: loading,
                onPressedUploadPhoto: () => _uploadPhoto(
                    (url) => docAnversoUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-docIdentidadAnverso.jpg"),
                onPressedTakePhoto: () => takePhoto(
                    (url) => docAnversoUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-docIdentidadAnverso.jpg"),
                imageUrl: docAnversoUrl,
              ),
              divider40(),
              PrincipalText(
                  string:
                      "Suba una foto del reverso de su documento de indentidad"),
              Text(
                "Esta foto tambien debe ser lo más nitido posible para contrastar sus datos",
                style: TextStyle(
                    color: Colors.black45, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
              divider12(),
              PhotoWidget(
                tipo: 2,
                assetDefault: "assets/images/docIdentidadReverso.jpg",
                loading: loading,
                onPressedUploadPhoto: () => _uploadPhoto(
                    (url) => docReversoUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-docIdentidadReverso.jpg"),
                onPressedTakePhoto: () => takePhoto(
                    (url) => docReversoUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-docIdentidadReverso.jpg"),
                imageUrl: docReversoUrl,
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
                            builder: (context) => RegistrarNegocio3Page(
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
                              referenciaUbicacion: widget.referenciaUbicacion,
                              typeOfHousing: widget.typeOfHousing,
                            ),
                          ));
                    },
                  ),
                  SizedBox(width: 20.0),
                  IconFormButtonWidget(
                    icon: Icon(FontAwesomeIcons.arrowRight),
                    onPressed: () {
                      List<String> mensajes = [];
                      if (fachadaInterna == null) {
                        mensajes.add(
                            "X Debe subir una foto de la fachada externa del negocio.");
                      }
                      if (fachadaExterna == null) {
                        mensajes.add(
                            "X Debe subir una foto de la fachada interna del negocio.");
                      }
                      if (docAnversoUrl == null) {
                        mensajes.add(
                            "X Debe subir una foto de la parte frontal de su documento de identidad.");
                      }
                      if (docReversoUrl == null) {
                        mensajes.add(
                            "X Debe subir una foto de la parte de atrás de su documento de identidad.");
                      }

                      if (mensajes.isNotEmpty) {
                        int duracion = 2; // Duración base
                        if (mensajes.length == 1) {
                          duracion = 3;
                        } else if (mensajes.length == 2) {
                          duracion = 5;
                        } else if (mensajes.length == 3) {
                          duracion = 6;
                        }

                        mostrarSnackBar(mensajes.join("\n"), duracion);
                        print("Fachada interna $fachadaInterna");
                        print("Fachada externa $fachadaExterna");
                        print("Documento Frontal $docAnversoUrl");
                        print("Reverso del documento $docReversoUrl");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrarNegocio5Page(
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
                              referenciaUbicacion: widget.referenciaUbicacion,
                              typeOfHousing: widget.typeOfHousing,
                              categoria: widget.categoria,
                              fachadaInterna: fachadaInterna!,
                              fachadaExterna: fachadaExterna!,
                              docAnversoUrl: docAnversoUrl!,
                              docReversoUrl: docReversoUrl!,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              divider40(),
              divider30(),
            ],
          ),
        ),
      ),
    );
  }
}
