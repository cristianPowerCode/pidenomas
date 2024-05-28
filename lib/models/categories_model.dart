class CategoriesModel {
  // String id;
  String name;
  String icon;

  CategoriesModel({
    // required this.id,
    required this.name,
    required this.icon,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    // id: json["id"],
    name: json["name"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "name": name,
    "icon": icon,
  };
}
