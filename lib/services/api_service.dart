import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pidenomas/models/register_client_model.dart';
import '../helps/sp.global.dart';
import '../models/register_negocio_model.dart';
import '../utils/constants.dart';

class APIService {
  SPGlobal spGlobal = SPGlobal();

  Future<RegisterClientModel?> registerClienteToDB(
    String uid,
    String nombre,
    String apellidos,
    String email,
    bool isVerified,
    String celular,
    int tipoDocumento,
    DateTime fechaDeNacimiento,
    String documentoIdentidad,
    int genero,
    String password,
    double lat,
    double lng,
    String direccion,
    String detalleDireccion,
    String referenciaDireccion,
    String photoUrl,
    DateTime fechaDeCreacion,
    bool agreeNotifications,
  ) async {
    String _path = pathProduction + "/api/usuarios/";
    print(_path);
    Uri _uri = Uri.parse(_path);

    // Preparar el cuerpo de la solicitud
    final Map<String, dynamic> body = {
      "uid": uid,
      "nombre": nombre,
      "apellidos": apellidos,
      "email": email,
      "isVerified": isVerified,
      "celular": celular,
      "tipoDocumento": tipoDocumento,
      "fechaDeNacimiento":
          "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
      "documentoIdentidad": documentoIdentidad,
      "genero": genero,
      "password": password,
      "lat": lat,
      "lng": lng,
      "direccion": direccion,
      "detalleDireccion": detalleDireccion,
      "referenciaDireccion": referenciaDireccion,
      "photoURL": photoUrl,
      "fechaDeCreacion": "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')}",
      "agreeNotifications": agreeNotifications
    };

    print("JSON DATA: ${json.encode(body)}");

    try {
      print("Sending POST request...");
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      print("Response Status Code: ${response.statusCode}"); //--
      print("Response Body: ${response.body}"); //--
      print("STATUS A LA BD: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = json.decode(response.body);
        print("===========");
        print("Mapa cliente: $userMap");
        RegisterClientModel registerClienteToDB =
            RegisterClientModel.fromJson(userMap);
        print("=========================");
        print("UID registrado a DB: ${registerClienteToDB.uid}");

        return registerClienteToDB;
      } else {
        // Manejar errores de otros códigos de estado HTTP aquí
        print("HTTP Error: ${response.statusCode}");
        throw Exception(
            'Error en la solicitud A LA BD: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de red o excepciones aquí
      print("Network/Exception Error: $e");
      throw Exception('Error de red: $e');
    }
  }

  Future<RegisterNegocioModel?> registerNegocioToDB(
      String uid,
      String nombre,
      String apellidos,
      String email,
      bool isVerified,
      String celular,
      int tipoDocumento,
      DateTime fechaDeNacimiento,
      String documentoIdentidad,
      int genero,
      String password,
      double lat,
      double lng,
      String direccion,
      String detalleDireccion,
      String referenciaDireccion,
      String photoUrl,
      DateTime fechaDeCreacion,
      bool agreeNotifications,
      int categoria,
      String rucNegocio,
      String razSocNegocio,
      String nombNegocio,


      ) async {
    String _path = pathProduction + "/api/negocios/";
    print(_path);
    Uri _uri = Uri.parse(_path);

    // Preparar el cuerpo de la solicitud
    final Map<String, dynamic> body = {
      "uid": uid,
      "nombre": nombre,
      "apellidos": apellidos,
      "email": email,
      "isVerified": isVerified,
      "celular": celular,
      "tipoDocumento": tipoDocumento,
      "fechaDeNacimiento":
      "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
      "documentoIdentidad": documentoIdentidad,
      "genero": genero,
      "password": password,
      "lat": lat,
      "lng": lng,
      "direccion": direccion,
      "detalleDireccion": detalleDireccion,
      "referenciaDireccion": referenciaDireccion,
      "photoURL": photoUrl,
      "fechaDeCreacion": "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')}",
      "agreeNotifications": agreeNotifications,
      "categorias": categoria,
      "rucNegocio": rucNegocio,
      "razSocNegocio": razSocNegocio,
      "nombNegocio": nombNegocio
    };

    print("JSON DATA: ${json.encode(body)}");

    try {
      print("Sending POST request...");
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      print("Response Status Code: ${response.statusCode}"); //--
      print("Response Body: ${response.body}"); //--
      print("STATUS A LA BD: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = json.decode(response.body);
        print("===========");
        print("Mapa cliente: $userMap");
        RegisterNegocioModel registerNegocioToDB =
        RegisterNegocioModel.fromJson(userMap);
        print("=========================");
        print("UID registrado a DB: ${registerNegocioToDB.uid}");

        return registerNegocioToDB;
      } else {
        // Manejar errores de otros códigos de estado HTTP aquí
        print("HTTP Error: ${response.statusCode}");
        throw Exception(
            'Error en la solicitud A LA BD: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de red o excepciones aquí
      print("Network/Exception Error: $e");
      throw Exception('Error de red: $e');
    }
  }

}
