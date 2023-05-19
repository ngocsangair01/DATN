class BaseResponseList<T> {
  BaseResponseList({
    required this.restStatus,
    required this.message,
    required this.reasons,
    required this.data,
  });

  final String? restStatus;
  final String? message;
  final List<String> reasons;
  final List<T> data;

  factory BaseResponseList.fromJson(
      Map<String, dynamic> json, Function(dynamic x) func) {
    return BaseResponseList(
      restStatus: json["restStatus"],
      message: json["message"],
      reasons: json["reasons"] == null
          ? []
          : List<String>.from(json["reasons"]!.map((x) => x)),
      data: json["data"] != null
          ? List<T>.from(json["data"].map((x) => func(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson(Function(dynamic x) func) => {
        "restStatus": restStatus,
        "message": message,
        "reasons": reasons.map((x) => x).toList(),
        "data": List<dynamic>.from(data.map((x) => func)),
      };
}
