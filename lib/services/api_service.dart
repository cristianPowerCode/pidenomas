import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pidenomas/models/register_client_model.dart';
import '../helps/sp.global.dart';
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
    String _path = pathProduction + "/api/usuarios";
    Uri _uri = Uri.parse(_path);
    try {
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "uid": uid,
          "nombre": nombre,
          "apellidos": apellidos,
          "email": email,
          "isVerified": isVerified,
          "celular": celular,
          "tipoDocumento": tipoDocumento,
          "fechaDeNacimiento": fechaDeNacimiento,
          "documentoIdentidad": documentoIdentidad,
          "genero": genero,
          "password": password,
          "lat": lat,
          "lng": lng,
          "direccion": direccion,
          "detalleDireccion": detalleDireccion,
          "referenciaDireccion": referenciaDireccion,
          "photoURL": photoUrl,
          "fechaDeCreacion": fechaDeCreacion,
          "agreeNotifications": agreeNotifications
        }),
      );

      print("JSON DATA: ${json.encode(
          {
            "uid": uid,
            "nombre": nombre,
            "apellidos": apellidos,
            "email": email,
            "isVerified": isVerified,
            "celular": celular,
            "tipoDocumento": tipoDocumento,
            "fechaDeNacimiento": fechaDeNacimiento,
            "documentoIdentidad": documentoIdentidad,
            "genero": genero,
            "password": password,
            "lat": lat,
            "lng": lng,
            "direccion": direccion,
            "detalleDireccion": detalleDireccion,
            "referenciaDireccion": referenciaDireccion,
            "photoURL": photoUrl,
            "fechaDeCreacion": fechaDeCreacion,
            "agreeNotifications": agreeNotifications
          }
      )}");

      print("STATUS: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, dynamic> userMap = json.decode(response.body);
        print("===========");
        print("Mapa user: $userMap");
        RegisterClientModel registerClienteToDB = RegisterClientModel.fromJson(userMap);
        print("=========================");
        print("UID registrado a DB: ${registerClienteToDB.uid}");

        return registerClienteToDB;
      } else {
        // Manejar errores de otros códigos de estado HTTP aquí
        throw Exception('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de red o excepciones aquí
      throw Exception('Error de red: $e');
    }
  }
}

