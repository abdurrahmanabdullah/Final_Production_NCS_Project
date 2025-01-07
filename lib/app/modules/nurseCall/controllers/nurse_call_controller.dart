// import 'dart:async';
// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_cli_tutorial/app/data/services/nurseCallApiCall.dart';
// import 'package:get_cli_tutorial/app/data/services/nurseCallModel.dart';
//
// class NurseCallController extends GetxController {
//   final ApiService apiservice = ApiService();
//
//   // Define reactive lists for remoteIds and createdAt
//   var name = <String?>[].obs;
//   var remoteIds = <int?>[].obs;
//   var createdAt = <String>[].obs; // List to hold formatted createdAt times
//   final Set<int> _notifiedCabins = {}; // Track notified cabins
//   Timer? _timer;
//   Timer? _periodicTimer;
//   final Map<int, Timer> _timers = {}; // Individual timers for each cabin
//   @override
//   void onInit() {
//     fetchNurseCall();
//     startPeriodicFetch(); // Start periodic API calls
//     super.onInit();
//   }
//
//   Future<void> fetchNurseCall() async {
//     try {
//       // Fetch the list of NurseCallingModel objects
//       List<NurseCallingModel> cabins = await apiservice.fetchAllCabins();
//
//       /// Filter the cabins to include only those with "active" status
//       List<NurseCallingModel> activeCabins =
//           cabins.where((cabin) => cabin.status == "active").toList();
//
//
//       /// name filter
//       name.value = activeCabins
//           .map((cabin) => cabin.name) // Directly map to name (string)
//           .toList();
//
//
//       /// remote id
//       remoteIds.value = activeCabins
//           .map((cabin) =>
//               int.tryParse(cabin.remoteId ?? '') ??
//               null) // Convert String to int?
//           .toList();
//
//       ///-----time
//       createdAt.value = activeCabins
//           .map((cabin) => cabin.createdAt != null
//               ? '${DateTime.parse(cabin.createdAt.toString()).hour}:${DateTime.parse(cabin.createdAt.toString()).minute}:${DateTime.parse(cabin.createdAt.toString()).second}'
//               : '')
//           .toList();
//
//       ///------- trigger notification
//
//       for (var cabin in activeCabins) {
//         int? cabinId = int.tryParse(cabin.remoteId ?? '');
//         if (cabinId != null && !_notifiedCabins.contains(cabinId)) {
//           triggerNotification(cabinId); // Send notification
//           _notifiedCabins.add(cabinId); // Mark cabin as notified
//         }
//       }
//       // Print the lists for debugging
//       print('Remote IDs: $remoteIds');
//       print('Created At: $createdAt');
//     } catch (e) {
//       // Handle error
//       print('Error fetching cabins: $e');
//     }
//   }
//
//   void startPeriodicFetch() {
//     _timer = Timer.periodic(Duration(seconds: 2), (timer) {
//       fetchNurseCall();
//     });
//   }
//
//   ///---triger notification
//   ///----------notification function
//   void triggerNotification(int cabinId) {
//     NotificationService.showNotification(
//       title: 'Cabin Number $cabinId is Calling',
//       body: 'Cabin $cabinId is calling',
//       cabinId: cabinId,
//       // Use cabin ID for unique notifications
//       backgroundColor: const Color(0xFF00FF00),
//       // Hex code for bright green
//       icon: 'resource://drawable/notification1',
//       payload: {'navigate': 'true'},
//     );
//   }
// }
//
// ///--------notification
// class NotificationService {
//   static void showNotification({
//     required String title,
//     required String body,
//     required int cabinId, // Added cabinId parameter
//     required Color backgroundColor, // Background color parameter
//     required String icon, // Notification icon parameter
//     Map<String, String>? payload, // Optional payload
//   }) {
//     AwesomeNotifications()
//         .createNotification(
//       content: NotificationContent(
//         channelKey: 'custom_channel',
//         id: cabinId,
//         // Use cabin ID for unique notifications
//         title: title,
//         body: body,
//         payload: payload,
//         // Pass the payload for interaction
//         notificationLayout: NotificationLayout.Default,
//         // Default layout
//         color: backgroundColor,
//         // Background color for the notification
//         icon: icon,
//         // Notification icon
//         customSound: 'resource://raw/notification',
//       ),
//     )
//         .catchError((error) {
//       print('Notification Error: $error');
//     });
//   }
//
//   ///-----------------------
// }
///------------------------
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get_cli_tutorial/app/data/services/nurseCallApiCall.dart';
import 'package:get_cli_tutorial/app/data/services/nurseCallModel.dart';
 // Replace with your actual API service import

class NurseCallController extends GetxController {
  final ApiService apiservice = ApiService();

  // Define reactive lists for remoteIds and createdAt
  var name = <String?>[].obs;
  var remoteIds = <int?>[].obs;
  var createdAt = <String>[].obs; // List to hold formatted createdAt times
  final Set<int> _notifiedCabins = {}; // Track notified cabins
  Timer? _timer;
  Timer? _periodicTimer;
  final Map<int, Timer> _timers = {}; // Individual timers for each cabin

  @override
  void onInit() {
    fetchNurseCall();
    startPeriodicFetch(); // Start periodic API calls
    super.onInit();
  }

  Future<void> fetchNurseCall() async {
    try {
      // Fetch the list of NurseCallingModel objects
      List<NurseCallingModel> cabins = await apiservice.fetchAllCabins();

      /// Filter the cabins to include only those with "active" status
      List<NurseCallingModel> activeCabins =
      cabins.where((cabin) => cabin.status == "active").toList();

      /// name filter
      name.value = activeCabins
          .map((cabin) => cabin.name) // Directly map to name (string)
          .toList();

      /// remote id
      remoteIds.value = activeCabins
          .map((cabin) =>
      int.tryParse(cabin.remoteId ?? '') ?? null) // Convert String to int?
          .toList();

      ///-----time
      createdAt.value = activeCabins
          .map((cabin) => cabin.createdAt != null
          ? '${DateTime.parse(cabin.createdAt.toString()).hour}:${DateTime.parse(cabin.createdAt.toString()).minute}:${DateTime.parse(cabin.createdAt.toString()).second}'
          : '')
          .toList();

      /// Remove cabins that are no longer active from the notified set
      _notifiedCabins.removeWhere((cabinId) => !activeCabins
          .any((cabin) => int.tryParse(cabin.remoteId ?? '') == cabinId));

      ///------- trigger notification
      for (var cabin in activeCabins) {
        int? cabinId = int.tryParse(cabin.remoteId ?? '');
        if (cabinId != null && !_notifiedCabins.contains(cabinId)) {
          triggerNotification(cabinId); // Send notification
          _notifiedCabins.add(cabinId); // Mark cabin as notified
        }
      }

      // Print the lists for debugging
      print('Remote IDs: $remoteIds');
      print('Created At: $createdAt');
    } catch (e) {
      // Handle error
      print('Error fetching cabins: $e');
    }
  }

  void startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchNurseCall();
    });
  }

  ///--- trigger notification
  void triggerNotification(int cabinId) {
    NotificationService.showNotification(
      title: 'Cabin Number $cabinId is Calling',
      body: 'Cabin $cabinId is calling',
      cabinId: cabinId,
      // Use cabin ID for unique notifications
      backgroundColor: const Color(0xFF00FF00),
      // Hex code for bright green
      icon: 'resource://drawable/notification1',
      payload: {'navigate': 'true'},
    );
  }
}

///--------notification
class NotificationService {
  static void showNotification({
    required String title,
    required String body,
    required int cabinId, // Added cabinId parameter
    required Color backgroundColor, // Background color parameter
    required String icon, // Notification icon parameter
    Map<String, String>? payload, // Optional payload
  }) {
    AwesomeNotifications()
        .createNotification(
      content: NotificationContent(
        channelKey: 'custom_channel',
        id: cabinId,
        // Use cabin ID for unique notifications
        title: title,
        body: body,
        payload: payload,
        // Pass the payload for interaction
        notificationLayout: NotificationLayout.Default,
        // Default layout
        color: backgroundColor,
        // Background color for the notification
        icon: icon,
        // Notification icon
        customSound: 'resource://raw/notification',
      ),
    )
        .catchError((error) {
      print('Notification Error: $error');
    });
  }

///-----------------------
}