import 'package:flutter/material.dart';

import '../widgets/edit_profile_item.dart';
import '../widgets/stack_screen_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/settings/edit-profile-screen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);
  final bool _isLoading = false;

  _submit(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const StackScreenAppbar('Account'),
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Acccount",
              style: TextStyle(
                  fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            EditProfileItem(
              title: "Photo",
              widget: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      "assets/images/blank-profile-picture.png",
                      height: screenHeight * 0.13,
                      width: screenWidth * 0.34,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromRGBO(0, 166, 166, 1.0)),
                      child: const Text("Upload Image"))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Name"),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Email"),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Phone"),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Address"),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Skills"),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Experiences"),
            const SizedBox(
              height: 20,
            ),
            const EditProfileItem(widget: TextField(), title: "Interests"),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => _submit(context),
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromRGBO(0, 166, 166, 1.0))),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Update',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.055,
                            color: Colors.white,
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
