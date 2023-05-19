class LatLngRequest {
  LatLngRequest({
    required this.lat,
    required this.lon,
  });

  final double? lat;
  final double? lon;

  factory LatLngRequest.fromJson(Map<String, dynamic> json) {
    return LatLngRequest(
      lat: json["lat"],
      lon: json["lon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}
