import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pidenomas/utils/constants.dart';

import '../models/login_negocio_model.dart';

class ApiResponse {
  final int statusCode;
  final dynamic data; // Puedes agregar más campos según lo que necesites

  ApiResponse({
    required this.statusCode,
    required this.data,
  });
}

class LoginNegocioService {
  Future<ApiResponse> loginNegocio(String email, String password) async {
    String path = "$pathProduction/negocio/loginNegocio/";
    Uri uri = Uri.parse(path);
    final Map<String, String> body = {"email": email, "password": password};

    try {
      print("Enviando solicitud POST LoginNegocio...");
      http.Response response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      print("Código de Estado de la Respuesta: ${response.statusCode}");
      print("Cuerpo de la Respuesta: ${response.body}");

      // Decodificar la respuesta JSON
      Map<String, dynamic> responseBody = json.decode(response.body);

      return ApiResponse(
        statusCode: response.statusCode,
        data: responseBody, // Puedes ajustar esto según la estructura de tu respuesta
      );
    } catch (e) {
      print("Error de Red/Excepción: $e");
      throw Exception('Error de red: $e');
    }
  }
}