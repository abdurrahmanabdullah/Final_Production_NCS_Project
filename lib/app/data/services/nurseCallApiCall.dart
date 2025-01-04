import 'dart:convert'; // Import for json.decode
import 'package:http/http.dart' as http;

import 'nurseCallModel.dart'; // Import for http

class ApiService {
  // Fetch the list of NurseCallingModel objects from the API
  Future<List<NurseCallingModel>> fetchAllCabins() async {
    try {
      // Send GET request to the API endpoint
      final response = await http.get(
        Uri.parse('http://192.168.60.125:8000/api/get-patient'),
        headers: {'Content-Type': 'application/json'},
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Decode the response body to a List of dynamic objects
        List<dynamic> responseData = json.decode(response.body);

        // Print the response data for debugging purposes
        print('Response Data: $responseData');

        // Convert the response data to a list of NurseCallingModel objects
        return responseData
            .map((item) => NurseCallingModel.fromJson(item))
            .toList();
      } else {
        // Handle the case where the API call fails
        print('Failed to load data: ${response.statusCode}, ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the fetch
      print('Error fetching cabins: $e');
      throw Exception('Error fetching cabins');
    }
  }
}
