import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../service/auth_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {




  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Login to Mochamind'),
      centerTitle: true),
      body:  Center(
        child: FilledButton(
            onPressed: controller.nativeGoogleSignIn  ,
            child: Text('Login With Google')),
      )
    );
  }
}
