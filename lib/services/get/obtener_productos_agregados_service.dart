import 'dart:convert';

import 'package:pidenomas/models/agregar_productos_model.dart';
import 'package:pidenomas/models/obtener_productos_model.dart';

import '../../helps/sp.global.dart';
import '../../models/response_model.dart';
import '../../utils/constants.dart';
import 'package:http/http.dart' as http;

SPGlobal spglobal = SPGlobal();

class ObtenerProductosAgregadosService {
  Future<List<ObtenerProductosModel>> obtenerProductos() async {
    // Construcción de la URL de la solicitud
    String _path = pathProduction + "/nproductos/getNegocios/${spglobal.token}/";
    Uri _uri = Uri.parse(_path);

    try {
      print("Sending GET request...");
      // Realizar la solicitud GET
      http.Response response = await http.get(
        _uri,
        headers: {
          "Content-Type": "application/json",
        },
      );

      // Imprimir detalles de la respuesta
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON como una lista
        List<dynamic> jsonResponse = json.decode(response.body);
        print("Response JSON: $jsonResponse");

        // Convertir la lista de JSONs a una lista de modelos AgregarProductosModel
        List<ObtenerProductosModel> productos = jsonResponse.map((json) => ObtenerProductosModel.fromJson(json)).toList();

        // Retornar la lista de productos
        return productos;
      } else {
        print("HTTP Error: ${response.statusCode}");
        throw Exception('Error en la solicitud a la BD: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de errores de red y excepciones
      print("Network/Exception Error: $e");
      throw Exception('Error de red: $e');
    }
  }
}
