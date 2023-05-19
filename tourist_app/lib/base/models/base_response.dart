class BaseResponse<T> {
  BaseResponse({
    required this.restStatus,
    required this.message,
    required this.reasons,
    required this.data,
  });

  final String? restStatus;
  final String? message;
  final List<String> reasons;
  final T? data;

  factory BaseResponse.fromJson(
    Map<String, dynamic> json, {
    Function(Map<String, dynamic> x)? func,
  }) {
    T? convertObject() => func != null ? func(json["data"]) : json["data"];
    return BaseResponse(
      restStatus: json["restStatus"],
      message: json["message"],
      reasons: json["reasons"] == null
          ? []
          : List<String>.from(json["reasons"]!.map((x) => x)),
      data: json["data"] != null ? convertObject() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "restStatus": restStatus,
        "message": message,
        "reasons": reasons.map((x) => x).toList(),
        "data": data,
      };
}
