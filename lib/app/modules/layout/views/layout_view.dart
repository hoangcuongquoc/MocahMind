import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mochamind/app/modules/playlist/views/playlist_view.dart';
import 'package:mochamind/app/modules/searching/views/searching_view.dart';

import '../../../models/songs_models.dart';
// import '../../../widgets/audio_controller.dart';
import '../../category/views/category_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        children: const [
          HomeView(),
          SearchingView(),
          CategoryView(),
          PlaylistView(),
          ProfileView(),

        ],
      ),
      bottomNavigationBar: Obx(
            () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------------- Mini-player ----------------
            _MiniPlayer(controller: controller),

            // ---------------- BottomNav ------------------
            BottomNavigationBar(
              backgroundColor: Colors.grey[900],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              currentIndex: controller.navIndex.value,        // ✅ dùng navIndex
              onTap: controller.onTabTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_filled),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  activeIcon: Icon(Icons.category_rounded),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play_outlined),
                  activeIcon: Icon(Icons.playlist_play),
                  label: 'Playlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  activeIcon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Mini-player widget (tách cho gọn)
// ---------------------------------------------------------------------------

class _MiniPlayer extends StatelessWidget {
  const _MiniPlayer({required this.controller});

  final LayoutController controller;

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final song = controller.currentSong.value;
      if (song == null) return const SizedBox();

      return GestureDetector(
        onTap: () {
          Get.toNamed('/song-detail', arguments: song);
        },
        child: Container(
          color: Colors.grey[900],
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: song.image_url.isNotEmpty
                    ? Image.network(song.image_url, width: 50, height: 50, fit: BoxFit.cover)
                    : Image.network(
                  'https://play-lh.googleusercontent.com/QovZ-E3Uxm4EvjacN-Cv1LnjEv-x5SqFFB5BbhGIwXI_KorjFhEHahRZcXFC6P40Xg',
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      song.title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      song.performer,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Obx(() {
                      final pos = controller.position.value;
                      final dur = controller.duration.value;

                      final max = dur.inMilliseconds > 0 ? dur.inMilliseconds.toDouble() : 1.0;
                      final value = pos.inMilliseconds.clamp(0, max).toDouble();

                      return Column(
                        children: [
                          Slider(
                            value: value,
                            min: 0,
                            max: max,
                            onChanged: (v) {
                              controller.seekTo(Duration(milliseconds: v.toInt()));
                            },
                            activeColor: Colors.blueAccent,
                            inactiveColor: Colors.white24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatTime(pos),
                                  style: const TextStyle(color: Colors.white60, fontSize: 11),
                                ),
                                Text(
                                  _formatTime(dur),
                                  style: const TextStyle(color: Colors.white60, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              _iconBtn(Icons.skip_previous, controller.skipPrevious),
              const SizedBox(width: 12),
              _PlayPauseBtn(controller: controller),
              const SizedBox(width: 12),
              _iconBtn(Icons.skip_next, controller.skipNext),
            ],
          ),
        ),
      );
    });
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Icon(icon, color: Colors.white70),
    ),
  );
}


class _PlayPauseBtn extends StatelessWidget {
  const _PlayPauseBtn({required this.controller});

  final LayoutController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => MouseRegion(
        onEnter: (_) => controller.onHover(true),
        onExit: (_) => controller.onHover(false),
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: controller.togglePlay,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: controller.isHovered.value ? Colors.grey[700] : Colors.transparent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(6),
            child: Icon(
              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}




