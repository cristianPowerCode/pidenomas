import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pidenomas/models/register_business_model.dart';
import 'package:pidenomas/models/register_client_model.dart';
import '../helps/sp.global.dart';
import '../models/response_model.dart';
import '../utils/constants.dart';

class APIService {
  SPGlobal spGlobal = SPGlobal();

  Future<ResponseModel> registrarClienteToDB(RegisterClientModel client) async {
    String _path = pathProduction + "/cliente/registrarCliente/";
    Uri _uri = Uri.parse(_path);
    print(_path);

    final Map<String, dynamic> body = client.toJson();
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

        return ResponseModel.fromJson(jsonResponse);
      } else {
        print("HTTP Error: ${response.statusCode}");
        throw Exception('Error en la solicitud a la BD: ${response.statusCode}');
      }
    } catch (e) {
      print("Network/Exception Error: $e");
      throw Exception('Error de red: $e');
    }
  }

  Future<ResponseModel> registrarNegocioToDB(RegisterBusinessModel business) async {
    String _path = pathProduction + "/negocio/registrarNegocio/";
    Uri _uri = Uri.parse(_path);

    final Map<String, dynamic> body = business.toJson();
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

        return ResponseModel.fromJson(jsonResponse);
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
