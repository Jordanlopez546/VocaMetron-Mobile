import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/url.dart';
import '../utils/connectivity_helper.dart';

class Profile with ChangeNotifier {
  String? _email, _phoneNumber, _address, _fullName;
  String? _skills, _careerInterests, _experiences;

  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get fullName => _fullName;
  String? get skills => _skills;
  String? get careerInterests => _careerInterests;
  String? get experiences => _experiences;

  // Fetch user details from the database
  Future<void> fetchUserDetails() async {
    bool isConnected = await ConnectivityHelper.isInternetAvailable();

    if (!isConnected) {
      throw Exception('No internet connection');
    }

    final url = Uri.parse('$apiUrl/app/auth/user/user-details');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      String? jwtToken = userData['token'];
      String? csrfToken = userData['csrfToken'];

      if (jwtToken != null && csrfToken != null) {
        try {
          final response = await http.get(url, headers: {
            'Authorization': 'Bearer $jwtToken',
            'x-csrf-token': csrfToken,
            'Content-Type': 'application/json'
          });

          if (response.statusCode == 200) {
            final data = json.decode(response.body);

            _email = data['email'];
            _fullName = data['fullName'];
            _address = data['address'];
            _phoneNumber = data['phoneNumber'];
            _skills = data['skills'];
            _careerInterests = data['careerInterests'];
            _experiences = data['experiences'];

            notifyListeners();
          } else {
            throw Exception('Failed to load user details');
          }
        } catch (e) {
          rethrow;
        }
      }
    }
  }

  // Update user details from the database
  Future<void> updateUserDetails({
    String? newEmail,
    String? newPhoneNumber,
    String? newAddress,
    String? newFullName,
    String? newSkills,
    String? newCareerInterests,
    String? newExperiences,
  }) async {
    final url = Uri.parse('$apiUrl/app/auth/user/update-user-details');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      String? jwtToken = userData['token'];
      String? csrfToken = userData['csrfToken'];

      if (jwtToken != null && csrfToken != null) {
        try {
          final Map<String, dynamic> updatedFields = {};

          // Add fields to update based on provided parameters
          if (newEmail != null) updatedFields['email'] = newEmail;
          if (newPhoneNumber != null) {
            updatedFields['phoneNumber'] = newPhoneNumber;
          }
          if (newAddress != null) updatedFields['address'] = newAddress;
          if (newFullName != null) updatedFields['fullName'] = newFullName;
          if (newSkills != null) updatedFields['skills'] = newSkills;
          if (newCareerInterests != null) {
            updatedFields['careerInterests'] = newCareerInterests;
          }
          if (newExperiences != null) {
            updatedFields['experiences'] = newExperiences;
          }

          final response = await http.patch(
            url,
            headers: {
              'Authorization': 'Bearer $jwtToken',
              'x-csrf-token': csrfToken,
              'Content-Type': 'application/json'
            },
            body: json.encode(updatedFields),
          );

          if (response.statusCode == 200) {
            final responseData = json.decode(response.body);

            _email = responseData['email'];
            _phoneNumber = responseData['phoneNumber'];
            _address = responseData['address'];
            _fullName = responseData['fullName'];
            _skills = responseData['skills'];
            _careerInterests = responseData['careerInterests'];
            _experiences = responseData['experiences'];

            notifyListeners();
          } else {
            throw Exception('Failed to update user details');
          }
        } catch (error) {
          rethrow;
        }
      }
    }
  }

  // Update user details from the database
  Future<void> deleteUser() async {
    final url = Uri.parse('$apiUrl/app/auth/user/delete-user-by-user-option');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');

    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      String? jwtToken = userData['token'];
      String? csrfToken = userData['csrfToken'];

      if (jwtToken != null && csrfToken != null) {
        try {
          final response = await http.delete(
            url,
            headers: {
              'Authorization': 'Bearer $jwtToken',
              'x-csrf-token': csrfToken,
              'Content-Type': 'application/json'
            },
          );

          if (response.statusCode == 200) {
            _email = null;
            _fullName = null;
            _address = null;
            _phoneNumber = null;
            _skills = null;
            _careerInterests = null;
            _experiences = null;

            notifyListeners();
          } else {
            throw Exception('Failed to update user details');
          }
        } catch (error) {
          rethrow;
        }
      }
    }
  }
}
