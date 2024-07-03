import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './entry_point.dart';
import '../screens/login_screen.dart';
import '../providers/profile.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginAndFetchProfile(
          Provider.of<Profile>(context, listen: false)),
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

  Future<bool> checkLoginAndFetchProfile(Profile profileProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      String? expiryDateString = userData['expiryDate'];
      String? token = userData['token'];

      if (expiryDateString != null && token != null) {
        DateTime expiryDate = DateTime.parse(expiryDateString);

        if (expiryDate.isAfter(DateTime.now())) {
          // Token is valid, fetch user profile
          await profileProvider.fetchUserDetails();
          return true;
        }
      }
    }

    // Token expired or no valid user data found
    return false;
  }
}
