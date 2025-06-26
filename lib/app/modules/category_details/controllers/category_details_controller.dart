import 'package:get/get.dart';
import '../../../models/songs_models.dart';
import '../../../service/songs_service.dart';

class CategoryDetailsController extends GetxController
    with StateMixin<List<SongsModel>> {
  final SongsService _songsService = SongsService();

  late final String categoryId;
  late final String categoryName;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    categoryId = args['id'];
    categoryName = args['name'];
    _fetchSongs();
  }

  Future<void> _fetchSongs() async {
    change(null, status: RxStatus.loading());
    try {
      final songs = await _songsService.getSongsByCategory(categoryId);
      change(songs, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
