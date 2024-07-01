class ObtenerProductosModel {
  int id;
  String nombre;
  double precioRegular;
  String subCategoria;
  String imagen;
  bool stock;
  double precioDescuento;
  String marca;
  String descripcion;

  ObtenerProductosModel({
    required this.id,
    required this.nombre,
    required this.precioRegular,
    required this.subCategoria,
    required this.imagen,
    required this.stock,
    required this.precioDescuento,
    required this.marca,
    required this.descripcion,
  });

  factory ObtenerProductosModel.fromJson(Map<String, dynamic> json) => ObtenerProductosModel(
    id: json["id"],
    nombre: json["nombre"],
    precioRegular: json["precioRegular"]?.toDouble(),
    subCategoria: json["subCategoria"] ?? "Sin Categoria", // Valor predeterminado si falta
    imagen: json["imagen"] ?? "assets/images/logo.png",
    stock: json["stock"] ?? false, // Valor predeterminado si falta
    precioDescuento: json["precioDescuento"]?.toDouble(),
    marca: json["marca"],
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "precioRegular": precioRegular,
    "subCategoria": subCategoria,
    "imagen": imagen,
    "stock": stock,
    "precioDescuento": precioDescuento,
    "marca": marca,
    "descripcion": descripcion,
  };
}
