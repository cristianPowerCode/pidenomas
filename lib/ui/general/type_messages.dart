
import 'package:flutter/material.dart';

import 'colors.dart';

enum Typemessage {
  success,
  error,
  loginSuccess,
  networkError,
  incomplete
}
Map<Typemessage, String> message = {
  Typemessage.loginSuccess : "Bienvenido, tus credenciales son correctas",
  Typemessage.success : "---",
  Typemessage.error : "Hubo un inconveniente, por favor inténtalo nuevamente",
  Typemessage.networkError : "Error de conexión de red",
  Typemessage.incomplete : "Complete el formulario por favor",
};

Map<Typemessage, Color> messageColor = {
  Typemessage.loginSuccess : kBrandPrimaryColor1,
  Typemessage.success : kBrandPrimaryColor1,
  Typemessage.error : kErrorColor,
  Typemessage.networkError : kErrorColor,
  Typemessage.incomplete : kBrandSecundaryColor1,
};

Map<Typemessage, IconData> messageIcon = {
  Typemessage.loginSuccess : Icons.check_circle_outline,
  Typemessage.success : Icons.check_circle_outline,
  Typemessage.error : Icons.error_outline,
  Typemessage.networkError : Icons.error_outline,
  Typemessage.incomplete : Icons.error_outline,
};