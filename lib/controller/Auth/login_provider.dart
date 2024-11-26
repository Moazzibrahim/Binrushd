// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/login_model.dart';
import 'package:flutter_application_1/view/screens/tabs_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;
  String? token;
  String? fname;
  Future<void> login(
      String email, String password, BuildContext context) async {
    // Define the URL and headers
    final url = Uri.parse(
        'https://binrushd.net/api/auth/login'); // Replace with your BASE_URL
    final headers = {
      'Accept': 'application/json',
    };

    // Define the body data for form-data
    final body = {
      'mode': 'formdata',
      'email': email,
      'password': password,
    };

    // Send the POST request
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Successfully logged in
        print('Login successful');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TabsScreen()));
        // Handle the response body if necessary
        final responseBody = json.decode(response.body);
        token = responseBody['data']['user']['token'];
        log(token!);
        print(responseBody);
        _loginResponse = LoginResponse.fromJson(responseBody);
        notifyListeners();
      } else {
        // Failed login attempt
        print('Failed to login. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(' الرجاء ادخال ايميل و الرقم السري صحيح')),
        );
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }
}
