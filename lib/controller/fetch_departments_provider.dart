import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/department_model.dart';
import 'package:http/http.dart' as http;

class FetchDepartmentsProvider with ChangeNotifier {
  DepartmentResponse? _departmentResponse;
  DepartmentResponse? get departmentResponse => _departmentResponse;

  // Function to fetch branches data from the API
  Future<void> fetchDepartments(BuildContext context) async {
    final url = Uri.parse('https://binrushd.net/api/department'); // API URL

    try {
      // Sending a GET request to the URL
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token',
      });

      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Parse the response body into the model
        final jsonResponse = json.decode(response.body);
        _departmentResponse = DepartmentResponse.fromJson(
            jsonResponse); // Assigning to the response
        notifyListeners(); // Notify listeners about the change in data
      } else if (response.statusCode == 401) {
        // Handle unauthorized access (token expired or invalid)
        log('Unauthorized access. Please log in again.');
        // Optionally navigate to the login screen or show a message
      } else {
        log('Failed to load branches. Status code: ${response.statusCode}');
        throw Exception('Failed to load branches');
      }
    } catch (error) {
      log('Error occurred: $error');
      throw Exception('Error: $error');
    }
  }
}
