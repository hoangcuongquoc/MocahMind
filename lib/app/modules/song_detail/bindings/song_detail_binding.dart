import 'package:get/get.dart';

import '../controllers/song_detail_controller.dart';

class SongDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SongDetailController>(
      () => SongDetailController(),
    );
  }
}
