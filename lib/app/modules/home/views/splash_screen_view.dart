import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class SplashScreenView extends GetView<HomeController> {
  // Use GetView<HomeController> to bind the controller
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Start navigation logic here
    _startSplashScreenTimer();

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Image.asset(
            'assets/images/ss.gif', // Ensure the path is correct
            fit: BoxFit.cover, // Scale the image to cover the entire screen
          ),
        ),
      ),
    );
  }

  // Method to handle the navigation logic
  void _startSplashScreenTimer() {
    Future.delayed(const Duration(seconds: 6), () {
      Get.offAllNamed(Routes.HOME); // Navigate to HomeView after 6 seconds
    });
  }
}
