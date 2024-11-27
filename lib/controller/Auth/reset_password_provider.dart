// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordProvider with ChangeNotifier {
  Future<void> resetPasswordP({
    required String? password,
    required String? confPassword,
    required String? token,
    required BuildContext context, // Make context required
  }) async {
    final url = Uri.parse('https://binrushd.net/api/auth/reset_password');

    // Prepare the request body as JSON
    final Map<String, dynamic> requestBody = {
      'password': password,
      'password_confirmation': confPassword
    };

    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
      } else {
        print('Request failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
