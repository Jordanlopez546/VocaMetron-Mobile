import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReturnUser {
  static Future<String?> getUserData(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      String? expiryDateString = userData['expiryDate'];
      String? token = userData['token'];
      String? userId = userData['userId'];

      if (expiryDateString != null && token != null) {
        DateTime expiryDate = DateTime.parse(expiryDateString);

        if (expiryDate.isAfter(DateTime.now())) {
          return type == "userId" ? userId : token;
        }
      }
    }

    return null;
  }
}
