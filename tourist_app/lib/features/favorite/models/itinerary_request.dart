class ItineraryRequest {
  ItineraryRequest({
    required this.address,
    required this.maxDestination,
    required this.travelMode,
  });

  String? address;
  int? maxDestination;
  String? travelMode;

  factory ItineraryRequest.fromJson(Map<String, dynamic> json) {
    return ItineraryRequest(
      address: json["address"],
      maxDestination: json["maxDestination"],
      travelMode: json["travelMode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "maxDestination": maxDestination,
        "travelMode": travelMode,
      };
}
