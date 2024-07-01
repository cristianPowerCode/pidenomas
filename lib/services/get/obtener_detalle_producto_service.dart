import 'dart:convert';

import 'package:pidenomas/models/obtener_detalle_productos_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class ObtenerDetalleProductoService {
  Future<ObtenerDetalleProductoModel> obtenerDetalleProducto(idProducto) async {
    // Construcción de la URL de la solicitud
    String _path = pathProduction + "/nproductos/getDetailsProducto/${idProducto}/";
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
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        print("Response JSON: $jsonResponse");

        // Convertir el JSON a un modelo ObtenerProductosModel
        ObtenerDetalleProductoModel producto = ObtenerDetalleProductoModel.fromJson(jsonResponse);

        // Retornar detalle del producto
        return producto;
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
