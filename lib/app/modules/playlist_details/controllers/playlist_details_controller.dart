import 'package:get/get.dart';
import '../../../models/playlist_models.dart';
import '../../../models/songs_models.dart';
import '../../../service/playlist_service.dart';


class PlaylistDetailsController extends GetxController {
  final PlaylistService _playlistService = PlaylistService();

  late int playlistId;

  Rx<Playlist?> playlist = Rx<Playlist?>(null);
  RxList<SongsModel> songs = <SongsModel>[].obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments;
    if (arg is Playlist) {
      playlist.value = arg;
      playlistId = arg.id;
      fetchPlaylistDetails();
    } else {
      errorMessage.value = 'Không tìm thấy playlist.';
    }
  }


  Future<void> fetchPlaylistDetails() async {
    try {
      isLoading.value = true;

      // Lấy playlist chính
      final all = await _playlistService.getAllPlaylists();
      playlist.value = all.firstWhere((p) => p.id == playlistId);

      // Lấy bài hát trong playlist
      if (playlist.value != null && playlist.value!.songIds.isNotEmpty) {
        songs.value = await _playlistService.getSongsInPlaylist(playlist.value!.songIds);
      } else {
        songs.clear();
      }

    } catch (e) {
      errorMessage.value = 'Lỗi khi tải chi tiết playlist: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
