
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/modules/home/controllers/SIgnInViewController.dart';

import 'package:get_cli_tutorial/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

import 'landingpageView.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // Local variables to store the username and password
  String username = '';
  String password = '';

  // List of credentials for different nurses
  final List<Map<String, String>> nurseCredentials = [
    {"username": "nurse1", "password": "1"},
    {"username": "nurse2", "password": "2"},
    {"username": "nurse3", "password": "3"},
    {"username": "nurse4", "password": "4"},
    {"username": "nurse5", "password": "5"},
    {"username": "nurse6", "password": "6"},
    {"username": "nurse7", "password": "7"},
    {"username": "nurse8", "password": "8"},
    {"username": "nurse9", "password": "9"},
    {"username": "nurse10", "password": "10"},
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignInViewController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Nurse Login Panel')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Username TextField
              TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 15,
              ),
              // Password TextField
              TextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
              const SizedBox(
                height: 25,
              ),
              // Login Button
              ElevatedButton(
                onPressed: () async {
                  // Check if the entered username and password match any in the list
                  bool isValid = false;
                  String loggedInUser = '';

                  for (var credential in nurseCredentials) {
                    if (credential['username'] == username && credential['password'] == password) {
                      isValid = true;
                      loggedInUser = credential['username']!;
                      controller.setUsername(username);

                      break;
                    }
                  }

                  if (isValid) {
                    // Save the username in GetStorage
                    final box = GetStorage();
                    await box.erase();
                    await box.write('username', loggedInUser );
                    print('Saved nurse name: $loggedInUser ');

                    // Read the username using the same key
                    // String? nurseName = box.read('username'); // Change 'nurseName' to 'username'
                    // print("Get data: $nurseName");

                    // If credentials match, navigate to the LandingPage and track the user
                    Get.offNamed(Routes.LandingPage);
                    print("Logged in as $loggedInUser ");



                    // Pass the username explicitly as an argument



                    // // Track the username and pass it to the PdfPage
                    // Future.delayed(const Duration(seconds: 2), () {
                    //   Get.toNamed('/pdfview', arguments: {'username': loggedInUser});
                    //
                    // });

                  } else {
                    // If credentials don't match, show an error message
                    Get.snackbar(
                      'Login Failed',
                      'Username or Password is incorrect',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
