import 'package:get/get.dart';

import '../../../models/songs_models.dart';

class SongDetailController extends GetxController {
  //TODO: Implement SongDetailController
  late final SongsModel song;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    song = Get.arguments as SongsModel;

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
}
