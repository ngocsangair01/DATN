class AddressResponse {
  AddressResponse({
    this.id,
    this.createBy,
    this.createAt,
    this.updateBy,
    this.updateAt,
    this.slug,
    this.longitude,
    this.latitude,
    this.province,
    this.detailAddress,
  });

  int? id;
  int? createBy;
  DateTime? createAt;
  dynamic updateBy;
  DateTime? updateAt;
  String? slug;
  double? longitude;
  double? latitude;
  Province? province;
  String? detailAddress;

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      id: json["id"],
      createBy: json["createBy"],
      createAt: DateTime.tryParse(json["createAt"] ?? ""),
      updateBy: json["updateBy"],
      updateAt: DateTime.tryParse(json["updateAt"] ?? ""),
      slug: json["slug"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      province:
          json["province"] == null ? null : Province.fromJson(json["province"]),
      detailAddress: json["detailAddress"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "createBy": createBy,
        "createAt": createAt?.toIso8601String(),
        "updateBy": updateBy,
        "updateAt": updateAt?.toIso8601String(),
        "slug": slug,
        "longitude": longitude,
        "latitude": latitude,
        "province": province?.toJson(),
        "detailAddress": detailAddress,
      };
}

class Province {
  Province({
    this.id,
    this.name,
    this.divisionType,
    this.longitude,
    this.latitude,
  });

  int? id;
  String? name;
  String? divisionType;
  double? longitude;
  double? latitude;

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json["id"],
      name: json["name"],
      divisionType: json["divisionType"],
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "divisionType": divisionType,
        "longitude": longitude,
        "latitude": latitude,
      };
}
