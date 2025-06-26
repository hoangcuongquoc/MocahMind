import 'package:get/get.dart';
import 'package:mochamind/app/models/songs_models.dart';
import 'package:mochamind/app/service/songs_service.dart';

class HomeController extends GetxController {
  final SongsService _songsService = SongsService();

  // Danh sách bài hát dạng reactive
  final RxList<SongsModel> songs = <SongsModel>[].obs;

  // Index của bài hát hiện đang phát
  final RxInt currentSongIndex = 0.obs;

  // Trạng thái loading
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSongs(); // Gọi khi controller khởi tạo
  }

  Future<void> fetchSongs() async {
    try {
      isLoading.value = true;

      final fetchedSongs = await _songsService.fetchSongs();
      songs.assignAll(fetchedSongs);
    } catch (e) {
      print('Error loading songs: $e');
      Get.snackbar('Error', 'Không thể tải danh sách bài hát');
    } finally {
      isLoading.value = false;
    }
  }

  SongsModel? get currentSong {
    if (songs.isEmpty || currentSongIndex.value >= songs.length) {
      return null;
    }
    return songs[currentSongIndex.value];
  }

  void playSong(int index) {
    if (index >= 0 && index < songs.length) {
      currentSongIndex.value = index;
    }
  }
}
