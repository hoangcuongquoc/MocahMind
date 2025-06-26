import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mochamind/app/modules/home/controllers/home_controller.dart';
import 'package:mochamind/app/modules/searching/controllers/searching_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/modules/category/controllers/category_controller.dart';
import 'app/modules/layout/controllers/layout_controller.dart';
import 'app/modules/playlist/controllers/playlist_controller.dart';
import 'app/modules/profile/controllers/profile_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/audio_controller.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://gtoiwalwudfwpccnqfvm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd0b2l3YWx3dWRmd3BjY25xZnZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgwNzY3OTIsImV4cCI6MjA2MzY1Mjc5Mn0.5_TyPAEKPA7AUBNJpySztq5ZZDzq9J1995ffOfL8Kss',
  );
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);



  Get.put(ProfileController()); // hoặc Get.lazyPut(() => ProfileController());
  Get.put(HomeController());
  // Get.put(AudioController());
  Get.put(CategoryController());

  Get.put(SearchingController());

  Get.put(PlaylistController());
  runApp(Myapp());
}



class Myapp extends StatelessWidget{
  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}