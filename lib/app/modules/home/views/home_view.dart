import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochamind/app/models/songs_models.dart';
import '../controllers/home_controller.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Music'),
        elevation: 0,
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
              SliverToBoxAdapter(
                child: _SectionHeader(
                  title: 'Popular Songs',
                  onShowAll: () {},
                ),
              ),
              SliverList.separated(
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return _SongTile(
                    song: song,
                    index: index,
                    onTap: () {
                      // TODO: Play song logic
                      controller.currentSongIndex.value = index;
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
                  : Container(color: Colors.grey[300]),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white70),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onShowAll});

  final String title;
  final VoidCallback? onShowAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_outward, size: 16),
          const Spacer(),
          TextButton(
            onPressed: onShowAll,
            child: const Text('Show all'),
          ),
        ],
      ),
    );
  }
}

class _SongTile extends StatelessWidget {
  const _SongTile({required this.song, required this.index, required this.onTap});

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
      title: Text(song.title),
      subtitle: Text(song.performer),
      trailing: const Icon(Icons.more_vert),
      onTap: onTap,
    );
  }
}
