class AgregarProductosModel {
  String nombre;
  double precioRegular;
  int categoria;
  String imagen;
  bool stock;
  double precioDescuento;
  String marca;
  String descripcion;

  AgregarProductosModel({
    required this.nombre,
    required this.precioRegular,
    required this.categoria,
    required this.imagen,
    required this.stock,
    required this.precioDescuento,
    required this.marca,
    required this.descripcion,
  });

  factory AgregarProductosModel.fromJson(Map<String, dynamic> json) => AgregarProductosModel(
    nombre: json["nombre"],
    precioRegular: json["precioRegular"]?.toDouble(),
    categoria: json["categoria"],
    imagen: json["imagen"],
    stock: json["stock"],
    precioDescuento: json["precioDescuento"]?.toDouble(),
    marca: json["marca"],
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "precioRegular": precioRegular,
    "categoria": categoria,
    "imagen": imagen,
    "stock": stock,
    "precioDescuento": precioDescuento,
    "marca": marca,
    "descripcion": descripcion,
  };
}