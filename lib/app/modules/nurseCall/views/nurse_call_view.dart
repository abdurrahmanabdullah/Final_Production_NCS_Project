import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/nurse_call_controller.dart';


class NurseCallView extends GetView<NurseCallController> {
  const NurseCallView({super.key});

  @override
  Widget build(BuildContext context) {
    // Make selectedCabinId reactive
    Rx<int?> selectedCabinId = Rx<int?>(null); // Reactive variable
    RxList<int> escalatedCabinIds = RxList<int>(); // Track escalated cabins
    RxList<int> acceptedCabinIds = RxList<int>(); // Track escalated cabins
    final NurseCallController nurseController = Get.find<NurseCallController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white, // Set the background color to white
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
            child: Container(
              color: Colors.grey,
              child: Obx(() {
                return Column(
                  children: [
                    // ListView to display cabins
                    Expanded(
                      child: ListView.builder(
                        itemCount: nurseController.remoteIds.length,
                        // Only cabins, no additional row
                        itemBuilder: (context, index) {
                          int? remoteId = nurseController.remoteIds[index];
                          String createdAt = nurseController.createdAt[index];

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  selectedCabinId.value =
                                      remoteId; // Set selectedCabinId on tap
                                  print(
                                      'Selected index ${selectedCabinId.value}');
                                },
                                child: Row(
                                  children: [
                                    // Left-side bar with dynamic color for hover effect
                                    Container(
                                      width: 20, // Width of the bar
                                      height: 73, // Height of the bar
                                    ),
                                    // Main container
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 2.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey.shade600,
                                              width: 0.8, // Border width
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.grey.shade600,
                                              width: 0.8, // Border width
                                            ),
                                          ),
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
                                                    'Cabin: $remoteId',
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
                                                  Text(createdAt),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      // Show "Escalated" status if the cabin is escalated
                                                      Obx(() {
                                                        return escalatedCabinIds
                                                            .contains(remoteId)
                                                            ? Container(
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
                                                        )
                                                            : const SizedBox.shrink();
                                                      }),
                                                      const SizedBox(width: 4),
                                                      // Placeholder for "Accepted" status
                                                   Obx((){
                                                     return  acceptedCabinIds.contains(remoteId)?  Container(
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
                                                             .circular(4.0),
                                                       ),
                                                       child: const Text(
                                                         "Accepted",
                                                         style: TextStyle(
                                                           color: Colors.green,
                                                           fontSize: 12,
                                                         ),
                                                       ),
                                                     ):const SizedBox.shrink();
                                                   })
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
                              ),
                              // Show the action row below the selected cabin
                              Obx(() {
                                return selectedCabinId.value == remoteId
                                    ? Column(
                                  children: [
                                    // Row with waiting time and buttons
                                    Row(
                                      children: [
                                        // Container to show waiting time (it will only show the last cabin's waiting time)
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 8,
                                                vertical: 4),
                                            decoration:
                                            const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .zero, // Rectangular shape
                                            ),
                                            height: 72,
                                            child: Center(
                                              child: Text(createdAt),
                                            ),
                                          ),
                                        ),
                                        // First Elevated Button (Escalate)
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // Add the cabin ID to the escalated list
                                              escalatedCabinIds.add(
                                                  selectedCabinId.value!);
                                              print(
                                                  'Escalate clicked for ${selectedCabinId.value}');
                                            },
                                            style:
                                            ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Colors.deepPurple,
                                              shape:
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .zero, // Rectangular shape
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.min,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Image.asset(
                                                    'assets/icon/ex.jpeg',
                                                    width: 36,
                                                    height: 36,
                                                  ),
                                                  const SizedBox(
                                                      height: 4),
                                                  const Text("Escalate",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Second Elevated Button (Accept)
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              acceptedCabinIds.add(
                                                  selectedCabinId.value!);
                                              // Handle accept action
                                              print(
                                                  'Accept clicked for ${selectedCabinId.value}');
                                            },
                                            style:
                                            ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Colors.green,
                                              shape:
                                              const RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .zero, // Rectangular shape
                                              ),
                                            ),
                                            child: const Padding(
                                              padding:
                                              EdgeInsets.all(7.0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Icon(Icons.check,
                                                      size: 42,
                                                      color:
                                                      Colors.white),
                                                  Text("Accept",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors
                                                              .white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                    : const SizedBox.shrink();
                              }),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
