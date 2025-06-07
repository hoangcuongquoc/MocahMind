import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/searching_controller.dart';

class SearchingView extends GetView<SearchingController> {
  const SearchingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SearchingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
