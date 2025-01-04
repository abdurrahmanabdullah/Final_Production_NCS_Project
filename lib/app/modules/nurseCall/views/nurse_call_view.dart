import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/nurse_call_controller.dart';

class NurseCallView extends GetView<NurseCallController> {

  const NurseCallView({super.key});
  @override
  Widget build(BuildContext context) {
    final NurseCallController nurseController = Get.find<NurseCallController>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white, // Set the background color to black
            toolbarHeight: 150,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cmh.png',
                  height: 148,

                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill, // Maintain aspect ratio
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Obx(() {
              // Dynamically build a list of Text widgets for all remote_ids
              return ListView.builder(
                itemCount: nurseController.remoteIds.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Remote ID: ${nurseController.remoteIds[index]}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}