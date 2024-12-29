// import 'dart:async';
// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_cli_tutorial/app/data/services/cabindata.dart';
// import 'package:get_cli_tutorial/app/data/services/user_api_services.dart';
// import 'package:get_storage/get_storage.dart';
//
// class HomeController extends GetxController {
//   final ApiService apiService = ApiService();
//   final RxList<CabinData> cabins = RxList<CabinData>();
//   final RxBool isLoading = true.obs;
//   final RxMap<int, String> waitingTimes = <int, String>{}.obs;
//   final RxMap<int, bool> notificationSent = <int, bool>{}.obs;
//   final RxMap<int, DateTime> startTimes = <int, DateTime>{}.obs;
//   final Map<int, Timer> cabinTimers = {};
//   Timer? _timer;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadStoredWaitingTimes(); // Load waiting times at initialization
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//     _startDataFetchTimer(); // Start fetching data periodically
//   }
//
//   void _startDataFetchTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       fetchData(); // Poll the API every 2 seconds
//     });
//   }
//
//   @override
//   void onClose() {
//     _timer?.cancel();
//     cabinTimers.forEach((_, timer) => timer.cancel());
//     saveWaitingTimes(); // Save all waiting times to storage
//     super.onClose();
//   }
//
//   void fetchData() async {
//     try {
//       final response = await apiService.fetchAllCabins();
//       final dataList = response['data'] as List;
//
//       cabins.clear(); // Clear previous cabin data
//
//       final List<Map<String, dynamic>> activeCabinsWithTimes = [];
//
//       for (var data in dataList) {
//         final cabin = CabinData.fromJson(data);
//         if (cabin.msg) {
//           // Add active cabins to the temporary list
//           activeCabinsWithTimes.add({
//             'cabin': cabin,
//             'waitingTime': waitingTimes[cabin.id] ?? '0:00',
//           });
//
//           // Update waiting times
//           waitingTimes[cabin.id] = waitingTimes[cabin.id] ?? '0:00';
//
//           // Trigger notification logic
//           if (notificationSent[cabin.id] != true) {
//             triggerNotification(cabin.id);
//             notificationSent[cabin.id] = true; // Mark notification as sent
//
//             // Only start timer if it hasn't started yet
//             if (!startTimes.containsKey(cabin.id)) {
//               startWaitingTimer(cabin.id); // Start waiting timer
//             }
//           }
//         } else {
//           stopWaitingTimer(cabin.id);
//           notificationSent[cabin.id] =
//               false; // Reset notification state when call is over
//         }
//       }
//
//       // Sorting and updating cabins in UI
//       activeCabinsWithTimes.sort((a, b) {
//         Duration timeA = _convertToDuration(a['waitingTime']);
//         Duration timeB = _convertToDuration(b['waitingTime']);
//         return timeB.compareTo(timeA); // Sort in descending order
//       });
//
//       cabins.clear();
//       for (var entry in activeCabinsWithTimes) {
//         cabins.add(entry['cabin']);
//       }
//
//       isLoading.value = false; // Update loading state
//     } catch (error) {
//       print('Error: $error');
//       isLoading.value = false; // Ensure loading state is updated even on error
//     }
//   }
//
//   void loadStoredWaitingTimes() {
//     final box = GetStorage();
//     final storedKeys = box.getKeys(); // Get all keys
//     print("Stored Keys: $storedKeys"); // Debugging
//
//     for (var key in storedKeys) {
//       if (key.startsWith('waitingTime_')) {
//         int cabinId = int.parse(key.split('_')[1]);
//         String storedTime = box.read(key);
//         print(
//             "Loaded waiting time for cabin $cabinId: $storedTime"); // Debugging
//         waitingTimes[cabinId] = storedTime;
//
//         // Load start time
//         String? storedStartTimeString = box.read('startTime_$cabinId');
//         if (storedStartTimeString != null) {
//           DateTime storedStartTime = DateTime.parse(
//               storedStartTimeString); // Convert string back to DateTime
//           Duration elapsed = DateTime.now()
//               .difference(storedStartTime); // Calculate elapsed time
//
//           // Update waiting time with elapsed time
//           String updatedTime = _addElapsedTime(waitingTimes[cabinId]!, elapsed);
//           waitingTimes[cabinId] = updatedTime;
//           startWaitingTimer(cabinId,
//               resume: true, initialTime: elapsed); // Resume the timer
//         } else {
//           print("No start time found for cabin $cabinId."); // Debugging
//         }
//       }
//     }
//   }
//
//   Duration _convertToDuration(String timeString) {
//     List<String> parts = timeString.split(':');
//     int minutes = int.parse(parts[0]);
//     int seconds = int.parse(parts[1]);
//     return Duration(minutes: minutes, seconds: seconds);
//   }
//
//   String _addElapsedTime(String existingTime, Duration elapsed) {
//     Duration currentDuration = _convertToDuration(existingTime);
//     Duration newDuration = currentDuration + elapsed;
//     return _convertToString(newDuration);
//   }
//
//   void startWaitingTimer(int cabinId,
//       {bool resume = false, Duration? initialTime}) {
//     if (!resume) {
//       startTimes[cabinId] =
//           DateTime.now(); // Set the current time as the start time
//     }
//
//     if (startTimes[cabinId] == null) {
//       print("Error: startTimes[$cabinId] is null.");
//       return; // Early return to avoid further errors
//     }
//
//     final box = GetStorage();
//     box.write('startTime_$cabinId', startTimes[cabinId]!.toIso8601String());
//
//     final elapsed =
//         initialTime ?? DateTime.now().difference(startTimes[cabinId]!);
//     waitingTimes[cabinId] = _convertToString(elapsed);
//     saveWaitingTimes();
//
//     // Start or resume the timer for this cabin
//     cabinTimers[cabinId] = Timer.periodic(const Duration(seconds: 1), (timer) {
//       final currentStartTime = startTimes[cabinId];
//       if (currentStartTime != null) {
//         final elapsed = DateTime.now().difference(currentStartTime);
//         waitingTimes[cabinId] = _convertToString(elapsed);
//         saveWaitingTimes(); // Continuously save waiting times
//       }
//     });
//   }
//
//   String _convertToString(Duration duration) {
//     return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }
//
//   void stopWaitingTimer(int cabinId) {
//     waitingTimes[cabinId] = '0:00'; // Reset waiting time
//
//     if (cabinTimers.containsKey(cabinId)) {
//       cabinTimers[cabinId]!.cancel();
//       cabinTimers.remove(cabinId);
//     }
//
//     startTimes.remove(cabinId); // Remove the start time for the cabin
//     clearWaitingTimeFromStorage(cabinId);
//   }
//
//   void saveWaitingTimes() {
//     final box = GetStorage();
//     waitingTimes.forEach((id, time) {
//       box.write('waitingTime_$id', time);
//     });
//   }
//
//   void clearWaitingTimeFromStorage(int cabinId) {
//     final box = GetStorage();
//     box.remove('waitingTime_$cabinId');
//   }
//
//   void triggerNotification(int cabinId) {
//     NotificationService.showNotification(
//       title: 'Cabin Number $cabinId is Calling',
//       body: 'Cabin $cabinId is  calling',
//       cabinId: cabinId, // Use cabin ID for unique notifications
//       backgroundColor: const Color(0xFF00FF00), // Hex code for bright green
//       icon: 'resource://drawable/notification1',
//       payload: {'navigate': 'true'},
//     );
//   }
// }
//
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
//         id: cabinId, // Use cabin ID for unique notifications
//         title: title,
//         body: body,
//         payload: payload, // Pass the payload for interaction
//         notificationLayout: NotificationLayout.Default, // Default layout
//         color: backgroundColor, // Background color for the notification
//         icon: icon, // Notification icon
//       ),
//     )
//         .catchError((error) {
//       print('Notification Error: $error');
//     });
//   }
// }
///------------------------------------------
///
// import 'dart:async';
// import 'dart:ui';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_cli_tutorial/app/data/services/cabindata.dart';
// import 'package:get_cli_tutorial/app/data/services/user_api_services.dart';

// class HomeController extends GetxController {
//   final ApiService apiService = ApiService();
//   final RxList<CabinData> cabins = RxList<CabinData>();
//   final RxBool isLoading = true.obs;
//   final RxMap<int, String> waitingTimes = <int, String>{}.obs;
//   final RxMap<int, bool> notificationSent = <int, bool>{}.obs;
//   final RxMap<int, DateTime> startTimes = <int, DateTime>{}.obs;
//   final Map<int, Timer> cabinTimers = {};
//   Timer? _timer;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//     _startDataFetchTimer(); // Start fetching data periodically
//   }
//
//   void _startDataFetchTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       fetchData(); // Poll the API every 2 seconds
//     });
//   }
//
//   @override
//   void onClose() {
//     _timer?.cancel();
//     cabinTimers.forEach((_, timer) => timer.cancel());
//
//     super.onClose();
//   }
//
//   void fetchData() async {
//     try {
//       final response = await apiService.fetchAllCabins();
//       final dataList = response['data'] as List;
//
//       cabins.clear(); // Clear previous cabin data
//
//       final List<Map<String, dynamic>> activeCabinsWithTimes = [];
//
//       for (var data in dataList) {
//         final cabin = CabinData.fromJson(data);
//         if (cabin.msg) {
//           // Get the updatedAt time from the API response
//           DateTime updatedAt = DateTime.parse(data['attributes']['updatedAt']);
//           Duration waitingDuration = DateTime.now().difference(updatedAt);
//           String waitingTime = _convertToString(waitingDuration);
//
//           // Add active cabins to the list
//           activeCabinsWithTimes.add({
//             'cabin': cabin,
//             'waitingTime': waitingTime,
//           });
//
//           ///----Trigger notification logic
//           if (notificationSent[cabin.id] != true) {
//             triggerNotification(cabin.id);
//             notificationSent[cabin.id] = true; // Mark notification as sent
//
//             if (!startTimes.containsKey(cabin.id)) {
//               startWaitingTimer(cabin.id); // Start waiting timer
//             }
//           }
//         } else {
//           notificationSent[cabin.id] = false;
//         }
//       }
//
//       ///-- Sorting and updating cabins in UI
//       activeCabinsWithTimes.sort((a, b) {
//         Duration timeA = _convertToDuration(a['waitingTime']);
//         Duration timeB = _convertToDuration(b['waitingTime']);
//         return timeB.compareTo(timeA); // Sort in descending order
//       });
//
//       cabins.clear();
//       for (var entry in activeCabinsWithTimes) {
//         cabins.add(entry['cabin']);
//       }
//
//       isLoading.value = false; // Update loading state
//     } catch (error) {
//       print('Error: $error');
//       isLoading.value = false; // Ensure loading state is updated even on error
//     }
//   }
//
//   Duration _convertToDuration(String timeString) {
//     List<String> parts = timeString.split(':');
//     int minutes = int.parse(parts[0]);
//     int seconds = int.parse(parts[1]);
//     return Duration(minutes: minutes, seconds: seconds);
//   }
//
//   void startWaitingTimer(int cabinId,
//       {bool resume = false, Duration? initialTime}) {
//     if (!resume) {
//       startTimes[cabinId] =
//           DateTime.now(); // Set the current time as the start time
//     }
//
//     if (startTimes[cabinId] == null) {
//       print("Error: startTimes[$cabinId] is null.");
//       return; // Early return to avoid further errors
//     }
//
//     final elapsed =
//         initialTime ?? DateTime.now().difference(startTimes[cabinId]!);
//     waitingTimes[cabinId] = _convertToString(elapsed);
//
//     // Start or resume the timer for this cabin
//     cabinTimers[cabinId] = Timer.periodic(const Duration(seconds: 1), (timer) {
//       final currentStartTime = startTimes[cabinId];
//       if (currentStartTime != null) {
//         final elapsed = DateTime.now().difference(currentStartTime);
//         waitingTimes[cabinId] = _convertToString(elapsed);
//       }
//     });
//   }
//
//   String _convertToString(Duration duration) {
//     return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }
//
//   ///----------notification
//   void triggerNotification(int cabinId) {
//     NotificationService.showNotification(
//       title: 'Cabin Number $cabinId is Calling',
//       body: 'Cabin $cabinId is  calling',
//       cabinId: cabinId, // Use cabin ID for unique notifications
//       backgroundColor: const Color(0xFF00FF00), // Hex code for bright green
//       icon: 'resource://drawable/notification1',
//       payload: {'navigate': 'true'},
//     );
//   }
// }
///------------------------
///

import 'dart:async';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/data/services/cabindata.dart';
import 'package:get_cli_tutorial/app/data/services/user_api_services.dart';

class HomeController extends GetxController {
  final ApiService apiService = ApiService();
  final RxList<CabinData> cabins = RxList<CabinData>();
  final RxBool isLoading = true.obs;
  final RxMap<int, String> waitingTimes = <int, String>{}.obs;
  final RxMap<int, bool> notificationSent = <int, bool>{}.obs;
  final RxMap<int, DateTime> startTimes = <int, DateTime>{}.obs;
  final Map<int, Timer> cabinTimers = {};
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    _startDataFetchTimer(); // Start fetching data periodically
  }

  void _startDataFetchTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      fetchData(); // Poll the API every 2 seconds
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    cabinTimers.forEach((_, timer) => timer.cancel());
    super.onClose();
  }

  void fetchData() async {
    try {
      final response = await apiService.fetchAllCabins();
      final dataList = response['data'] as List;

      cabins.clear(); // Clear previous cabin data

      final List<Map<String, dynamic>> activeCabinsWithTimes = [];

      for (var data in dataList) {
        final cabin = CabinData.fromJson(data);

        if (cabin.msg) {
          // If the cabin message is true, calculate the waiting time
          DateTime updatedAt = DateTime.parse(data['attributes']['updatedAt']);
          Duration waitingDuration = DateTime.now().difference(updatedAt);
          String waitingTime = _convertToString(waitingDuration);

          // Add active cabins to the list
          activeCabinsWithTimes.add({
            'cabin': cabin,
            'waitingTime': waitingTime,
          });

          ///-------Trigger notification logic
          if (notificationSent[cabin.id] != true) {
            triggerNotification(cabin.id);
            notificationSent[cabin.id] = true; // Mark notification as sent

            if (!startTimes.containsKey(cabin.id)) {
              // Pass the waitingDuration to start the timer with this time
              startWaitingTimer(cabin.id, initialTime: waitingDuration);
            }
          }
        } else if (!cabin.msg) {
          // If the cabin message is false, reset the waiting time to 0:00
          waitingTimes[cabin.id] = "0:00";
          notificationSent[cabin.id] = false; // Reset notification sent status

          // Cancel any existing timers for this cabin
          if (cabinTimers.containsKey(cabin.id)) {
            cabinTimers[cabin.id]?.cancel();
            cabinTimers.remove(cabin.id);
          }

          // Remove the cabin from the active list
          startTimes.remove(cabin.id);
        }
      }

      ///-------- Sorting and updating cabins in UI
      activeCabinsWithTimes.sort((a, b) {
        Duration timeA = _convertToDuration(a['waitingTime']);
        Duration timeB = _convertToDuration(b['waitingTime']);
        return timeB.compareTo(timeA); // Sort in descending order
      });

      cabins.clear();
      for (var entry in activeCabinsWithTimes) {
        cabins.add(entry['cabin']);
      }

      isLoading.value = false; // Update loading state
    } catch (error) {
      print('Error: $error');
      isLoading.value = false; // Ensure loading state is updated even on error
    }
  }

  void startWaitingTimer(int cabinId,
      {bool resume = false, Duration? initialTime}) {
    if (!resume && initialTime != null) {
      // If we're not resuming and there's an initial time, set the start time
      startTimes[cabinId] =
          DateTime.now().subtract(initialTime); // Start from the past
    } else {
      // If we are resuming, just update start time to now
      startTimes[cabinId] = DateTime.now();
    }

    if (startTimes[cabinId] == null) {
      print("Error: startTimes[$cabinId] is null.");
      return; // Early return to avoid further errors
    }

    // Calculate the elapsed time (waiting time already passed)
    final elapsed = DateTime.now().difference(startTimes[cabinId]!);
    waitingTimes[cabinId] = _convertToString(elapsed);

    // Start or resume the timer for this cabin
    cabinTimers[cabinId] = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentStartTime = startTimes[cabinId];
      if (currentStartTime != null) {
        final elapsed = DateTime.now().difference(currentStartTime);
        waitingTimes[cabinId] = _convertToString(elapsed);
      }
    });
  }

  String _convertToString(Duration duration) {
    // Convert the waiting time into a readable format (MM:SS)
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration _convertToDuration(String timeString) {
    List<String> parts = timeString.split(':');
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);
    return Duration(minutes: minutes, seconds: seconds);
  }

  ///----------notification
  void triggerNotification(int cabinId) {
    NotificationService.showNotification(
      title: 'Cabin Number $cabinId is Calling',
      body: 'Cabin $cabinId is calling',
      cabinId: cabinId, // Use cabin ID for unique notifications
      backgroundColor: const Color(0xFF00FF00), // Hex code for bright green
      icon: 'resource://drawable/notification1',
      payload: {'navigate': 'true'},
    );
  }
}

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
        id: cabinId, // Use cabin ID for unique notifications
        title: title,
        body: body,
        payload: payload, // Pass the payload for interaction
        notificationLayout: NotificationLayout.Default, // Default layout
        color: backgroundColor, // Background color for the notification
        icon: icon, // Notification icon
        customSound: 'resource://raw/notification',
      ),
    )
        .catchError((error) {
      print('Notification Error: $error');
    });
  }
}