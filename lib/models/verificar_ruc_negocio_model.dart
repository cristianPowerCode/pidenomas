class VerificarRucNegocioModel {
  String rucNegocio;
  int status; // Atributo para capturar el estado de la respuesta
  String message; // Nuevo atributo para capturar el mensaje

  VerificarRucNegocioModel({
    required this.rucNegocio,
    required this.status, // Incluir status en el constructor
    required this.message, // Incluir message en el constructor
  });

  factory VerificarRucNegocioModel.fromJson(Map<String, dynamic> json) =>
      VerificarRucNegocioModel(
        rucNegocio: json["rucNegocio"] ?? "", // Proveer valor por defecto si es null
        status: json["status"], // Asignar status desde el JSON
        message: json["message"] ?? "", // Asignar message desde el JSON
      );

  Map<String, dynamic> toJson() => {
    "rucNegocio": rucNegocio,
    "status": status, // Incluir status en el JSON
    "message": message, // Incluir message en el JSON
  };
}