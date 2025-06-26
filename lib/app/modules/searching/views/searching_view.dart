import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochamind/app/modules/searching/controllers/searching_controller.dart';



class SearchingView extends GetView<SearchingController> {
  const SearchingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search Song', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.searchSongs,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter song name...',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final results = controller.results;
              if (results.isEmpty) {
                return const Center(
                  child: Text('No result found', style: TextStyle(color: Colors.white54)),
                );
              }

              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (_, i) {
                  final song = results[i];
                  return ListTile(
                    leading: Image.network(song.image_url, width: 48, height: 48, fit: BoxFit.cover),
                    title: Text(song.title, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(song.performer, style: const TextStyle(color: Colors.white70)),
                    onTap: () {
                      // Xử lý phát nhạc
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
