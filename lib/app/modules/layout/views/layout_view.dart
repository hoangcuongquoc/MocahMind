import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochamind/app/modules/searching/views/searching_view.dart';
import '../../category/views/category_view.dart';
import '../../home/views/home_view.dart';
import '../../playlist/views/playlist_view.dart';

import '../../profile/views/profile_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
        children: [
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
            // Music Player Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              color: Colors.grey[800],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8.0),
                  Image.asset('assets/song/Mysky.jpg', width: 50, height: 50),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Lose Control', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('Teddy Swims', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _buildControlIcon(Icons.skip_previous, () => controller.skipPrevious()),
                      const SizedBox(width: 16.0),
                      _buildPlayPauseIcon(),
                      const SizedBox(width: 16.0),
                      _buildControlIcon(Icons.skip_next, () => controller.skipNext()),
                    ],
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
            ),
            // Bottom Navigation Bar
            BottomNavigationBar(
              backgroundColor: Colors.grey[900],
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(color: Colors.white70),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: Colors.white),
                  activeIcon: Icon(Icons.home_filled, color: Colors.white),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined, color: Colors.white),
                  activeIcon: Icon(Icons.search_outlined, color: Colors.white),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined, color: Colors.white),
                  activeIcon: Icon(Icons.category_rounded, color: Colors.white),
                  label: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border, color: Colors.white70),
                  activeIcon: Icon(Icons.favorite, color: Colors.white),
                  label: 'Playlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined, color: Colors.white70),
                  activeIcon: Icon(Icons.account_circle, color: Colors.white),
                  label: 'Profile',
                ),
              ],
              currentIndex: controller.currentIndex.value,
              onTap: controller.onTabTapped,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildControlIcon(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white70),
        ),
      ),
    );
  }

  // Build play/pause icon with state management
  Widget _buildPlayPauseIcon() {
    return Obx(
          () => MouseRegion(
        onEnter: (_) => controller.onHover(true),
        onExit: (_) => controller.onHover(false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: controller.togglePlay,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: controller.isHovered.value ? Colors.grey[700] : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
              color: Colors.white70,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}

// Update LayoutController
class LayoutController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxBool isPlaying = false.obs;
  final RxBool isHovered = false.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: Navigator.of(Get.context!) as TickerProvider);
  }

  void onTabTapped(int index) {
    currentIndex.value = index;
    tabController.animateTo(index);
  }

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
    // Add audio play/pause logic here (e.g., using just_audio package)
  }

  void skipPrevious() {
    // Add logic to skip to previous song
    print('Skipped to previous song');
  }

  void skipNext() {
    // Add logic to skip to next song
    print('Skipped to next song');
  }

  void onHover(bool isHovering) {
    isHovered.value = isHovering;
  }
}