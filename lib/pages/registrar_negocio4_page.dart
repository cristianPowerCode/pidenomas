import 'package:flutter/material.dart';
import 'package:pidenomas/ui/widgets/background_widget.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';
import 'package:pidenomas/ui/widgets/photo_widget.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/button_widget.dart';
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

  String? fachadaUrl;
  String? docAnversoUrl;
  String? docReversoUrl;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePickerActive = false;

  // Función _uploadPhoto
  void _uploadPhoto(Function(String) setUrl, String path) async {
    if (_isImagePickerActive) {
      print("El selector de imágenes ya está activo.");
      return;
    }

    setState(() {
      _isImagePickerActive = true;
    });

    try {
      print("funcion _uploadPhoto");
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print("Imagen seleccionada correctamente: ${pickedFile.path}");
        final url = await uploadImageToFirebase(File(pickedFile.path), path);
        if (url.isNotEmpty) {
          print("URL de imagen obtenida: $url");
          setState(() {
            setUrl(url);
          });
          print("URL asignada correctamente");
        } else {
          print("La URL de la imagen está vacía");
        }
      } else {
        print("No se seleccionó ninguna imagen");
      }
    } catch (e) {
      print("Error en la carga de la imagen: $e");
    } finally {
      setState(() {
        _isImagePickerActive = false;
      });
    }
  }

  // Función para tomar la foto con la cámara
  void takePhoto(Function(String) setUrl, String path) async {
    if (_isImagePickerActive) {
      print("El selector de imágenes ya está activo.");
      return;
    }

    setState(() {
      _isImagePickerActive = true;
    });

    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final url = await uploadImageToFirebase(File(pickedFile.path), path);
        if (url.isNotEmpty) {
          print("URL de imagen obtenida: $url");
          setState(() {
            setUrl(url);
          });
          print("URL asignada correctamente");
        } else {
          print("La URL de la imagen está vacía");
        }
      } else {
        print("No se tomó ninguna foto");
      }
    } catch (e) {
      print("Error al tomar la foto: $e");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BackGroundWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrincipalText(string: "Ya falta poco..."),
              divider40(),
              PrincipalText(string: "Suba una foto de la fachada del negocio"),
              PhotoWidget(
                tipo: 1,
                icon: Icons.storefront,
                onPressedUploadPhoto: () => _uploadPhoto(
                    (url) => fachadaUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-fachada.jpg"),
                onPressedTakePhoto: () => takePhoto((url) => fachadaUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-fachada.jpg"),
                imageUrl: fachadaUrl,
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
                onPressedUploadPhoto: () => _uploadPhoto(
                    (url) => docReversoUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-docIdentidadReverso.jpg"),
                onPressedTakePhoto: () => takePhoto(
                    (url) => docReversoUrl = url,
                    "negocio/${widget.documentoIdentidad}/negocio-${widget.documentoIdentidad}-docIdentidadReverso.jpg"),
                imageUrl: docReversoUrl,
              ),
              divider30(),
              Center(
                child: ButtonWidget(
                  onPressed: () {
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
                        ),
                      ),
                    );
                  },
                  text: "Ir a Registro 5",
                ),
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
