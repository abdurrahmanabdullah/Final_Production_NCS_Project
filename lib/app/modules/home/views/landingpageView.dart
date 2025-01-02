import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/modules/home/controllers/landingpageController.dart';

import 'package:get_storage/get_storage.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {


    // Ensure the controller is initialized using Get.put()
    Get.put(LandingPageController());
    final LandingPageController landingPageController = Get.find();
    // List of dropdown options
    List<String> options = ['ns1', 'ns2', 'ns3'];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 150,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cmh.png',
                  height: 148,
                  width: MediaQuery.of(context).size.width * 0.99,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(76.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Aligns children to the start horizontally
                children: [
                  // Move the text to the top of the page
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0), // Optional: Adds space below the text
                    child: Text(
                      "Please Select Station",
                      softWrap: false,
                      style: TextStyle(fontSize: 18), // Optional: Adjust font size or style
                    ),
                  ),
                  // Reactive Dropdown button
                  Obx(() {
                    return DropdownButton<String>(
                      value: landingPageController.selectedOption.value, // Use the reactive value
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                      ),
                      dropdownColor: Colors.white,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          landingPageController.onOptionSelected(newValue);
                          print('Selected Nurse Station: $newValue'); // Update via controller
                        }
                      },
                      items: options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(height: 170),
                  // Display selected option for testing purposes
                  Obx(() {
                    return Text(
                      'Selected  Station  : ${landingPageController.selectedOption.value}',
                      style: const TextStyle(color: Colors.blueGrey, fontSize: 18),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



