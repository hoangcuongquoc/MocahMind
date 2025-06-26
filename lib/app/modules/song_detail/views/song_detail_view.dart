import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../layout/controllers/layout_controller.dart';
import '../../layout/views/layout_view.dart';
import '../controllers/song_detail_controller.dart';

class SongDetailView extends GetView<SongDetailController> {
  const SongDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final song = controller.song;
    final layout = Get.find<LayoutController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Ảnh nền full màn hình
          Image.network(
            song.image_url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.black),
          ),

          // Lớp phủ mờ
          Container(color: Colors.black.withOpacity(0.6)),

          // AppBar tùy chỉnh
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      song.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Nội dung điều khiển
          Obx(() {
            final pos = layout.position.value;
            final dur = layout.duration.value;

            final max =
            dur.inMilliseconds > 0 ? dur.inMilliseconds.toDouble() : 1.0;
            final value =
            pos.inMilliseconds.clamp(0, max).toDouble();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  song.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  song.performer,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 32),

                // Slider thời gian
                Slider(
                  value: value,
                  min: 0,
                  max: max,
                  onChanged: (val) {
                    layout.seekTo(Duration(milliseconds: val.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatTime(pos),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _formatTime(dur),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Nút điều khiển
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shuffle, color: Colors.white60),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_previous,
                          color: Colors.white, size: 32),
                      onPressed: layout.skipPrevious,
                    ),
                    InkWell(
                      onTap: layout.togglePlay,
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Obx(() => Icon(
                          layout.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.black,
                          size: 32,
                        )),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next,
                          color: Colors.white, size: 32),
                      onPressed: layout.skipNext,
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat, color: Colors.white60),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  String _formatTime(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds.remainder(60))}';
  }
}
