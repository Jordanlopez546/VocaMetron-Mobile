import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './entry_point.dart';
import '../screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (snapshot.data == true) {
            return const EntryPoint();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      String? expiryDateString = userData['expiryDate'];

      if (expiryDateString != null) {
        DateTime expiryDate = DateTime.parse(expiryDateString);

        if (expiryDate.isAfter(DateTime.now())) {
          // Token is valid
          return true;
        }
      }
    }

    // Token expired or no valid user data found
    return false;
  }
}
