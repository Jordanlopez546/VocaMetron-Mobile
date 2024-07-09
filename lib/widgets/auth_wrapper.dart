import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './entry_point.dart';
import '../screens/login_screen.dart';
import '../providers/profile.dart';
import '../utils/connectivity_helper.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInternetAndLogin(
        Provider.of<Profile>(context, listen: false),
        context,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
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

  Future<bool> checkInternetAndLogin(
      Profile profileProvider, BuildContext context) async {
    bool isConnected = await ConnectivityHelper.isInternetAvailable();

    if (!isConnected) {
      // No internet connection
      // ignore: use_build_context_synchronously
      await showNoInternetAlert(context);
      return false;
    } else {
      // Internet connection is available, proceed with login check
      return checkLoginAndFetchProfile(profileProvider);
    }
  }

  Future<void> showNoInternetAlert(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content:
              const Text('Please connect to the internet to use this app.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
                FlutterExitApp.exitApp(); // This will exit the app on Android
              },
            ),
          ],
        );
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
          // Token is valid, fetch user profile, user messages
          await profileProvider.fetchUserDetails();

          return true;
        }
      }
    }

    // Token expired or no valid user data found
    return false;
  }
}
