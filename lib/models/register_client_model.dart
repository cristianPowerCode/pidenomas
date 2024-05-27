class RegisterClientModel {
  String uid;
  String nombre;
  String apellidos;
  String email;
  bool isVerified;
  String celular;
  int tipoDocumento;
  DateTime fechaDeNacimiento;
  String documentoIdentidad;
  int genero;
  String password;
  double lat;
  double lng;
  String direccion;
  String detalleDireccion;
  String referenciaDireccion;
  String photoUrl;
  DateTime fechaDeCreacion;

  RegisterClientModel({
    required this.uid,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.isVerified,
    required this.celular,
    required this.tipoDocumento,
    required this.fechaDeNacimiento,
    required this.documentoIdentidad,
    required this.genero,
    required this.password,
    required this.lat,
    required this.lng,
    required this.direccion,
    required this.detalleDireccion,
    required this.referenciaDireccion,
    required this.photoUrl,
    required this.fechaDeCreacion,
  });

  factory RegisterClientModel.fromJson(Map<String, dynamic> json) => RegisterClientModel(
    uid: json["uid"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    email: json["email"],
    isVerified: json["isVerified"],
    celular: json["celular"],
    tipoDocumento: json["tipoDocumento"],
    fechaDeNacimiento: DateTime.parse(json["fechaDeNacimiento"]),
    documentoIdentidad: json["documentoIdentidad"],
    genero: json["genero"],
    password: json["password"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    direccion: json["direccion"],
    detalleDireccion: json["detalleDireccion"],
    referenciaDireccion: json["referenciaDireccion"],
    photoUrl: json["photoURL"],
    fechaDeCreacion: DateTime.parse(json["fechaDeCreacion"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "nombre": nombre,
    "apellidos": apellidos,
    "email": email,
    "isVerified": isVerified,
    "celular": celular,
    "tipoDocumento": tipoDocumento,
    "fechaDeNacimiento": "${fechaDeNacimiento.year.toString().padLeft(4, '0')}-${fechaDeNacimiento.month.toString().padLeft(2, '0')}-${fechaDeNacimiento.day.toString().padLeft(2, '0')}",
    "documentoIdentidad": documentoIdentidad,
    "genero": genero,
    "password": password,
    "lat": lat,
    "lng": lng,
    "direccion": direccion,
    "detalleDireccion": detalleDireccion,
    "referenciaDireccion": referenciaDireccion,
    "photoURL": photoUrl,
    "fechaDeCreacion": "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')}",
  };
}
