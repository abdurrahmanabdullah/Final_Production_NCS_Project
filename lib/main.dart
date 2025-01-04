
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/modules/home/controllers/SIgnInViewController.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/nurseCall/bindings/nurse_call_binding.dart';
import 'app/modules/nurseCall/controllers/nurse_call_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init(); // Initialize GetStorage

   Get.put(NurseCallController());
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'custom_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
        )
      ],
      debug: true);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,

    ),
  );
}
