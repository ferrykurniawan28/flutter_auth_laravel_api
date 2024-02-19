import 'package:flutter/material.dart';
import 'package:flutter_laravel_api/views/AuthView.dart';
import 'package:flutter_laravel_api/views/HomeView.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final token = snapshot.data!.getString('token');
              if (token != null) {
                // return const AuthView();
                return const HomeView();
              } else {
                return const AuthView();
              }
            } else {
              return const AuthView();
            }
          }),
    );
  }
}
