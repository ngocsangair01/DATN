class ItineraryResponse {
  ItineraryResponse({
    this.address,
    this.listDestinationOutput,
    this.listTime,
    this.listDistance,
    this.travelMode,
  });

  Address? address;
  List<ListDestinationOutput>? listDestinationOutput;
  List<int>? listTime;
  List<double>? listDistance;
  String? travelMode;

  factory ItineraryResponse.fromJson(Map<String, dynamic> json) {
    return ItineraryResponse(
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      listDestinationOutput: json["listDestinationOutput"] == null
          ? []
          : List<ListDestinationOutput>.from(json["listDestinationOutput"]!
              .map((x) => ListDestinationOutput.fromJson(x))),
      listTime: json["listTime"] == null
          ? []
          : List<int>.from(json["listTime"]!.map((x) => x)),
      listDistance: json["listDistance"] == null
          ? []
          : List<double>.from(json["listDistance"]!.map((x) => x)),
      travelMode: json["travelMode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "listDestinationOutput":
            listDestinationOutput?.map((x) => x?.toJson()).toList(),
        "listTime": listTime?.map((x) => x).toList(),
        "listDistance": listDistance?.map((x) => x).toList(),
        "travelMode": travelMode,
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
  dynamic updateBy;
  DateTime? updateAt;
  dynamic status;

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

class ListDestinationOutput {
  ListDestinationOutput({
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
  dynamic images;
  List<dynamic>? commentDestinations;

  factory ListDestinationOutput.fromJson(Map<String, dynamic> json) {
    return ListDestinationOutput(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      destinationType: json["destinationType"] == null
          ? null
          : DestinationType.fromJson(json["destinationType"]),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      images: json["images"],
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
        "images": images,
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
  dynamic updateBy;
  DateTime? updateAt;
  dynamic status;

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
