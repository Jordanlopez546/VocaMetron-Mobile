import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './login_screen.dart';
import '../providers/auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration-screen';

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experiencesController = TextEditingController();
  final _careerInterestsController = TextEditingController();
  bool _isLoading = false;

  _showMyDialog(BuildContext context, String type, String message) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(type),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateInputs(context, email, password, fullName, phoneNumber, address,
      skills, experiences, careerInterests) {
    if (email.isEmpty ||
        password.isEmpty ||
        fullName.isEmpty ||
        phoneNumber.isEmpty ||
        address.isEmpty ||
        skills.isEmpty ||
        experiences.isEmpty ||
        careerInterests.isEmpty) {
      _showMyDialog(context, 'Invalid Inputs', 'Please fill in all fields');
      return false;
    }

    if (password.length < 6) {
      _showMyDialog(
          context, 'Invalid Input', 'Password must be at least 6 characters');
      return false;
    }

    return true;
  }

  void _clearInputs() {
    // Clear the input fields
    _fullNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _skillsController.clear();
    _experiencesController.clear();
    _careerInterestsController.clear();
  }

  Future<void> _submit(BuildContext context) async {
    var fullName = _fullNameController.text.trim();
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    var phoneNumber = _phoneNumberController.text.trim();
    var address = _addressController.text.trim();
    var skills = _skillsController.text.trim();
    var experiences = _experiencesController.text.trim();
    var careerInterests = _careerInterestsController.text.trim();

    if (!_validateInputs(context, email, password, fullName, phoneNumber,
        address, skills, experiences, careerInterests)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Provider.of<Auth>(context, listen: false).signUp(
          fullName,
          email,
          password,
          phoneNumber,
          address,
          skills,
          experiences,
          careerInterests);

      var message = '';
      var type = '';

      if (response.statusCode == 201) {
        type = 'Success';
        message = 'Sign up successful';

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      } else {
        type = 'Error';
        message =
            'Sign up failed. ${json.decode(response.body)['message'] ?? 'User may already exist'}';
      }

      _clearInputs();

      Future.delayed(Duration.zero, () {
        _showMyDialog(context, type, message);
      });
    } catch (e) {
      Future.delayed(Duration.zero, () {
        _showMyDialog(context, 'Network error', e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 166, 166, 1.0)),
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.08, left: screenWidth * 0.05),
                child: const Text(
                  'Welcome to VocaMetron\nSign up!',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.25),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: screenHeight * 0.75,
                width: screenWidth,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: _fullNameController,
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.grey,
                          decoration: const InputDecoration(
                            label: Text(
                              'Full Name/Username',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          controller: _passwordController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            label: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          controller: _addressController,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            label: Text(
                              'Address',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: _skillsController,
                          decoration: const InputDecoration(
                            label: Text(
                              'Skills',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: _experiencesController,
                          decoration: const InputDecoration(
                            label: Text(
                              'Experiences',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.grey,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: _careerInterestsController,
                          decoration: const InputDecoration(
                            label: Text(
                              'Career Interests',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 166, 166, 1.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed:
                                _isLoading ? null : () => _submit(context),
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Color.fromRGBO(0, 166, 166, 1.0))),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.08),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      LoginScreen.routeName);
                                },
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Color.fromRGBO(0, 166, 166, 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20), // Add space at the bottom
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
