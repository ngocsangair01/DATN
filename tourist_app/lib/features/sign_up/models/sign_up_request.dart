class SignUpRequest {
  SignUpRequest({
    required this.dateOfBirth,
    required this.email,
    required this.firstName,
    required this.idAddress,
    required this.lastName,
    required this.password,
    required this.telephone,
  });

  final DateTime? dateOfBirth;
  final String? email;
  final String? firstName;
  final int? idAddress;
  final String? lastName;
  final String? password;
  final String? telephone;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return SignUpRequest(
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      email: json["email"],
      firstName: json["firstName"],
      idAddress: json["idAddress"],
      lastName: json["lastName"],
      password: json["password"],
      telephone: json["telephone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "dateOfBirth":
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "email": email,
        "firstName": firstName,
        "idAddress": idAddress,
        "lastName": lastName,
        "password": password,
        "telephone": telephone,
      };
}
