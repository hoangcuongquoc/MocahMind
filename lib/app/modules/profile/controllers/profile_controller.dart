import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  Future<void> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();

      Get.snackbar(
        "Sign Out",
        "You have successfully signed out",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        "Error",
        "Sign out failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
