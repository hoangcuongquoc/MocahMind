import 'package:get/get.dart';
import 'package:mochamind/app/models/songs_models.dart';

import '../../../service/songs_service.dart';

class HomeController extends GetxController {
  final RxBool isPlaying = false.obs;
  final RxInt currentSongIndex = 0.obs;
  final RxList<SongsModel> songs = <SongsModel>[].obs;
  final count = 0.obs;

  final SongsService _songsService = SongsService(); // gọi service
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchSongs();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  Future<void> fetchSongs() async {
    try {
      final result = await _songsService.fetchSongs();
      songs.assignAll(result);
    } catch (e) {
      print("Lỗi khi lấy danh sách bài hát: $e");
    }
  }




  // final List<Map<String, dynamic>> popularArtists = [
  //   {'name': 'Doechii', 'image': 'assets/artists/doechii.jpg'},
  //   {'name': 'Hozier', 'image': 'assets/artists/hozier.jpg'},
  //   {'name': 'SZA', 'image': 'assets/artists/sza.jpg'},
  //   {'name': 'Jelly Roll', 'image': 'assets/artists/jelly_roll.jpg'},
  // ];
  //
  // final List<Map<String, dynamic>> trendingVideos = [
  //   {'title': 'Laugh Now Cry Later', 'artist': 'Drake', 'image': 'assets/song/Mysky.jpg'},
  //   {'title': 'Gangsta', 'artist': 'Keha & AFJR', 'image': 'assets/song/Mysky.jpg'},
  // ];
  //
  // final List<Map<String, dynamic>> topSongs = [
  //   {'title': 'Die With A Smile', 'artist': 'Lady Gaga & Bruno Mars', 'image': 'assets/song/Mysky.jpg'},
  //   {'title': 'Not Like Us', 'artist': 'Kendrick Lamar', 'image':'assets/song/Mysky.jpg'},
  //   {'title': 'Lose Control', 'artist': 'Teddy Swims', 'image': 'assets/song/Mysky.jpg'},
  // ];
  //
  // void togglePlay() {
  //   isPlaying.value = !isPlaying.value;
  // }
  //
  // void skipPrevious() {
  //   if (currentSongIndex.value > 0) currentSongIndex.value--;
  // }
  //
  // void skipNext() {
  //   if (currentSongIndex.value < topSongs.length - 1) currentSongIndex.value++;
  // }
}
