class BaseRequestPageSize {
  BaseRequestPageSize({
    required this.page,
    required this.size,
  });

  final int? page;
  final int? size;

  factory BaseRequestPageSize.fromJson(Map<String, dynamic> json) {
    return BaseRequestPageSize(
      page: json["page"],
      size: json["size"],
    );
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
      };
}
