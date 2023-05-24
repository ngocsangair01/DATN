import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/repositories/destination_repository.dart';

abstract class FavoriteCtrl extends BasePageSearchController<DestinationModel> {
  late DestinationRepository destinationRepository;
  FavoriteCtrl() {
    destinationRepository = DestinationRepository(this);
  }
  // RxList<DestinationModel> listFavorite = RxList([]);
  Future<void> getListDestinationFav({bool isRefresh = false});
  Future<void> deleteDestinationFav(int id);
  void goToDestinationDetail({int? id});
}
