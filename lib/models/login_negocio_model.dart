class LoginNegocioModel {
  String email;
  String password;

  LoginNegocioModel({
    required this.email,
    required this.password,
  });

  factory LoginNegocioModel.fromJson(Map<String, dynamic> json) => LoginNegocioModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
