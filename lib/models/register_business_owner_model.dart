class BusinessOwnerModel {
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
  int categoria;
  String rucNegocio;
  String razSocNegocio;
  String nombNegocio;

  BusinessOwnerModel({
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
    required this.categoria,
    required this.rucNegocio,
    required this.razSocNegocio,
    required this.nombNegocio,
  });

  factory BusinessOwnerModel.fromJson(Map<String, dynamic> json) => BusinessOwnerModel(
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
    categoria: json["categoria"],
    rucNegocio: json["rucNegocio"],
    razSocNegocio: json["razSocNegocio"],
    nombNegocio: json["nombNegocio"],
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
    "categoria": categoria,
    "rucNegocio": rucNegocio,
    "razSocNegocio": razSocNegocio,
    "nombNegocio": nombNegocio,
  };
}