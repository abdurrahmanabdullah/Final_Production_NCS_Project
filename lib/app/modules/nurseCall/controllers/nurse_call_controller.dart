import 'dart:async';

import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/data/services/nurseCallApiCall.dart';
import 'package:get_cli_tutorial/app/data/services/nurseCallModel.dart';


class NurseCallController extends GetxController {
  final ApiService apiservice = ApiService();

  // Define reactive lists for remoteIds and createdAt
  var remoteIds = <int?>[].obs;
  var createdAt = <String>[].obs; // List to hold formatted createdAt times

  @override
  void onInit() {
    fetchNurseCall();
    super.onInit();
  }

  Future<void> fetchNurseCall() async {
    try {
      // Fetch the list of NurseCallingModel objects
      List<NurseCallingModel> cabins = await apiservice.fetchAllCabins();

      // Extract all remote_id values and created_at values, and update the reactive lists
      remoteIds.value = cabins
          .map((cabin) => int.tryParse(cabin.remoteId ?? '') ?? null) // Convert String to int?
          .toList();
      createdAt.value = cabins.map((cabin) => cabin.createdAt != null
          ? '${DateTime.parse(cabin.createdAt.toString()).hour}:${DateTime.parse(cabin.createdAt.toString()).minute}:${DateTime.parse(cabin.createdAt.toString()).second}'
          : '').toList();

      // Print the lists for debugging
      print('Remote IDs: $remoteIds');
      print('Created At: $createdAt');
    } catch (e) {
      // Handle error
      print('Error fetching cabins: $e');
    }
  }
}
