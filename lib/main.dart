import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://gtoiwalwudfwpccnqfvm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd0b2l3YWx3dWRmd3BjY25xZnZtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgwNzY3OTIsImV4cCI6MjA2MzY1Mjc5Mn0.5_TyPAEKPA7AUBNJpySztq5ZZDzq9J1995ffOfL8Kss',
  );
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