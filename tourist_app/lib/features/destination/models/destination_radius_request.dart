class DestinationRadiusRequest {
  DestinationRadiusRequest({
    this.keyword,
    this.radius,
    this.page,
    this.size,
  });

  String? keyword;
  double? radius;
  int? page;
  int? size;

  factory DestinationRadiusRequest.fromJson(Map<String, dynamic> json) {
    return DestinationRadiusRequest(
      keyword: json["keyword"],
      radius: json["radius"],
      page: json["page"],
      size: json["size"],
    );
  }

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "radius": radius,
        "page": page,
        "size": size,
      };
}
