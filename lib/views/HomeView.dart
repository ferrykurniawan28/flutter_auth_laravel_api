import 'package:flutter/material.dart';
import 'package:flutter_laravel_api/controllers/HomeController.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              homeController.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(
        () => homeController.isloading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : homeController.body(),
      ),
    );
  }
}
