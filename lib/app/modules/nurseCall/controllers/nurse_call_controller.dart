import 'package:get/get.dart';
import 'package:get_cli_tutorial/app/data/services/nurseCallApiCall.dart';
import 'package:get_cli_tutorial/app/data/services/nurseCallModel.dart';

class NurseCallController extends GetxController {
  final ApiService apiservice = ApiService();

  var remoteIds = <String>[].obs;

  @override
  void onInit() {
    fetchNurseCall();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchNurseCall() async {
    try {
      // Fetch the list of NurseCallingModel objects
      List<NurseCallingModel> cabins = await apiservice.fetchAllCabins();

      // Extract all remote_id values and update the reactive list
      remoteIds.value = cabins.map((cabin) => cabin.remoteId ?? '').toList();

      // Print the list of remote_ids for debugging
      print('Remote IDs: $remoteIds');
    } catch (e) {
      // Handle error
      print('Error fetching cabins: $e');
    }
  }
}
