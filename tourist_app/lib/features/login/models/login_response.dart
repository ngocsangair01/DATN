class LoginResponseModel {
  LoginResponseModel({
    required this.restStatus,
    required this.message,
    required this.reasons,
    required this.data,
  });

  final String? restStatus;
  final String? message;
  final String? reasons;
  final Data? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      restStatus: json["restStatus"],
      message: json["message"],
      reasons: json["reasons"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "restStatus": restStatus,
        "message": message,
        "reasons": reasons,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.jwt,
    required this.userId,
    required this.username,
    required this.roles,
  });

  final String? jwt;
  final int? userId;
  final String? username;
  final List<String> roles;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      jwt: json["jwt"],
      userId: json["userId"],
      username: json["username"],
      roles: json["roles"] == null
          ? []
          : List<String>.from(json["roles"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "userId": userId,
        "username": username,
        "roles": roles.map((x) => x).toList(),
      };
}
