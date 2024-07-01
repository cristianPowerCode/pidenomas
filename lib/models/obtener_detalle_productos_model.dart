class ObtenerDetalleProductoModel {
  int id;
  String nombre;
  String imagen;
  bool stock;
  double precioRegular;
  double precioDescuento;
  String marca;
  String subCategoria;
  String descripcion;
  int status;

  ObtenerDetalleProductoModel({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.stock,
    required this.precioRegular,
    required this.precioDescuento,
    required this.marca,
    required this.subCategoria,
    required this.descripcion,
    required this.status,
  });

  factory ObtenerDetalleProductoModel.fromJson(Map<String, dynamic> json) => ObtenerDetalleProductoModel(
    id: json["id"],
    nombre: json["nombre"],
    imagen: json["imagen"],
    stock: json["stock"],
    precioRegular: json["precioRegular"]?.toDouble(),
    precioDescuento: json["precioDescuento"]?.toDouble(),
    marca: json["marca"],
    subCategoria: json["subCategoria"],
    descripcion: json["descripcion"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "imagen": imagen,
    "stock": stock,
    "precioRegular": precioRegular,
    "precioDescuento": precioDescuento,
    "marca": marca,
    "subCategoria": subCategoria,
    "descripcion": descripcion,
    "status": status,
  };
}