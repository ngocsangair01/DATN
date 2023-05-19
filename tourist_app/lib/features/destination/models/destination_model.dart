class DestinationModel {
  DestinationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.destinationType,
    required this.address,
    required this.images,
    required this.commentDestinations,
  });

  int? id;
  String name;
  String? description;
  DestinationType? destinationType;
  Address? address;
  List<String> images;
  List<CommentDestination> commentDestinations;

  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
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
        "images": images.map((x) => x).toList(),
        "commentDestinations":
            commentDestinations.map((x) => x?.toJson()).toList(),
      };
}

class Address {
  Address({
    required this.detailAddress,
    required this.slugWithSpace,
    required this.slug,
    required this.slugWithoutSpace,
    required this.longitude,
    required this.latitude,
    required this.id,
    required this.createBy,
    required this.createAt,
    required this.updateBy,
    required this.updateAt,
    required this.status,
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

class CommentDestination {
  CommentDestination({
    required this.idUser,
    required this.nameUser,
    required this.idDestination,
    required this.content,
    required this.rating,
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
    required this.name,
    required this.id,
    required this.createBy,
    required this.createAt,
    required this.updateBy,
    required this.updateAt,
    required this.status,
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
