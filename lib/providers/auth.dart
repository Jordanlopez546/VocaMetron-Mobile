import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/url.dart';
import '../utils/api_utils.dart';
import '../providers/profile.dart';

class Auth with ChangeNotifier {
  String? _token, _csrfToken;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth => token != null;
  String? get csrfToken => _csrfToken;
  String? get userId => _userId;

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> _saveAuthData() async {
    final prefs = await SharedPreferences.getInstance();

    final userData = json.encode({
      'token': _token,
      'csrfToken': _csrfToken,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String()
    });

    await prefs.setString('userData', userData);

    notifyListeners();
  }

  Future<void> loadAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      final expiryDate =
          DateTime.parse(extractedUserData['expiryDate'] as String);

      if (expiryDate.isBefore(DateTime.now())) {
        return;
      }

      _token = extractedUserData['token'] as String;
      _userId = extractedUserData['userId'] as String;
      _csrfToken = extractedUserData['csrfToken'] as String;
      _expiryDate = expiryDate;

      notifyListeners();
    } catch (error) {
      throw 'Error loading authentication data: $error';
    }
  }

  Future<Response> signIn(
      String email, String password, Profile profileProvider) async {
    final response =
        await handleApiRequest(() => post(Uri.parse('$apiUrl/app/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'email': email,
              'password': password,
            })));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      _token = responseBody['token'];
      _userId = responseBody['user']['_id'];
      _csrfToken = responseBody['_csrf'];
      _expiryDate = DateTime.now().add(const Duration(days: 365));

      await _saveAuthData();
      await profileProvider.fetchUserDetails();

      notifyListeners();
    }

    return response;
  }

  Future<Response> signUp(
      String fullName,
      String email,
      String password,
      String phoneNumber,
      String address,
      String skills,
      String experiences,
      String careerInterests) async {
    return handleApiRequest(() => post(Uri.parse('$apiUrl/app/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'fullName': fullName,
          'address': address,
          'phoneNumber': phoneNumber,
          'skills': skills,
          'careerInterests': careerInterests,
          'experiences': experiences,
        })));
  }

  Future<void> signOut() async {
    _token = null;
    _userId = null;
    _csrfToken = null;
    _expiryDate = null;

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData'); // Remove stored data from SharedPreferences

    notifyListeners();
  }
}
