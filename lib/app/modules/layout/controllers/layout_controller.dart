import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../../models/songs_models.dart';

class LayoutController extends GetxController with GetSingleTickerProviderStateMixin {
  // ----- Navigation ----------------------------------------------------------
  late TabController tabController;
  final RxInt navIndex = 0.obs; // index cho BottomNavigationBar & TabBarView

  // ----- Music player --------------------------------------------------------
  final RxInt songIndex = 0.obs;                   // vị trí hiện tại trong playlist
  final Rxn<SongsModel> currentSong = Rxn<SongsModel>();
  final RxList<SongsModel> songs = <SongsModel>[].obs;
  final AudioPlayer audioPlayer = AudioPlayer();
  final Rx<Duration> position = Duration.zero.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isHovered = false.obs;

  // ------------------ Init ---------------------------------------------------
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() => navIndex.value = tabController.index);
    audioPlayer.positionStream.listen((p) => position.value = p);
    audioPlayer.durationStream.listen((d) {
      if (d != null) duration.value = d;
    });
  }

  // ------------------ Navigation ---------------------------------------------
  void onTabTapped(int index) {
    navIndex.value = index;
    tabController.animateTo(index);
  }

  // ------------------ Music controls -----------------------------------------
  void togglePlay() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      audioPlayer.play(); // just_audio dùng play()
    }
    isPlaying.toggle();
  }

  void skipPrevious() {
    if (songs.isEmpty || songIndex.value <= 0) return;
    songIndex.value--;
    _playCurrent();
  }

  void skipNext() {
    if (songs.isEmpty || songIndex.value >= songs.length - 1) return;
    songIndex.value++;
    _playCurrent();
  }

  Future<void> playSong(int index) async {
    if (songs.isEmpty || index < 0 || index >= songs.length) return;

    songIndex.value = index;
    currentSong.value = songs[index];

    try {
      await audioPlayer.stop();
      await audioPlayer.setUrl(currentSong.value!.file_path);

      // Đợi duration sẵn sàng
      Duration? d;
      do {
        await Future.delayed(const Duration(milliseconds: 50));
        d = audioPlayer.duration;
      } while (d == null);
      duration.value = d;

      await audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      print("❌ Error loading song: $e");
    }
  }

  Future<void> _playCurrent() async {
    final song = songs[songIndex.value];
    currentSong.value = song;

    try {
      await audioPlayer.stop();
      await audioPlayer.setUrl(song.file_path);

      // Đợi tới khi duration sẵn sàng
      Duration? d;
      do {
        await Future.delayed(const Duration(milliseconds: 50));
        d = audioPlayer.duration;
      } while (d == null);
      duration.value = d;

      await audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      print("⚠️ Error playing song: $e");
    }
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  // ------------------ Hover effect -------------------------------------------
  void onHover(bool hovering) => isHovered.value = hovering;

  // ------------------ Clean up -----------------------------------------------
  @override
  void onClose() {
    audioPlayer.dispose();
    tabController.dispose();
    super.onClose();
  }
}
