class BaseRequestListModel {
  BaseRequestListModel({
    required this.keyword,
    required this.page,
    required this.size,
  });

  String? keyword;
  int? page;
  int? size;

  factory BaseRequestListModel.fromJson(Map<String, dynamic> json) {
    return BaseRequestListModel(
      keyword: json["keyword"],
      page: json["page"],
      size: json["size"],
    );
  }

  Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "page": page,
        "size": size,
      };
}
