import 'package:get/get.dart';
import 'package:mochamind/app/modules/category/controllers/category_controller.dart';
import 'package:mochamind/app/modules/home/controllers/home_controller.dart';
import 'package:mochamind/app/modules/playlist/controllers/playlist_controller.dart';

import '../../profile/controllers/profile_controller.dart';
import '../../searching/controllers/searching_controller.dart';
import '../controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.lazyPut<HomeController>(
          ()=>HomeController()
    );
    Get.lazyPut<CategoryController>(
            ()=>CategoryController()
    );

    Get.lazyPut<SearchingController>(
            ()=>SearchingController()
    );
    Get.lazyPut<PlaylistController>(
          () => PlaylistController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),

    );



  }
}
