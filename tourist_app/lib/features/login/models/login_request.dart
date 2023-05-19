class LoginRequestModel {
  LoginRequestModel({
    required this.email,
    required this.password,
  });

  final String? email;
  final String? password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
