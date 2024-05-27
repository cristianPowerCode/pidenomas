class RegisterClienteModel {
  RegisterClienteModel({
    this.fullname,
    this.email,
    this.password,
    this.telefono,
    // this.ubicacion,
    this.lat,
    this.lng,
    this.detalleDireccion,
    this.referencia,
  });

  String? fullname;
  String? email;
  String? password;
  String? telefono;
  // String? ubicacion;
  double? lat;
  double? lng;
  String? detalleDireccion;
  String? referencia;

  factory RegisterClienteModel.fromJson(Map<String, dynamic> json) =>
      RegisterClienteModel(
        fullname: json["nombre"],
        email: json["email"],
        password: json["password"],
        telefono: json["telefono"],
        // ubicacion: json["ubicacion"],
        lat: json["lat"],
        lng: json["lng"],
        detalleDireccion: json["detalleDireccion"],
        referencia: json["referencia"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": fullname,
        "fecha_creacion": "2024-05-09T18:41:00Z",
        "uid_usuario": "aaaaa9876543211123aa",
        "email": email,
        "password1": "admin",
        "password2": "admin",
        "telefono": telefono,
        // "ubicacion": ubicacion,
        "lat": lat,
        "lng": lng,
        "direccion": "av siempreviva",
        "detalle_direccion": detalleDireccion,
        "referencia_direccion": referencia,
      };
}
