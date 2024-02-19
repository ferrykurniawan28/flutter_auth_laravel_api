import 'package:flutter/material.dart';
import 'package:flutter_laravel_api/controllers/AuthController.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      body: Center(
        child: Obx(
          () => authController.isLogin.value
              ? authController.loginWidget()
              : authController.registerWidget(),
        ),
      ),
    );
  }
}
