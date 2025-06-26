import 'package:get/get.dart';

import '../../../models/songs_models.dart';
import '../../../service/songs_service.dart';

class SearchingController extends GetxController {
  //TODO: Implement SearchingController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  final RxList<SongsModel> results = <SongsModel>[].obs;
  final _service = SongsService();

  void searchSongs(String keyword) async {
    if (keyword.trim().isEmpty) {
      results.clear();
      return;
    }

    final songs = await _service.searchSongsByName(keyword);
    results.assignAll(songs);
  }

}
