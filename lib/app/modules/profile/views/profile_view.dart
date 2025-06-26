import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mochamind Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple.shade100,
                child: const Icon(Icons.person, size: 48, color: Colors.purple),
              ),
              const SizedBox(height: 16),
              const Text(
                "Good Bye, Mochaminder!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "You’re logged in to Mochamind",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                onPressed: controller.signOut,
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
