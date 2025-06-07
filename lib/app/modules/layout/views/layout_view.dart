import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mochamind/app/modules/searching/views/searching_view.dart';

import '../../category/views/category_view.dart';
import '../../home/views/home_view.dart';
import '../../playlist/views/playlist_view.dart';
import '../controllers/layout_controller.dart';

class LayoutView extends GetView<LayoutController> {
  const LayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller.tabController,
          children:[
            HomeView(),
            SearchingView(),
            CategoryView(),
            PlaylistView(),

          ] ),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(color: Colors.white70),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,

          items: const[
              BottomNavigationBarItem(

                  icon: Icon(Icons.home_outlined, color: Colors.white),
                activeIcon: Icon(Icons.home_filled, color: Colors.white),
                label: 'Home',
                // activeIcon: ColorFiltered(colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop))

              ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined,color: Colors.white),
              activeIcon: Icon(Icons.search_outlined, color: Colors.white),
                label: 'Search',
                // activeIcon: ColorFiltered(colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined,color: Colors.white),
              activeIcon: Icon(Icons.category_rounded, color: Colors.white),
                label: 'Category',
                // activeIcon: ColorFiltered(colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcATop))
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, color: Colors.white70), // Heart icon
              activeIcon: Icon(Icons.favorite, color: Colors.white),
              label: 'Playlist',
            ),

          ],
        currentIndex: controller.currentIndex.value,
        onTap: controller.onTabTapped,
      )
      ),
    );
  }
}
