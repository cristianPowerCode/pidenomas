import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pidenomas/utils/constants.dart';

import '../models/login_negocio_model.dart';

class LoginNegocioService {
  Future<LoginNegocioModel> loginNegocio(String email, String password) async {
    String path = "$pathProduction/negocio/loginNegocio/";
    print(path);
    Uri uri = Uri.parse(path);
    final Map<String, String> body = {"email": email, "password": password};
    print("JSON DATA: ${json.encode(body)}");

    try {
      print("Sending POST LoginNegocio request...");
      http.Response response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      print("Response Status Code: ${response.statusCode}"); //--
      print("Response Body: ${response.body}"); //--
      print("STATUS A LA BD: ${response.statusCode}");

      if (response.statusCode == 200) {
        Map<String, String> loginMap = json.decode(response.body);
        print("===========");
        print("Mapa loginNegocio: $loginMap");
        LoginNegocioModel loginNegocio = LoginNegocioModel.fromJson(loginMap);
        print("=========================");

        return loginNegocio;
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
