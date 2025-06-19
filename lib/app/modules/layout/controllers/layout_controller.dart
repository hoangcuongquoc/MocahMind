import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutController extends GetxController with GetSingleTickerProviderStateMixin{
  //TODO: Implement LayoutController
  late TabController tabController;
  var currentIndex = 0.obs;

  final RxBool isPlaying = false.obs;
  final RxBool isHovered = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      currentIndex.value = tabController.index;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void onTabTapped(int index) {
    currentIndex.value = index;
    tabController.animateTo(index);
  }



  void togglePlay() {
    isPlaying.value = !isPlaying.value;
  }

  void skipPrevious() {
    print('Skipped to previous song');
  }

  void skipNext() {
    print('Skipped to next song');
  }

  void onHover(bool isHovering) {
    isHovered.value = isHovering;
  }

}
