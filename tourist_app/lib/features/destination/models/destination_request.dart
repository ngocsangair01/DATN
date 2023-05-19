import 'dart:io';

import 'package:dio/dio.dart';

class DestinationRequest {
  DestinationRequest({
    this.id,
    this.name,
    this.description,
    this.idAddress,
    this.idDestinationType,
    this.images = const [],
  });

  int? id;
  String? name;
  String? description;
  int? idAddress;
  int? idDestinationType;
  List<File?> images;

  Future<Map<String, dynamic>> toJson() async {
    List<MultipartFile> list = [];
    for (var element in images) {
      list.add(await MultipartFile.fromFile(
        element!.path,
        filename: element.path.split("/").last,
      ));
    }
    final Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "description": description,
      "idAddress": idAddress,
      "idDestinationType": idDestinationType,
      "images": list,
    };
    return data;
  }
}
