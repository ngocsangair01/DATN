class UserRequest {
  UserRequest({
    this.idAddress,
    this.dateOfBirth,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.telephone,
  });

  int? idAddress;
  DateTime? dateOfBirth;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? telephone;

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return UserRequest(
      idAddress: json["idAddress"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      email: json["email"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      password: json["password"],
      telephone: json["telephone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "idAddress": idAddress,
        "dateOfBirth":
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
        "telephone": telephone,
      };
}
