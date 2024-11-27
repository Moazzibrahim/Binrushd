// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  AuthUserResponse? _authUserResponse;
  AuthUserResponse? get authUserResponse => _authUserResponse;

  Future<void> postProfile({
    required String? token,
    required BuildContext context, // Make context required
  }) async {
    final url = Uri.parse('https://binrushd.net/api/auth/profile');

    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({}),
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
