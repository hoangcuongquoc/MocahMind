import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/playlist_models.dart';
import '../../../service/playlist_service.dart';

class PlaylistController extends GetxController {
  final PlaylistService _playlistService = PlaylistService();

  // Danh sách playlist
  RxList<Playlist> playlists = <Playlist>[].obs;

  // Trạng thái loading
  RxBool isLoading = false.obs;

  // Lỗi (nếu có)
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPlaylists();
  }

  /// 🔹 Lấy danh sách playlists từ Supabase
  Future<void> fetchPlaylists() async {
    try {
      isLoading.value = true;

      final userId = _playlistService.client.auth.currentUser?.id;
      print('🧾 Supabase user_id hiện tại: $userId'); // ✅ DEBUG

      final data = await _playlistService.getAllPlaylists();
      playlists.assignAll(data);
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = 'Lỗi khi tải playlist: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPlaylist(String name, String description,String imageUrl) async {
    try {
      await _playlistService.createPlaylist(name, description, imageUrl);
      await fetchPlaylists();
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể tạo playlist: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// 🔹 Reload thủ công (cho pull-to-refresh)
  Future<void> reload() => fetchPlaylists();

  /// 🔹 Thêm bài hát vào playlist (append songId vào song_ids[])
  Future<void> addSongToPlaylist(int playlistId, String songId) async {
    try {
      await _playlistService.addSongToPlaylist(playlistId, songId);
      await fetchPlaylists(); // refresh để cập nhật
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Không thể thêm bài hát vào playlist',
        backgroundColor: Get.theme.colorScheme.errorContainer,
        colorText: Get.theme.colorScheme.onErrorContainer,
      );
    }
  }
  Future<void> updatePlaylist({
    required int id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isPined,
  }) async {
    try {
      await _playlistService.updatePlaylist(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        isPined: isPined,
      );
      await fetchPlaylists();
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể cập nhật playlist: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }



  Future<void> deletePlaylist(int id) async {
    try {
      await _playlistService.deletePlaylist(id);
      await fetchPlaylists();
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể xoá playlist: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

}
