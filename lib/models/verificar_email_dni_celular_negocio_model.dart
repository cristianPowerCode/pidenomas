class VerificarEmailDniCelNegocioModel {
  String email;
  String documentoIdentidad;
  String celular;
  int status; // Atributo para capturar el estado de la respuesta
  String message; // Nuevo atributo para capturar el mensaje

  VerificarEmailDniCelNegocioModel({
    required this.email,
    required this.documentoIdentidad,
    required this.celular,
    required this.status, // Incluir status en el constructor
    required this.message, // Incluir message en el constructor
  });

  factory VerificarEmailDniCelNegocioModel.fromJson(Map<String, dynamic> json) =>
      VerificarEmailDniCelNegocioModel(
        email: json["email"] ?? "", // Proveer valor por defecto si es null
        documentoIdentidad: json["documentoIdentidad"] ?? "", // Proveer valor por defecto si es null
        celular: json["celular"] ?? "", // Proveer valor por defecto si es null
        status: json["status"], // Asignar status desde el JSON
        message: json["message"] ?? "", // Asignar message desde el JSON
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "documentoIdentidad": documentoIdentidad,
    "celular": celular,
    "status": status, // Incluir status en el JSON
    "message": message, // Incluir message en el JSON
  };
}