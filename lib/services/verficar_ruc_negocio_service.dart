import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verificar_email_dni_celular_negocio_model.dart';
import '../models/verificar_ruc_negocio_model.dart';
import '../utils/constants.dart';

class VerificarRucNegocioService {
  Future<VerificarRucNegocioModel> verificarRucNegocioEnBD(
      String rucNegocio,
      ) async {
    String _path = pathProduction + "/negocio/verificarRuc/";
    Uri _uri = Uri.parse(_path);

    final Map<String, dynamic> body = {
      "rucNegocio": rucNegocio,
    };

    try {
      http.Response response = await http.post(
        _uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      print("STATUS: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return VerificarRucNegocioModel.fromJson(jsonResponse);
      } else {
        throw Exception('Error en la solicitud a la BD: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}
