class DestinationRadiusResponse {
  DestinationRadiusResponse({
    this.listDestinationDataOutput,
    this.listDistance,
  });

  List<ListDestinationDataOutput>? listDestinationDataOutput;
  List<double>? listDistance;

  factory DestinationRadiusResponse.fromJson(Map<String, dynamic> json) {
    return DestinationRadiusResponse(
      listDestinationDataOutput: json["listDestinationDataOutput"] == null
          ? []
          : List<ListDestinationDataOutput>.from(
              json["listDestinationDataOutput"]!
                  .map((x) => ListDestinationDataOutput.fromJson(x))),
      listDistance: json["listDistance"] == null
          ? []
          : List<double>.from(json["listDistance"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "listDestinationDataOutput":
            listDestinationDataOutput?.map((x) => x.toJson()).toList(),
        "listDistance": listDistance?.map((x) => x).toList(),
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
  List<CommentDestination>? commentDestinations;

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
          : List<CommentDestination>.from(json["commentDestinations"]!
              .map((x) => CommentDestination.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "destinationType": destinationType?.toJson(),
        "address": address?.toJson(),
        "images": images?.map((x) => x).toList(),
        "commentDestinations":
            commentDestinations?.map((x) => x.toJson()).toList(),
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

class CommentDestination {
  CommentDestination({
    this.idUser,
    this.nameUser,
    this.idDestination,
    this.content,
    this.rating,
  });

  int? idUser;
  String? nameUser;
  int? idDestination;
  String? content;
  double? rating;

  factory CommentDestination.fromJson(Map<String, dynamic> json) {
    return CommentDestination(
      idUser: json["idUser"],
      nameUser: json["nameUser"],
      idDestination: json["idDestination"],
      content: json["content"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "nameUser": nameUser,
        "idDestination": idDestination,
        "content": content,
        "rating": rating,
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
