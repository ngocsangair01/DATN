class ItineraryResponse {
  ItineraryResponse({
    this.addressDataOutput,
    this.listDestinationDataOutput,
    this.listTime,
    this.listDistance,
    this.travelMode,
  });

  Address? addressDataOutput;
  List<ListDestinationDataOutput>? listDestinationDataOutput;
  List<double>? listTime;
  List<double>? listDistance;
  String? travelMode;

  factory ItineraryResponse.fromJson(Map<String, dynamic> json) {
    return ItineraryResponse(
      addressDataOutput: json["addressDataOutput"] == null
          ? null
          : Address.fromJson(json["addressDataOutput"]),
      listDestinationDataOutput: json["listDestinationDataOutput"] == null
          ? []
          : List<ListDestinationDataOutput>.from(
              json["listDestinationDataOutput"]!
                  .map((x) => ListDestinationDataOutput.fromJson(x))),
      listTime: json["listTime"] == null
          ? []
          : List<double>.from(json["listTime"]!.map((x) => x)),
      listDistance: json["listDistance"] == null
          ? []
          : List<double>.from(json["listDistance"]!.map((x) => x)),
      travelMode: json["travelMode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "addressDataOutput": addressDataOutput?.toJson(),
        "listDestinationDataOutput":
            listDestinationDataOutput?.map((x) => x.toJson()).toList(),
        "listTime": listTime?.map((x) => x).toList(),
        "listDistance": listDistance?.map((x) => x).toList(),
        "travelMode": travelMode,
      };
}

class Address {
  Address({
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
    this.slugWithSpace,
    this.slugWithoutSpace,
    this.status,
  });

  int? id;
  int? createBy;
  DateTime? createAt;
  int? updateBy;
  DateTime? updateAt;
  String? slug;
  double? longitude;
  double? latitude;
  dynamic province;
  String? detailAddress;
  String? slugWithSpace;
  String? slugWithoutSpace;
  bool? status;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      createBy: json["createBy"],
      createAt: DateTime.tryParse(json["createAt"] ?? ""),
      updateBy: json["updateBy"],
      updateAt: DateTime.tryParse(json["updateAt"] ?? ""),
      slug: json["slug"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      province: json["province"],
      detailAddress: json["detailAddress"],
      slugWithSpace: json["slugWithSpace"],
      slugWithoutSpace: json["slugWithoutSpace"],
      status: json["status"],
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
        "province": province,
        "detailAddress": detailAddress,
        "slugWithSpace": slugWithSpace,
        "slugWithoutSpace": slugWithoutSpace,
        "status": status,
      };
}

class ListDestinationDataOutput {
  ListDestinationDataOutput({
    this.id,
    this.name,
    this.description,
    this.destinationType,
    this.address,
    this.images,
    this.commentDestinations,
  });

  int? id;
  String? name;
  String? description;
  DestinationType? destinationType;
  Address? address;
  List<String>? images;
  List<dynamic>? commentDestinations;

  factory ListDestinationDataOutput.fromJson(Map<String, dynamic> json) {
    return ListDestinationDataOutput(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      destinationType: json["destinationType"] == null
          ? null
          : DestinationType.fromJson(json["destinationType"]),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      commentDestinations: json["commentDestinations"] == null
          ? []
          : List<dynamic>.from(json["commentDestinations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "destinationType": destinationType?.toJson(),
        "address": address?.toJson(),
        "images": images?.map((x) => x).toList(),
        "commentDestinations": commentDestinations?.map((x) => x).toList(),
      };
}

class DestinationType {
  DestinationType({
    this.name,
    this.id,
    this.createBy,
    this.createAt,
    this.updateBy,
    this.updateAt,
    this.status,
  });

  String? name;
  int? id;
  int? createBy;
  DateTime? createAt;
  int? updateBy;
  DateTime? updateAt;
  bool? status;

  factory DestinationType.fromJson(Map<String, dynamic> json) {
    return DestinationType(
      name: json["name"],
      id: json["id"],
      createBy: json["createBy"],
      createAt: DateTime.tryParse(json["createAt"] ?? ""),
      updateBy: json["updateBy"],
      updateAt: DateTime.tryParse(json["updateAt"] ?? ""),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "createBy": createBy,
        "createAt": createAt?.toIso8601String(),
        "updateBy": updateBy,
        "updateAt": updateAt?.toIso8601String(),
        "status": status,
      };
}
