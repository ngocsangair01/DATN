class CreateCommentDestination {
  CreateCommentDestination({
    required this.content,
    required this.idDestination,
    required this.rating,
  });

  final String? content;
  final int? idDestination;
  final double? rating;

  factory CreateCommentDestination.fromJson(Map<String, dynamic> json) {
    return CreateCommentDestination(
      content: json["content"],
      idDestination: json["idDestination"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "content": content,
        "idDestination": idDestination,
        "rating": rating,
      };
}
