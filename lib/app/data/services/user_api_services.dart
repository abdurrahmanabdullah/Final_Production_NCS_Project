// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// class ApiService {
//   Future<Map<String, dynamic>> fetchAllCabins() async {
//     final response = await http.get(
//       Uri.parse('http://192.168.60.53:1337/api/nurse-calls'),
//       headers: {'Content-Type': 'application/json'},
//     );
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       print('Failed to load data: ${response.statusCode}, ${response.body}');
//       throw Exception('Failed to load data');
//     }
//   }
// }
///-------------
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>> fetchAllCabins() async {
    final response = await http.get(
      Uri.parse('http://192.168.60.53:1337/api/nurse-calls'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load data: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to load data');
    }
  }
}