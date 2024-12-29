//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_cli_tutorial/app/modules/home/controllers/home_controller.dart';
//
// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.find<HomeController>();
//
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.black, // Set the background color to black
//             toolbarHeight: 150,
//             flexibleSpace: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/cmh.png',
//                   height: 148,
//                   width: MediaQuery.of(context).size.width * 0.99,
//                   fit:
//                       BoxFit.fill, // Choose fit option to maintain aspect ratio
//                 ),
//               ],
//             ),
//           ),
//           body: SafeArea(
//             child: Container(
//               color: const Color(0xFF010101),
//               child: Obx(() {
//                 if (controller.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (controller.cabins.isEmpty) {
//                   return const Center(
//                     child: Text("Waiting for patient to call."),
//                   );
//                 } else {
//                   return ListView.builder(
//                     itemCount: controller.cabins.length,
//                     itemBuilder: (context, index) {
//                       final cabin = controller.cabins[index];
//                       final waitingTime =
//                           controller.waitingTimes[cabin.id] ?? '0:00';
//                       // Parse the waiting time to calculate minutes
//                       final timeParts = waitingTime.split(':');
//                       final minutes = int.parse(timeParts[0]);
//                       final isExceedingLimit = minutes >
//                           4; // Check if waiting time exceeds 5 minutes
//
//                       return Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(top: 12.0),
//                             decoration: BoxDecoration(
//                               color: isExceedingLimit
//                                   ? Colors.red
//                                   : const Color(0xFF171717),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10)),
//                             ),
//                             child: ListTile(
//                               title: Center(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Image.asset(
//                                       'assets/images/h1.png',
//                                       height: 40,
//                                       width: 54,
//                                     ),
//                                     Text(
//                                       'Cabin ${cabin.id}',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     Obx(() {
//                                       // print(
//                                       //     'Waiting time for cabin ${cabin.id}: ${controller.waitingTimes[cabin.id]}');
//
//                                       final waitingTime =
//                                           controller.waitingTimes[cabin.id];
//
//                                       // return Text(
//                                       //   'Waiting: ${waitingTime != null ? waitingTime : 'Calculating...'}',
//                                       //   style: const TextStyle(
//                                       //     color: Colors.white,
//                                       //     fontSize: 16,
//                                       //   ),
//                                       // );
//
//                                       return Row(
//                                         children: [
//                                           Container(
//                                             // Set the background color to white
//                                             height:
//                                                 35, // Set height of the container
//                                             width:
//                                                 35, // Set width of the container
//                                             child: Image.asset(
//                                               'assets/images/time.png',
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           Text(
//                                             waitingTime ?? 'Calculating...',
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     })
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
///--------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black, // Set the background color to black
            toolbarHeight: 150,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/cmh.png',
                  height: 148,
                  width: MediaQuery.of(context).size.width * 0.99,
                  fit:
                      BoxFit.fill, // Choose fit option to maintain aspect ratio
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Container(
              color: const Color(0xFF010101),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.cabins.isEmpty) {
                  return const Center(
                    child: Text("Waiting for patient to call."),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.cabins.length,
                    itemBuilder: (context, index) {
                      final cabin = controller.cabins[index];
                      final waitingTime =
                          controller.waitingTimes[cabin.id] ?? '0:00';
                      // Parse the waiting time to calculate minutes
                      final timeParts = waitingTime.split(':');
                      final minutes = int.parse(timeParts[0]);
                      final isExceedingLimit = minutes >
                          4; // Check if waiting time exceeds 5 minutes

                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            decoration: BoxDecoration(
                              color: isExceedingLimit
                                  ? Colors.red
                                  : const Color(0xFF171717),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ListTile(
                              title: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/h1.png',
                                      height: 40,
                                      width: 54,
                                    ),
                                    Text(
                                      'Cabin ${cabin.id}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Obx(() {
                                      // print(
                                      //     'Waiting time for cabin ${cabin.id}: ${controller.waitingTimes[cabin.id]}');

                                      final waitingTime =
                                          controller.waitingTimes[cabin.id];

                                      // return Text(
                                      //   'Waiting: ${waitingTime != null ? waitingTime : 'Calculating...'}',
                                      //   style: const TextStyle(
                                      //     color: Colors.white,
                                      //     fontSize: 16,
                                      //   ),
                                      // );

                                      return Row(
                                        children: [
                                          Container(
                                            // Set the background color to white
                                            height:
                                                35, // Set height of the container
                                            width:
                                                35, // Set width of the container
                                            child: Image.asset(
                                              'assets/images/time.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            waitingTime ?? 'Calculating...',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
