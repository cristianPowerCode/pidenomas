
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helps/sp.global.dart';
import '../models/agregar_productos_model.dart';
import '../models/response_model.dart';
import '../utils/constants.dart';
SPGlobal spglobal = SPGlobal();
class AgregarProductosService {
  Future<ResponseModel> agregarProductosEnBD(AgregarProductosModel addProducts) async {
    String _path = pathProduction + "/nproductos/registrarProducto/${spglobal.token}/";
    Uri _uri = Uri.parse(_path);

    final Map<String, dynamic> body = addProducts.toJson();
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
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print("Response JSON: $jsonResponse");
        return ResponseModel.fromJson(jsonResponse); // Retorna el nuevo modelo
      } else {
        print("HTTP Error: ${response.statusCode}");
        throw Exception('Error en la solicitud a la BD: ${response.statusCode}');
      }
    } catch (e) {
      print("Network/Exception Error: $e");
      throw Exception('Error de red: $e');
    }
  }
}