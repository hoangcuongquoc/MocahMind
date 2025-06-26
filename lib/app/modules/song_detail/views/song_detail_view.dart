import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../layout/controllers/layout_controller.dart';
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
          // Ảnh nền
          Image.network(
            song.image_url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.black),
          ),

          // Lớp phủ tối
          Container(color: Colors.black.withOpacity(0.6)),

          // Nội dung
          Obx(() {
            final pos = layout.position.value;
            final dur = layout.duration.value;

            final max = dur.inMilliseconds > 0
                ? dur.inMilliseconds.toDouble()
                : 1.0;
            final value = pos.inMilliseconds.clamp(0, max).toDouble();

            return Column(
              children: [
                const SizedBox(height: 40),

                // Icon Back
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30),
                    onPressed: () => Get.back(),
                  ),
                ),

                const Spacer(),

                // Ảnh bìa
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(song.image_url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Tên bài hát + performer dưới ảnh bìa
                Column(
                  children: [
                    Text(
                      song.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      song.performer,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Thanh Slider
                Slider(
                  value: value,
                  min: 0,
                  max: max,
                  onChanged: (val) {
                    layout.seekTo(Duration(milliseconds: val.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white30,
                ),

                // Thời gian hiện tại bên trái
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _formatTime(pos),
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Điều khiển phát nhạc
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous_rounded, size: 30),
                      color: Colors.white,
                      onPressed: layout.skipPrevious,
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: layout.togglePlay,
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            layout.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 36,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded, size: 30),
                      color: Colors.white,
                      onPressed: layout.skipNext,
                    ),
                  ],
                ),

                const Spacer(),
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