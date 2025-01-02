
import 'package:get/get.dart';

import 'package:get_cli_tutorial/app/data/services/user_api_services.dart';
import 'package:get_cli_tutorial/app/modules/home/views/home_view.dart';
import 'home_controller.dart';  // Import HomeController

class LandingPageController extends GetxController {

  RxString selectedOption = 'ns2'.obs; // Default value is 'ns2'
  var cabins = <dynamic>[].obs; // Reactive list to hold cabins data

  final ApiService apiService = ApiService(); // Create an instance of ApiService

  // This method will handle the selection from the dropdown menu
  void onOptionSelected(String newOption) async {
    selectedOption.value = newOption; // Update the selected option

    // Add your logic here based on the selected option
    if (newOption == 'ns1') {
      print('User selected ns1');
      String endpoint = 'ns1s';
      try {
        final data = await apiService.fetchAllCabins( );
        cabins.value = data['data']; // Assuming the response has a 'data' field
        print('Fetched cabins data: $data');

        // Inject HomeController before navigating
        Get.put(HomeController());  // Ensure HomeController is injected
        Get.to(() => const HomeView());

      } catch (e) {
        print('Error fetching data: $e');
      }

    } else if (newOption == 'ns2') {
      print('User selected ns2');
      String endpoint = 'ns2s';
      try {
        final data = await apiService.fetchAllCabins();
        cabins.value = data['data']; // Assuming the response has a 'data' field
        print('Fetched cabins data: $data');

        // Inject HomeController before navigating
        Get.put(HomeController());  // Ensure HomeController is injected
        Get.to(() => const HomeView());
      } catch (e) {
        print('Error fetching data: $e');
      }

    } else if (newOption == 'ns3') {
      print('User selected ns3');
      // Fetch data for 'ns3'
    }
  }

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onClose() {

    super.onClose();
  }
}
