//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../models/agregar_productos_model.dart';
// import '../utils/constants.dart';
//
// class AgregarProductosService {
//   Future<AgregarProductosModel> agregarProductosEnBD(
//       AgregarProductosModel addProducts
//       ) async {
//     String _path = pathProduction + "/negocio/verificarEmailDniCelNegocio/";
//     Uri _uri = Uri.parse(_path);
//
//     final Map<String, dynamic> body = addProducts.toJson();
//     print("JSON DATA: ${json.encode(body)}");
//
//     try {
//       print("Sending POST request...");
//       http.Response response = await http.post(
//         _uri,
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: json.encode(body),
//       );
//       print("Response Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//
//       if (response.statusCode == 200) {
//         Map<String, dynamic> jsonResponse = json.decode(response.body);
//         print("Response JSON: $jsonResponse");
//         return AgregarProductosModel.fromJson(jsonResponse);
//       } else {
//         print("HTTP Error: ${response.statusCode}");
//         throw Exception('Error en la solicitud a la BD: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("Network/Exception Error: $e");
//       throw Exception('Error de red: $e');
//     }
//   }
// }