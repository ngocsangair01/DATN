import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tourist_app/features/login/models/login_model.dart';

import '../cores/apps/app_controller.dart';
import '../cores/values/strings.dart';

void registerAdapters() {
  Hive.registerAdapter(UserAdapter());
}

Future<void> openBox() async {
  //Set SecureStorage

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  // Open Hive Box
  Hive.init(
      appDocumentDirectory.path + Platform.pathSeparator + AppStr.appName);
  HIVE_APP = await Hive.openBox(AppStr.appName);
  HIVE_USER = await Hive.openBox("${AppStr.appName}User");
}
