// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/home_controller.dart';
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
//                           74; // Check if waiting time exceeds 5 minutes
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
//                                       final waitingTime =
//                                           controller.waitingTimes[cabin.id];
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
///-------------------modification code
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    // Track selected cabin
    int? selectedCabinId;
    int? acceptedCabinId;
    int? escalateCabinId;
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
                  width: MediaQuery.of(context).size.width * 0.99,
                  fit: BoxFit.fill, // Maintain aspect ratio
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Container(
              color: Colors.grey,
              // color: const Color(0xFFebecf0),
              // color: const Color(0xFF010101),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.cabins.isEmpty) {
                  return const Center(
                    child: Text(
                      "Waiting for patient to call.",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      // ListView to display cabins
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.cabins.length + 1,
                          // Add one for the button row
                          itemBuilder: (context, index) {
                            if (index < controller.cabins.length) {
                              final cabin = controller.cabins[index];
                              final waitingTime =
                                  controller.waitingTimes[cabin.id] ?? '0:00';
                              final timeParts = waitingTime.split(':');
                              final minutes = int.parse(timeParts[0]);
                              ///--- Determine the background color based on waiting time
                              Color waitingTimeColor;
                              if (minutes >= 5) {
                                waitingTimeColor = Colors.red; // Red for 5 minutes or more
                              } else if (minutes >= 2) {
                                waitingTimeColor = Colors.yellow; // Yellow for 2 to 4 minutes
                              } else {
                                waitingTimeColor = Colors.white; // White for less than 2 minutes
                              }
                              return GestureDetector(
                                onTap: () {
                                  // Set the selected cabin when ListTile is clicked
                                  selectedCabinId = cabin.id;
                                },
                                child: Row(
                                  children: [
                                    // Left-side white bar outside the main container
                                    Container(
                                      width: 20, // Width of the bar
                                      height: 73, // Height of the bar
                                      color: waitingTimeColor,// Set the color to white
                                    ),

                                    // Add a gap between the white bar and the main container


                                    // Main container
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 2.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFebecf0),
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey.shade600,
                                              // Top border color
                                              width: 0.8, // Border width
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.grey.shade600,
                                              // Bottom border color
                                              width: 0.8, // Border width
                                            ),
                                          ),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10)),
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Room and Patient Call Details
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Cabin ${cabin.id}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  const Text(
                                                    'Patient Call',
                                                    style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Waiting Time and Status
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    waitingTime,
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      if (escalateCabinId == cabin.id)
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 2.0,
                                                          horizontal: 6.0,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .red.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                        ),
                                                        child: const Text(
                                                          "Escalated",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      // Show "Accepted" only for the accepted cabin
                                                      if (acceptedCabinId == cabin.id)
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 2.0,
                                                            horizontal: 6.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .green.shade100,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          ),
                                                          child: const Text(
                                                            "Accepted",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // This is the last item (the row with buttons)
                              return selectedCabinId != null
                                  ? Row(
                                      children: [
                                        // Container to show waiting time (it will only show the last cabin's waiting time)
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              // color: Colors.grey.shade800,
                                              // Background color for the container
                                              borderRadius: BorderRadius
                                                  .zero, // Rectangular shape
                                            ),
                                            height: 72,
                                            // Set a fixed height to match the buttons
                                            child: Center(
                                              child: Text(
                                                controller.waitingTimes[
                                                        selectedCabinId!] ??
                                                    '0:00',
                                                // Display the selected cabin's waiting time
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // First Elevated Button
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {

                                              escalateCabinId = selectedCabinId;

                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              // Set the background color of the button
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .zero, // Rectangular shape
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                // Ensure the column takes minimal space, but can expand if needed
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                // Align the content to the top of the button
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // Center the content horizontally
                                                children: [
                                                  // Image from assets
                                                  Image.asset(
                                                    'assets/icon/ex.jpeg',
                                                    // Path to your image
                                                    width: 36,
                                                    // Set the size of the image to match your desired icon size
                                                    height: 36,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  // Space between icon and text
                                                  const Text("Escalate",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .white, // Text color
                                                      )),
                                                  // Text below the icon
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Second Elevated Button
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Set the accepted cabin ID when "Accept" is pressed
                                              acceptedCabinId = selectedCabinId;
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .zero, // Rectangular shape
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(7.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                // Ensures the column takes up full height
                                                children: [
                                                  Icon(Icons.check,
                                                      size: 42,
                                                      color: Colors.white),
                                                  // Icon above
                                                  Text("Accept",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white)),
                                                  // Text below the icon
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(); // Hide the row if no cabin is selected
                            }
                          },
                        ),
                      ),
                    ],
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
