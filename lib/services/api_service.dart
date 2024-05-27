import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helps/sp.global.dart';
import '../models/register_cliente_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class APIService {
  SPGlobal spGlobal = SPGlobal();

  Future<UserModel?> login(String email, String password) async {
    String _path = pathProduction + "/api/login";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );
    print(_path);
    print("STATUS: ${response.statusCode}");
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = json.decode(response.body);
      print("===========");
      print("Mapa user: $userMap");
      UserModel userModel = UserModel.fromJson(userMap);
      print("=========================");
      print("Modelo user: ${userModel.token}");
      //
      spGlobal.token = userModel.token!;
      spGlobal.isLogin = true; //bandera
      return userModel;
    }
    return null;
  }

  Future<RegisterClienteModel?> registerCliente(
    String fullname,
    String email,
    String password,
    String telefono,
    double lat,
    double lng,
    String detalleDireccion,
    String referencia,
  ) async {
    String _path = pathProduction + "/api/usuarios";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.post(
      _uri,
      // headers: {
      //   "Content-Type": "application/json",
      // },
      // body: json.encode({
      //   "fullname": fullname,
      //   "email": email,
      //   "password": password,
      //   "telefono": telefono,
      //   "ubicacion": ubicacion,
      //   "detalleDireccion": detalleDireccion,
      //   "referencia": referencia,
      // }),
      body: json.encode({
        "nombre": fullname,
        "email": email,
        "password": password,
        "telefono": telefono,
        "lat": lat,
        "lng" : lng,
        "detalleDireccion": detalleDireccion,
        "referencia": referencia,
      }),
    );
    print("JSON DATA: ${json.encode(
        {
          "nombre": fullname,
          "fecha_creacion": "2024-05-09T18:41:00Z",
          "uid_usuario": "abcdef123435001",
          "telefono": telefono,
          "lat": lat,
          "lng": lat,
          "direccion": "Av siempre Viva",
          "detalle_direccion": detalleDireccion,
          "referencia_direccion": referencia,
          "email": email,
          "password1": password,
          "password2": "admin"
        }
    )}");
    print("STATUS: ${response.statusCode}");
    //aqui quiero imprimir los datos que se guardar en json.code
    if (response.statusCode == 200) {
      Map<String, dynamic> userMap = json.decode(response.body);
      print("===========");
      print("Mapa user: $userMap");
      RegisterClienteModel registerClienteModel = RegisterClienteModel.fromJson(userMap);
      print("=========================");
      print("Modelo user: ${registerClienteModel.telefono}");
      //

      return registerClienteModel;
    }
    return null;
  }
}
