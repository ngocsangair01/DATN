class AddressRequestList {
  AddressRequestList({
    this.idProvince,
    this.keyword,
    this.size,
    this.page,
  });

  final int? idProvince;
  final String? keyword;
  final int? size;
  final int? page;

  factory AddressRequestList.fromJson(Map<String, dynamic> json) {
    return AddressRequestList(
      idProvince: json["idProvince"],
      keyword: json["keyword"],
      size: json["size"],
      page: json["page"],
    );
  }

  Map<String, dynamic> toJson() => {
        "idProvince": idProvince,
        "keyword": keyword,
        "size": size,
        "page": page,
      };
}
