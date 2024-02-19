import 'package:flutter/material.dart';
import 'package:flutter_laravel_api/views/AuthView.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  late SharedPreferences preferences;
  RxBool isloading = false.obs;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  void getUserData() async {
    isloading.value = true;
    preferences = await SharedPreferences.getInstance();
    isloading.value = false;
    print("token: ${preferences.getString('token')}");
  }

  void logout() async {
    preferences = await SharedPreferences.getInstance();
    // preferences.remove('token');
    // Get.offAll('/auth');
    preferences.clear();
    Get.offAll(() => const AuthView());
  }

  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Loged in successfully'),
          Text(preferences.getInt('user_id').toString()),
          Text(preferences.getString('name').toString()),
          Text(preferences.getString('email').toString()),
          Text(preferences.getString('token').toString()),
        ],
      ),
    );
  }
}
