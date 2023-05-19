class DestinationByProvinceRequest {
  DestinationByProvinceRequest({
    required this.idProvince,
    required this.page,
    required this.size,
  });

  int? idProvince;
  int? page;
  int? size;

  factory DestinationByProvinceRequest.fromJson(Map<String, dynamic> json) {
    return DestinationByProvinceRequest(
      idProvince: json["idProvince"],
      page: json["page"],
      size: json["size"],
    );
  }

  Map<String, dynamic> toJson() => {
        "idProvince": idProvince,
        "page": page,
        "size": size,
      };
}
