import 'package:hive/hive.dart';
import 'package:tourist_app/features/login/models/login_model.dart';

void registerAdapters() {
  Hive.registerAdapter(UserAdapter());
}
