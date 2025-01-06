import 'package:get/get.dart';

class SignInViewController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var selectedUsername = ''.obs;
  void setUsername(String username) {
    selectedUsername.value = username;
  }
  // A function to handle the login logic
  void login() {
    if (username.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Please fill in both fields');
      return;
    }

    isLoading.value = true;

    // Simulate a network request
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      // Here you can add your login logic, for example, checking credentials
      if (username.value == 'nurse' && password.value == 'password') {
        Get.snackbar('Success', 'Login successful');
        // Navigate to the next screen or perform any action
      } else {
        Get.snackbar('Error', 'Invalid username or password');
      }
    });
  }
}
