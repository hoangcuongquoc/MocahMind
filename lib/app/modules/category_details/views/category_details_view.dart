import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/songs_models.dart';
import '../../../widgets/audio_controller.dart';
import '../controllers/category_details_controller.dart';

class CategoryDetailsView extends GetView<CategoryDetailsController> {
  const CategoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(controller.categoryName,
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: controller.obx(
            (songs) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: songs!.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _SongTile(song: songs[i]),
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(
          child: Text("Chưa có bài hát",
              style: TextStyle(color: Colors.white70)),
        ),
        onError: (err) => Center(
          child: Text("Lỗi: $err", style: const TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  final SongsModel song;
  const _SongTile({required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      tileColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          song.image_url,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            width: 56,
            height: 56,
            color: Colors.grey,
            child: const Icon(Icons.music_note, color: Colors.white54),
          ),
        ),
      ),
      title: Text(song.title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      subtitle: Text(song.performer,
          style: const TextStyle(color: Colors.white60, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: () {
        final audio = Get.find<AudioController>();
        audio.play(song.file_path); // ⬅️ Dùng đường dẫn từ Supabase (đã có trong song.file_path)

        // Optionally: hiện snackbar hoặc chuyển qua player screen
        Get.snackbar("Đang phát", song.title,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black87,
          colorText: Colors.white,
        );
      },

    );
  }
}
