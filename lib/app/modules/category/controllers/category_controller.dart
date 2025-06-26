import 'package:get/get.dart';
import '../../../models/category_models.dart';
import '../../../service/category.dart';

class CategoryController extends GetxController
    with StateMixin<List<CategoryModel>> {
  // ────────────────────────────────────────────────────────────────────
  // DỊCH VỤ & BIẾN
  // ────────────────────────────────────────────────────────────────────
  final CategoryService _categoryService = CategoryService();

  /// Danh sách thể loại (toàn bộ)
  final RxList<CategoryModel> _categoryData = <CategoryModel>[].obs;

  /// Chuỗi tìm kiếm
  final RxString _search = ''.obs;

  // ────────────────────────────────────────────────────────────────────
  // GETTERS
  // ────────────────────────────────────────────────────────────────────
  /// Danh sách filter theo `_search`
  List<CategoryModel> get filteredData => _search.value.isEmpty
      ? _categoryData
      : _categoryData
      .where((c) =>
      c.name.toLowerCase().contains(_search.value.toLowerCase()))
      .toList();

  // ────────────────────────────────────────────────────────────────────
  // LIFE-CYCLE
  // ────────────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _fetchCategories();
  }

  // ────────────────────────────────────────────────────────────────────
  // PUBLIC METHODS
  // ────────────────────────────────────────────────────────────────────
  /// Gọi khi gõ ô tìm kiếm
  void onSearchChanged(String value) => _search.value = value;

  // ────────────────────────────────────────────────────────────────────
  // PRIVATE
  // ────────────────────────────────────────────────────────────────────
  Future<void> _fetchCategories() async {
    change([], status: RxStatus.loading());
    try {
      final result = await _categoryService.getCategory();
      _categoryData.assignAll(result);
      change(_categoryData, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }
}
