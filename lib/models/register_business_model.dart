class RegisterBusinessModel {
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
  int isRegistered;
  bool agreeNotifications;
  double lat;
  double lng;
  String direccion;
  String detalleDireccion;
  String referenciaDireccion;
  int tipoDeInmueble;
  int categoria;
  String photoFachadaInterna;
  String photoFachadaExterna;
  String photoDocIdentidadAnv;
  String photoDocIdentidadRev;
  String rucNegocio;
  String razSocNegocio;
  String nombreNegocio;
  DateTime fechaDeCreacion;
  List<Horario> horarios;

  RegisterBusinessModel({
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
    required this.isRegistered,
    required this.agreeNotifications,
    required this.lat,
    required this.lng,
    required this.direccion,
    required this.detalleDireccion,
    required this.referenciaDireccion,
    required this.tipoDeInmueble,
    required this.categoria,
    required this.photoFachadaInterna,
    required this.photoFachadaExterna,
    required this.photoDocIdentidadAnv,
    required this.photoDocIdentidadRev,
    required this.rucNegocio,
    required this.razSocNegocio,
    required this.nombreNegocio,
    required this.fechaDeCreacion,
    required this.horarios,
  });

  factory RegisterBusinessModel.fromJson(Map<String, dynamic> json) => RegisterBusinessModel(
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
    isRegistered: json["isRegistered"],
    agreeNotifications: json["agreeNotifications"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    direccion: json["direccion"],
    detalleDireccion: json["detalleDireccion"],
    referenciaDireccion: json["referenciaDireccion"],
    tipoDeInmueble: json["tipoDeInmueble"],
    categoria: json["categoria"],
    photoFachadaInterna: json["photoFachadaInterna"],
    photoFachadaExterna: json["photoFachadaExterna"],
    photoDocIdentidadAnv: json["photoDocIdentidadAnv"],
    photoDocIdentidadRev: json["photoDocIdentidadRev"],
    rucNegocio: json["rucNegocio"],
    razSocNegocio: json["razSocNegocio"],
    nombreNegocio: json["nombreNegocio"],
    fechaDeCreacion: DateTime.parse(json["fechaDeCreacion"]),
    horarios: List<Horario>.from(json["horarios"].map((x) => Horario.fromJson(x))),
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
    "isRegistered": isRegistered,
    "agreeNotifications": agreeNotifications,
    "lat": lat,
    "lng": lng,
    "direccion": direccion,
    "detalleDireccion": detalleDireccion,
    "referenciaDireccion": referenciaDireccion,
    "tipoDeInmueble": tipoDeInmueble,
    "categoria": categoria,
    "photoFachadaInterna": photoFachadaInterna,
    "photoFachadaExterna": photoFachadaExterna,
    "photoDocIdentidadAnv": photoDocIdentidadAnv,
    "photoDocIdentidadRev": photoDocIdentidadRev,
    "rucNegocio": rucNegocio,
    "razSocNegocio": razSocNegocio,
    "nombreNegocio": nombreNegocio,
    "fechaDeCreacion": "${fechaDeCreacion.year.toString().padLeft(4, '0')}-${fechaDeCreacion.month.toString().padLeft(2, '0')}-${fechaDeCreacion.day.toString().padLeft(2, '0')} ${fechaDeCreacion.hour.toString().padLeft(2, '0')}:${fechaDeCreacion.minute.toString().padLeft(2, '0')}:${fechaDeCreacion.second.toString().padLeft(2, '0')}",
    "horarios": List<dynamic>.from(horarios.map((x) => x.toJson())),
  };
}

class Horario {
  String dia;
  String horaInicia;
  String horaFin;

  Horario({
    required this.dia,
    required this.horaInicia,
    required this.horaFin,
  });

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
    dia: json["dia"],
    horaInicia: json["horaInicia"],
    horaFin: json["horaFin"],
  );

  Map<String, dynamic> toJson() => {
    "dia": dia,
    "horaInicia": horaInicia,
    "horaFin": horaFin,
  };
}
