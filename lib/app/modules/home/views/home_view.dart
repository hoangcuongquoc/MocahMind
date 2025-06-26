import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochamind/app/models/songs_models.dart';
import '../../../widgets/audio_controller.dart';
import '../../layout/controllers/layout_controller.dart';
import '../../layout/views/layout_view.dart';
import '../controllers/home_controller.dart';
import '../../playlist/controllers/playlist_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Music',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchSongs,
        child: Obx(() {
          final List<SongsModel> songs = controller.songs;

          if (songs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _FeaturedSongCard(song: songs.first),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    'Popular Songs',
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return _SongTile(
                    song: song,
                    index: index,
                    onTap: () {
                      controller.currentSongIndex.value = index;
                      final layout = Get.find<LayoutController>();
                      layout.songs.assignAll(controller.songs);
                      layout.playSong(index);
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemCount: songs.length,
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ✅ Featured song card widget
class _FeaturedSongCard extends StatelessWidget {
  const _FeaturedSongCard({required this.song});

  final SongsModel song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: song.image_url.isNotEmpty
                  ? Image.network(song.image_url, fit: BoxFit.cover)
                  : Container(color: Colors.white),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    song.performer,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ SongTile widget inline
class _SongTile extends StatelessWidget {
  const _SongTile({
    required this.song,
    required this.index,
    required this.onTap,
  });

  final SongsModel song;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: song.image_url.isNotEmpty
            ? Image.network(song.image_url, width: 48, height: 48, fit: BoxFit.cover)
            : Container(width: 48, height: 48, color: Colors.grey[300]),
      ),
      title: Text(song.title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(song.performer, style: const TextStyle(color: Colors.white54)),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white70),
        onPressed: () => _showAddToPlaylistSheet(context, song),
      ),
      onTap: onTap,
    );
  }

  void _showAddToPlaylistSheet(BuildContext context, SongsModel song) async {
    final playlistCtrl = Get.isRegistered<PlaylistController>()
        ? Get.find<PlaylistController>()
        : Get.put(PlaylistController());

    await playlistCtrl.fetchPlaylists();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF202020),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('➕ Thêm vào Playlist',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Divider(height: 1),
              Expanded(
                child: Obx(() {
                  final lists = playlistCtrl.playlists;

                  if (lists.isEmpty) {
                    return const Center(
                      child: Text('Bạn chưa có playlist nào',
                          style: TextStyle(color: Colors.white54)),
                    );
                  }

                  return ListView.builder(
                    itemCount: lists.length,
                    itemBuilder: (_, i) {
                      final p = lists[i];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            p.picture,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 48,
                              height: 48,
                              color: Colors.grey[700],
                              child: const Icon(Icons.queue_music, color: Colors.white54),
                            ),
                          ),
                        ),
                        title: Text(p.name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          p.description,
                          style: const TextStyle(color: Colors.white60, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () async {
                          Navigator.pop(context);
                          await playlistCtrl.addSongToPlaylist(p.id, song.id);
                          Get.snackbar('Đã thêm', 'Đã thêm bài hát vào "${p.name}"',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.grey[900],
                              colorText: Colors.white);
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
