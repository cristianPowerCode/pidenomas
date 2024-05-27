import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal{

  static final SPGlobal _instance = SPGlobal._();
  SPGlobal._();

  factory SPGlobal() =>_instance;

  late SharedPreferences _prefs;

  Future<void> initSharedPreferences()async{
    _prefs = await SharedPreferences.getInstance();
  }
  //token -> String
  set token(String value){
    _prefs.setString("token", value); //con esto guardo el token
  }
  String get token{
    return _prefs.getString("token") ?? ""; //para guardar nuestro token
  }
  //isLogin -> bool
  set isLogin(bool value){
    _prefs.setBool("isLogin", value); //indicador para saber si está logeado o no
  }
  bool get isLogin{
    return _prefs.getBool("isLogin") ?? false; //si es nulo se devuelve false
  }
}