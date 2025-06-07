import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../models/category_models.dart';
import 'package:flutter/material.dart';
import '../../../service/category.dart';
class CategoryController extends GetxController with StateMixin<List<CategoryModel?>>{
  //TODO: Implement CategoryController
final categoryService = CategoryService();
late final categoryData = RxList<CategoryModel>([]);
final isLoading = false.obs;
  final count = 0.obs;


  @override
  void onInit() async{
    super.onInit();
    await getCategory();
  }

  Future<void> getCategory() async{
    change(null, status: RxStatus.loading());
    try{
      categoryData.value = await categoryService.getCategory();
      change(categoryData.value, status: RxStatus.success());
    }catch(e){
      change(null, status: RxStatus.error(e.toString()));
    }
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
