// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'app/routes/app_pages.dart';
//
// void main() {
//   AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//             channelKey: 'basic_chanel',
//             channelName: 'Basic notification',
//             channelDescription: "Notification for basic test ")
//       ],
//       debug: true);
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Application",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//     ),
//   );
// }
///--------------------------------
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await GetStorage.init(); // Initialize GetStorage
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'custom_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
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
