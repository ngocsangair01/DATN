class CommentDestinationResponse {
  CommentDestinationResponse({
    required this.idUser,
    required this.nameUser,
    required this.idDestination,
    required this.content,
    required this.rating,
  });

  final int? idUser;
  final String? nameUser;
  final int? idDestination;
  final String? content;
  final double? rating;

  factory CommentDestinationResponse.fromJson(Map<String, dynamic> json) {
    return CommentDestinationResponse(
      idUser: json["idUser"],
      nameUser: json["nameUser"],
      idDestination: json["idDestination"],
      content: json["content"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "nameUser": nameUser,
        "idDestination": idDestination,
        "content": content,
        "rating": rating,
      };
}
