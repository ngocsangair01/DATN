class DisplayItineraryModel {
  DisplayItineraryModel({
    required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });

  final List<GeocodedWaypoint> geocodedWaypoints;
  final List<Route> routes;
  final String? status;

  factory DisplayItineraryModel.fromJson(Map<String, dynamic> json) {
    return DisplayItineraryModel(
      geocodedWaypoints: json["geocoded_waypoints"] == null
          ? []
          : List<GeocodedWaypoint>.from(json["geocoded_waypoints"]!
              .map((x) => GeocodedWaypoint.fromJson(x))),
      routes: json["routes"] == null
          ? []
          : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "geocoded_waypoints":
            geocodedWaypoints.map((x) => x?.toJson()).toList(),
        "routes": routes.map((x) => x?.toJson()).toList(),
        "status": status,
      };
}

class GeocodedWaypoint {
  GeocodedWaypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  final String? geocoderStatus;
  final String? placeId;
  final List<String> types;

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) {
    return GeocodedWaypoint(
      geocoderStatus: json["geocoder_status"],
      placeId: json["place_id"],
      types: json["types"] == null
          ? []
          : List<String>.from(json["types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "geocoder_status": geocoderStatus,
        "place_id": placeId,
        "types": types.map((x) => x).toList(),
      };
}

class Route {
  Route({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });

  final Bounds? bounds;
  final String? copyrights;
  final List<Leg> legs;
  final PolylineModel? overviewPolyline;
  final String? summary;
  final List<dynamic> warnings;
  final List<dynamic> waypointOrder;

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
      copyrights: json["copyrights"],
      legs: json["legs"] == null
          ? []
          : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
      overviewPolyline: json["overview_polyline"] == null
          ? null
          : PolylineModel.fromJson(json["overview_polyline"]),
      summary: json["summary"],
      warnings: json["warnings"] == null
          ? []
          : List<dynamic>.from(json["warnings"]!.map((x) => x)),
      waypointOrder: json["waypoint_order"] == null
          ? []
          : List<dynamic>.from(json["waypoint_order"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "bounds": bounds?.toJson(),
        "copyrights": copyrights,
        "legs": legs.map((x) => x?.toJson()).toList(),
        "overview_polyline": overviewPolyline?.toJson(),
        "summary": summary,
        "warnings": warnings.map((x) => x).toList(),
        "waypoint_order": waypointOrder.map((x) => x).toList(),
      };
}

class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });

  final Northeast? northeast;
  final Northeast? southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      northeast: json["northeast"] == null
          ? null
          : Northeast.fromJson(json["northeast"]),
      southwest: json["southwest"] == null
          ? null
          : Northeast.fromJson(json["southwest"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
      };
}

class Northeast {
  Northeast({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  factory Northeast.fromJson(Map<String, dynamic> json) {
    return Northeast(
      lat: json["lat"],
      lng: json["lng"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Leg {
  Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.trafficSpeedEntry,
    required this.viaWaypoint,
  });

  final Distance? distance;
  final Distance? duration;
  final String? endAddress;
  final Northeast? endLocation;
  final String? startAddress;
  final Northeast? startLocation;
  final List<Step> steps;
  final List<dynamic> trafficSpeedEntry;
  final List<dynamic> viaWaypoint;

  factory Leg.fromJson(Map<String, dynamic> json) {
    return Leg(
      distance:
          json["distance"] == null ? null : Distance.fromJson(json["distance"]),
      duration:
          json["duration"] == null ? null : Distance.fromJson(json["duration"]),
      endAddress: json["end_address"],
      endLocation: json["end_location"] == null
          ? null
          : Northeast.fromJson(json["end_location"]),
      startAddress: json["start_address"],
      startLocation: json["start_location"] == null
          ? null
          : Northeast.fromJson(json["start_location"]),
      steps: json["steps"] == null
          ? []
          : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
      trafficSpeedEntry: json["traffic_speed_entry"] == null
          ? []
          : List<dynamic>.from(json["traffic_speed_entry"]!.map((x) => x)),
      viaWaypoint: json["via_waypoint"] == null
          ? []
          : List<dynamic>.from(json["via_waypoint"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "distance": distance?.toJson(),
        "duration": duration?.toJson(),
        "end_address": endAddress,
        "end_location": endLocation?.toJson(),
        "start_address": startAddress,
        "start_location": startLocation?.toJson(),
        "steps": steps.map((x) => x?.toJson()).toList(),
        "traffic_speed_entry": trafficSpeedEntry.map((x) => x).toList(),
        "via_waypoint": viaWaypoint.map((x) => x).toList(),
      };
}

class Distance {
  Distance({
    required this.text,
    required this.value,
  });

  final String? text;
  final int? value;

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      text: json["text"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
      };
}

class Step {
  Step({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    required this.startLocation,
    required this.travelMode,
    required this.maneuver,
  });

  final Distance? distance;
  final Distance? duration;
  final Northeast? endLocation;
  final String? htmlInstructions;
  final PolylineModel? polyline;
  final Northeast? startLocation;
  final String? travelMode;
  final String? maneuver;

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      distance:
          json["distance"] == null ? null : Distance.fromJson(json["distance"]),
      duration:
          json["duration"] == null ? null : Distance.fromJson(json["duration"]),
      endLocation: json["end_location"] == null
          ? null
          : Northeast.fromJson(json["end_location"]),
      htmlInstructions: json["html_instructions"],
      polyline: json["polyline"] == null
          ? null
          : PolylineModel.fromJson(json["polyline"]),
      startLocation: json["start_location"] == null
          ? null
          : Northeast.fromJson(json["start_location"]),
      travelMode: json["travel_mode"],
      maneuver: json["maneuver"],
    );
  }

  Map<String, dynamic> toJson() => {
        "distance": distance?.toJson(),
        "duration": duration?.toJson(),
        "end_location": endLocation?.toJson(),
        "html_instructions": htmlInstructions,
        "polyline": polyline?.toJson(),
        "start_location": startLocation?.toJson(),
        "travel_mode": travelMode,
        "maneuver": maneuver,
      };
}

class PolylineModel {
  PolylineModel({
    required this.points,
  });

  final String? points;

  factory PolylineModel.fromJson(Map<String, dynamic> json) {
    return PolylineModel(
      points: json["points"],
    );
  }

  Map<String, dynamic> toJson() => {
        "points": points,
      };
}
