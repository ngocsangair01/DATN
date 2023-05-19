import 'package:hive/hive.dart';
import 'package:tourist_app/hive_helper/hive_types.dart';
import 'package:tourist_app/hive_helper/hive_adapters.dart';
import 'package:tourist_app/hive_helper/fields/user_fields.dart';

part 'login_model.g.dart';

@HiveType(typeId: HiveTypes.user, adapterName: HiveAdapters.user)
class User extends HiveObject {
  User({
    required this.jwt,
    required this.userId,
    required this.username,
    required this.roles,
  });

  @HiveField(UserFields.jwt)
  final String? jwt;
  @HiveField(UserFields.userId)
  final int? userId;
  @HiveField(UserFields.username)
  final String? username;
  @HiveField(UserFields.roles)
  final List<String> roles;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      jwt: json["jwt"],
      userId: json["userId"],
      username: json["username"],
      roles: json["roles"] == null
          ? []
          : List<String>.from(json["roles"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "userId": userId,
        "username": username,
        "roles": roles.map((x) => x).toList(),
      };
}
