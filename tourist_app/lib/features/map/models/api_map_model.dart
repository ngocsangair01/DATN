class ApiMapModel {
  ApiMapModel({
    this.plusCode,
    this.results,
    this.status,
  });

  PlusCode? plusCode;
  List<Result>? results;
  String? status;

  factory ApiMapModel.fromJson(Map<String, dynamic> json) {
    return ApiMapModel(
      plusCode: json["plus_code"] == null
          ? null
          : PlusCode.fromJson(json["plus_code"]),
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "plus_code": plusCode?.toJson(),
        "results": results?.map((x) => x.toJson()).toList(),
        "status": status,
      };
}

class PlusCode {
  PlusCode({
    required this.compoundCode,
    required this.globalCode,
  });

  final String? compoundCode;
  final String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      compoundCode: json["compound_code"],
      globalCode: json["global_code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}

class Result {
  Result({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.types,
  });

  List<AddressComponent>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<String>? types;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      addressComponents: json["address_components"] == null
          ? []
          : List<AddressComponent>.from(json["address_components"]!
              .map((x) => AddressComponent.fromJson(x))),
      formattedAddress: json["formatted_address"],
      geometry:
          json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      placeId: json["place_id"],
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "address_components":
            addressComponents?.map((x) => x.toJson()).toList(),
        "formatted_address": formattedAddress,
        "geometry": geometry?.toJson(),
        "place_id": placeId,
        "types": types?.map((x) => x).toList(),
      };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String? longName;
  String? shortName;
  List<String>? types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) {
    return AddressComponent(
      longName: json["long_name"],
      shortName: json["short_name"],
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": types?.map((x) => x).toList(),
      };
}

class Geometry {
  Geometry({
    this.bounds,
    this.location,
    this.locationType,
    this.viewport,
  });

  Bounds? bounds;
  Location? location;
  String? locationType;
  Bounds? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      locationType: json["location_type"],
      viewport:
          json["viewport"] == null ? null : Bounds.fromJson(json["viewport"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "bounds": bounds?.toJson(),
        "location": location?.toJson(),
        "location_type": locationType,
        "viewport": viewport?.toJson(),
      };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: json["northeast"] == null
          ? null
          : Location.fromJson(json["northeast"]),
      southwest: json["southwest"] == null
          ? null
          : Location.fromJson(json["southwest"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json["lat"],
      lng: json["lng"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
