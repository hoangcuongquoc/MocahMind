import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../layout/controllers/layout_controller.dart';
import '../controllers/playlist_details_controller.dart';

class PlaylistDetailsView extends GetView<PlaylistDetailsController> {
  const PlaylistDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final title = controller.playlist.value?.name ?? 'Playlist';
          return Text(title);
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.songs.isEmpty) {
          return const Center(child: Text('Playlist chưa có bài hát nào.'));
        }

        return ListView.separated(
          itemCount: controller.songs.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final song = controller.songs[index];
            return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    song.image_url,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.music_note),
                  ),
                ),
                title: Text(song.title),
                subtitle: Text(song.performer),
                trailing: Text('${song.duration.toStringAsFixed(1)}s'),
                onTap: () {
                  print('📀 Đang phát bài: ${song.title}');
                  final layout = Get.find<LayoutController>();
                  layout.songs.assignAll(controller.songs);
                  layout.playSong(index);
                }



            );
          },
        );
      }),
    );
  }
}
