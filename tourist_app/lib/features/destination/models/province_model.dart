class ProvinceModel {
  ProvinceModel({
    this.id,
    this.name,
    this.nameShort,
    this.divisionType,
    this.longitude,
    this.latitude,
  });

  int? id;
  String? name;
  String? nameShort;
  String? divisionType;
  double? longitude;
  double? latitude;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json["id"],
      name: json["name"],
      nameShort: json["nameShort"],
      divisionType: json["divisionType"],
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nameShort": nameShort,
        "divisionType": divisionType,
        "longitude": longitude,
        "latitude": latitude,
      };
}
