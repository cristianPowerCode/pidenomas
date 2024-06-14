import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pidenomas/models/register_business_model.dart';
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
      "fechaDeCreacion":
          "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')}",
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

  Future<RegisterBusinessModel?> registrarNegocioToDB(
    String uid,
    String nombre,
    String apellidos,
    String email,
    bool isVerified,
    int isRegistered,
    bool agreeNotifications,
    String celular,
    int tipoDocumento,
    String documentoIdentidad,
    DateTime fechaDeNacimiento,
    int genero,
    String password,
    double lat,
    double lng,
    String direccion,
    String detalleDireccion,
    String referenciaDireccion,
    String tipoDeInmueble,
    String photoFachadaInterna,
    String photoFachadaExterna,
    String photoDocIdentidadAnv,
    String photoDocIdentidadRev,
    DateTime fechaDeCreacion,
    int categoria,
    String rucNegocio,
    String razSocNegocio,
    String nombNegocio,
    // List<Map<String, String>> horarios,
  ) async {
    String _path = pathProduction + "/negocio/registrarNegocio/";
    print(_path);
    Uri _uri = Uri.parse(_path);

    // Preparar el cuerpo de la solicitud
    final Map<String, dynamic> body = {
      "uid": uid,
      "nombre": nombre,
      "apellidos": apellidos,
      "fechaDeNacimiento":
          "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
      "celular": celular,
      "tipoDocumento": tipoDocumento,
      "docIdentidad": documentoIdentidad,
      "genero": genero,
      "email": email,
      "password": password,
      "isVerifiedEmail": isVerified,
      "isRegistered": isRegistered,
      "agreeNotifications": agreeNotifications,
      "lat": lat,
      "lng": lng,
      "direccion": direccion,
      "detalleDireccion": detalleDireccion,
      "referenciaDireccion": referenciaDireccion,
      "tipoDeInmueble": tipoDeInmueble,
      "categoria": categoria,
      "photoFachadaInterna": photoFachadaInterna,
      "photoFachadaExterna": photoFachadaExterna,
      "photoDocIdentidadAnv": photoDocIdentidadAnv,
      "photoDocIdentidadRev": photoDocIdentidadRev,
      "rucNegocio": rucNegocio,
      "razSocNegocio": razSocNegocio,
      "nombreNegocio": nombNegocio,
      "fechaDeCreacion":
          "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')}",
      "horarios": [
        {"dia": "lunes", "horaInicia": "13:09:53", "horaFin": "13:09:54"},
        {"dia": "viernes", "horaInicia": "13:44:51", "horaFin": "13:44:52"},
        {"dia": "feriado", "horaInicia": "13:44:51", "horaFin": "13:44:52"}
      ],
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
        RegisterBusinessModel registerNegocioToDB =
            RegisterBusinessModel.fromJson(userMap);
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
      print("NO SE LOGRO 200");
      print("Network/Exception Error: $e");
      throw Exception('Error de red: $e');
    }
  }
}
