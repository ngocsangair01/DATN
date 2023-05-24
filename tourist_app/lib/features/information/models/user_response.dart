class UserResponse {
  UserResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.address,
    this.telephone,
    this.email,
    this.password,
  });

  int? id;
  String? firstName;
  String? lastName;
  DateTime? dateOfBirth;
  Address? address;
  String? telephone;
  String? email;
  String? password;

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      telephone: json["telephone"],
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "dateOfBirth":
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "address": address?.toJson(),
        "telephone": telephone,
        "email": email,
        "password": password,
      };
}

class Address {
  Address({
    this.detailAddress,
    this.slugWithSpace,
    this.slug,
    this.slugWithoutSpace,
    this.longitude,
    this.latitude,
    this.id,
    this.createBy,
    this.createAt,
    this.updateBy,
    this.updateAt,
    this.status,
  });

  String? detailAddress;
  String? slugWithSpace;
  String? slug;
  String? slugWithoutSpace;
  double? longitude;
  double? latitude;
  int? id;
  int? createBy;
  DateTime? createAt;
  int? updateBy;
  DateTime? updateAt;
  bool? status;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      detailAddress: json["detailAddress"],
      slugWithSpace: json["slugWithSpace"],
      slug: json["slug"],
      slugWithoutSpace: json["slugWithoutSpace"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      id: json["id"],
      createBy: json["createBy"],
      createAt: DateTime.tryParse(json["createAt"] ?? ""),
      updateBy: json["updateBy"],
      updateAt: DateTime.tryParse(json["updateAt"] ?? ""),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "detailAddress": detailAddress,
        "slugWithSpace": slugWithSpace,
        "slug": slug,
        "slugWithoutSpace": slugWithoutSpace,
        "longitude": longitude,
        "latitude": latitude,
        "id": id,
        "createBy": createBy,
        "createAt": createAt?.toIso8601String(),
        "updateBy": updateBy,
        "updateAt": updateAt?.toIso8601String(),
        "status": status,
      };
}
