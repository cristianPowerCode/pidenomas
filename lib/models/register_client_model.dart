class RegisterClientModel {
  String uid;
  String nombre;
  String apellidos;
  DateTime fechaDeNacimiento;
  String celular;
  int tipoDocumento;
  String docIdentidad;
  int genero;
  String email;
  String password;
  bool isVerifiedEmail;
  bool agreeNotifications;
  double lat;
  double lng;
  String direccion;
  String detalleDireccion;
  String referenciaDireccion;
  int tiposInmueble;
  DateTime fechaDeCreacion;

  RegisterClientModel({
    required this.uid,
    required this.nombre,
    required this.apellidos,
    required this.fechaDeNacimiento,
    required this.celular,
    required this.tipoDocumento,
    required this.docIdentidad,
    required this.genero,
    required this.email,
    required this.password,
    required this.isVerifiedEmail,
    required this.agreeNotifications,
    required this.lat,
    required this.lng,
    required this.direccion,
    required this.detalleDireccion,
    required this.referenciaDireccion,
    required this.tiposInmueble,
    required this.fechaDeCreacion,
  });

  factory RegisterClientModel.fromJson(Map<String, dynamic> json) => RegisterClientModel(
    uid: json["uid"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    fechaDeNacimiento: DateTime.parse(json["fechaDeNacimiento"]),
    celular: json["celular"],
    tipoDocumento: json["tipoDocumento"],
    docIdentidad: json["docIdentidad"],
    genero: json["genero"],
    email: json["email"],
    password: json["password"],
    isVerifiedEmail: json["isVerifiedEmail"],
    agreeNotifications: json["agreeNotifications"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    direccion: json["direccion"],
    detalleDireccion: json["detalleDireccion"],
    referenciaDireccion: json["referenciaDireccion"],
    tiposInmueble: json["tiposInmueble"],
    fechaDeCreacion: DateTime.parse(json["fechaDeCreacion"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "nombre": nombre,
    "apellidos": apellidos,
    "fechaDeNacimiento": "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
    "celular": celular,
    "tipoDocumento": tipoDocumento,
    "docIdentidad": docIdentidad,
    "genero": genero,
    "email": email,
    "password": password,
    "isVerifiedEmail": isVerifiedEmail,
    "agreeNotifications": agreeNotifications,
    "lat": lat,
    "lng": lng,
    "direccion": direccion,
    "detalleDireccion": detalleDireccion,
    "referenciaDireccion": referenciaDireccion,
    "tiposInmueble": tiposInmueble,
    "fechaDeCreacion": "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')}",
  };
}
