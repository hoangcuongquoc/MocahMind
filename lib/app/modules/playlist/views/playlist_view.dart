import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/playlist_controller.dart';

class PlaylistView extends GetView<PlaylistController> {
  const PlaylistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlaylistView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PlaylistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
