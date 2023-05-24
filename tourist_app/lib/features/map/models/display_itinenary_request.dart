class DisplayItineraryRequest {
  DisplayItineraryRequest({
    required this.startLat,
    required this.startLng,
    required this.endLat,
    required this.endLng,
    required this.travelMode,
  });

  double? startLat;
  double? startLng;
  double? endLat;
  double? endLng;
  String? travelMode;

  factory DisplayItineraryRequest.fromJson(Map<String, dynamic> json) {
    return DisplayItineraryRequest(
      startLat: json["startLat"],
      startLng: json["startLng"],
      endLat: json["endLat"],
      endLng: json["endLng"],
      travelMode: json["travelMode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "startLat": startLat,
        "startLng": startLng,
        "endLat": endLat,
        "endLng": endLng,
        "travelMode": travelMode,
      };
}
