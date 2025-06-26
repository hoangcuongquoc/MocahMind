import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/playlist_models.dart';
import '../controllers/playlist_controller.dart';

class PlaylistView extends GetView<PlaylistController> {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Playlists', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value, style: const TextStyle(color: Colors.white70)));
        }

        if (controller.playlists.isEmpty) {
          return const Center(child: Text('Không có playlist nào.', style: TextStyle(color: Colors.white70)));
        }

        return ListView.builder(
          itemCount: controller.playlists.length,
          itemBuilder: (context, index) {
            final playlist = controller.playlists[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: playlist.picture.isNotEmpty
                      ? NetworkImage(playlist.picture)
                      : const NetworkImage('https://static.wixstatic.com/media/b42422_d833eeac7f9e46b8b12b8689410c9630~mv2.jpg/v1/fill/w_568,h_364,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/b42422_d833eeac7f9e46b8b12b8689410c9630~mv2.jpg'),
                ),
                title: Text(playlist.name, style: const TextStyle(color: Colors.white)),
                subtitle: Text('${playlist.songIds.length} bài hát', style: const TextStyle(color: Colors.white70)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (playlist.isPined)
                      const Icon(Icons.push_pin, color: Colors.orange),
                    PopupMenuButton<String>(
                      color: const Color(0xFF2A2A2A),
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) async {
                        if (value == 'edit') {
                          _showEditPlaylistDialog(context, playlist);
                        } else if (value == 'delete') {
                          final confirmed = await Get.dialog(AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: const Text('Xoá Playlist', style: TextStyle(color: Colors.white)),
                            content: Text('Bạn có chắc muốn xoá "${playlist.name}"?', style: const TextStyle(color: Colors.white70)),
                            actions: [
                              TextButton(onPressed: () => Get.back(result: false), child: const Text('Huỷ')),
                              TextButton(onPressed: () => Get.back(result: true), child: const Text('Xoá')),
                            ],
                          ));
                          if (confirmed == true) {
                            await controller.deletePlaylist(playlist.id);
                            Get.snackbar('Đã xoá', '"${playlist.name}" đã bị xoá',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.black87,
                                colorText: Colors.white);
                          }
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(value: 'edit', child: Text('Sửa')),
                        PopupMenuItem(value: 'delete', child: Text('Xoá')),
                      ],
                    ),
                  ],
                ),
                onTap: () => Get.toNamed('/playlist-details', arguments: playlist),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => _showCreatePlaylistDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descController = TextEditingController();
    final imageUrlController = TextEditingController();
    String imageUrl = '';

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Tạo Playlist', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                imageUrl.isNotEmpty
                    ? Image.network(imageUrl, height: 120, errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported))
                    : Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[800],
                  child: const Icon(Icons.image, color: Colors.white54),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: imageUrlController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Link ảnh', labelStyle: TextStyle(color: Colors.white70)),
                  onChanged: (value) => setState(() => imageUrl = value),
                ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Tên playlist', labelStyle: TextStyle(color: Colors.white70)),
                ),
                TextField(
                  controller: descController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Mô tả', labelStyle: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Huỷ')),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final desc = descController.text.trim();
                final image = imageUrl.trim();

                if (name.isEmpty) {
                  Get.snackbar('Lỗi', 'Tên playlist không được để trống', backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }

                await controller.createPlaylist(name, desc, image);
                Get.back();
                Get.snackbar('Đã tạo playlist', '✔ "$name"', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black87, colorText: Colors.white);
              },
              child: const Text('Tạo'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPlaylistDialog(BuildContext context, Playlist playlist) {
    final nameController = TextEditingController(text: playlist.name);
    final descController = TextEditingController(text: playlist.description);
    final imageUrlController = TextEditingController(text: playlist.picture);
    String imageUrl = playlist.picture;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Sửa Playlist', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                imageUrl.isNotEmpty
                    ? Image.network(imageUrl, height: 120, errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported))
                    : Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[800],
                  child: const Icon(Icons.image, color: Colors.white54),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: imageUrlController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Link ảnh', labelStyle: TextStyle(color: Colors.white70)),
                  onChanged: (value) => setState(() => imageUrl = value),
                ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Tên playlist', labelStyle: TextStyle(color: Colors.white70)),
                ),
                TextField(
                  controller: descController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Mô tả', labelStyle: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('Huỷ')),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final desc = descController.text.trim();
                final image = imageUrl.trim();

                if (name.isEmpty) {
                  Get.snackbar('Lỗi', 'Tên playlist không được để trống', backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }

                await controller.updatePlaylist(
                  id: playlist.id,
                  name: name,
                  description: desc,
                  imageUrl: image,
                );

                Get.back();
                Get.snackbar('Đã cập nhật', '"$name" đã được cập nhật', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.black87, colorText: Colors.white);
              },
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}