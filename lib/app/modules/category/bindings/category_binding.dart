import 'package:get/get.dart';
import 'package:mochamind/app/modules/category_details/controllers/category_details_controller.dart';

import '../controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<CategoryDetailsController>(
          () => CategoryDetailsController(),
    );
  }
}
