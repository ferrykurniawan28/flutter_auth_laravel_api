import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_laravel_api/controllers/APIController.dart';
import 'package:flutter_laravel_api/views/HomeView.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _apiController = Get.put(APIController());
  RxBool isLogin = true.obs;

  void register() async {
    final data = {
      'email': emailController.text,
      'name': nameController.text,
      'password': passwordController.text,
    };
    final result =
        await _apiController.postRequest(route: '/register', data: data);
    // print(jsonDecode(result.body));
    final response = jsonDecode(result.body);
    print(response);
    if (response['status'] == 200) {
      Get.snackbar(
        'Success',
        'User registered successfully',
        // snackPosition: SnackPosition.BOTTOM,
      );
      // Get.toEnd(() => const HomeView());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('token', response['token']);
      Get.offAll(() => const HomeView());
    } else {
      Get.snackbar(
        'Error',
        response['message'],
        // snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget registerWidget() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                register();
              },
              child: const Text('Register'),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: TextButton(
            onPressed: () {
              isLogin.value = true;
            },
            child: const Text('Login'),
          ),
        ),
      ],
    );
  }

  void login() async {
    final data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    final result =
        await _apiController.postRequest(route: '/login', data: data);
    final response = jsonDecode(result.body);
    print(response);
    if (response['status'] == 200) {
      Get.snackbar(
        'Success',
        'User logged in successfully',
        // snackPosition: SnackPosition.BOTTOM,
      );
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('token', response['token']);
      Get.offAll(() => const HomeView());
    } else {
      Get.snackbar(
        'Error',
        response['message'],
        // snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget loginWidget() {
    return Stack(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: const Text('Login'),
          ),
        ],
      ),
      Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: TextButton(
          onPressed: () {
            isLogin.value = false;
          },
          child: const Text('Register'),
        ),
      ),
    ]);
  }
}
