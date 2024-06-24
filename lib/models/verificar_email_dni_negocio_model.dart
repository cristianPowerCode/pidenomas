class VerificarEmailDniNegocioModel {
  String email;
  String documentoIdentidad;
  int status; // Atributo para capturar el estado de la respuesta
  String message; // Nuevo atributo para capturar el mensaje

  VerificarEmailDniNegocioModel({
    required this.email,
    required this.documentoIdentidad,
    required this.status, // Incluir status en el constructor
    required this.message, // Incluir message en el constructor
  });

  factory VerificarEmailDniNegocioModel.fromJson(Map<String, dynamic> json) =>
      VerificarEmailDniNegocioModel(
        email: json["email"] ?? "", // Proveer valor por defecto si es null
        documentoIdentidad: json["documentoIdentidad"] ?? "", // Proveer valor por defecto si es null
        status: json["status"], // Asignar status desde el JSON
        message: json["message"] ?? "", // Asignar message desde el JSON
      );

  Map<String, dynamic> toJson() => {
    "email": email,
    "documentoIdentidad": documentoIdentidad,
    "status": status, // Incluir status en el JSON
    "message": message, // Incluir message en el JSON
  };
}