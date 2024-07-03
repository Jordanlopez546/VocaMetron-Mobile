import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/edit_profile_item.dart';
import '../widgets/stack_screen_appbar.dart';
import '../providers/profile.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/settings/edit-profile-screen';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);
  bool _isLoading = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();
  final TextEditingController _experiencesController = TextEditingController();
  final TextEditingController _careerInterestsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    final profile = Provider.of<Profile>(context, listen: false);
    _fullNameController.text = profile.fullName ?? "";
    _emailController.text = profile.email ?? '';
    _phoneNumberController.text = profile.phoneNumber ?? '';
    _addressController.text = profile.address ?? '';
    _skillsController.text = profile.skills ?? '';
    _experiencesController.text = profile.experiences ?? '';
    _careerInterestsController.text = profile.careerInterests ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _skillsController.dispose();
    _experiencesController.dispose();
    _careerInterestsController.dispose();
    super.dispose();
  }

  Future<void> handleUpdate() async {
    final provider = Provider.of<Profile>(context, listen: false);

    try {
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Confirm Update'),
          content: const Text('Are you sure you want to update your profile?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Update'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        setState(() {
          _isLoading = true;
        });

        await provider.updateUserDetails(
          newFullName: _fullNameController.text,
          newEmail: _emailController.text,
          newPhoneNumber: _phoneNumberController.text,
          newAddress: _addressController.text,
          newSkills: _skillsController.text,
          newExperiences: _experiencesController.text,
          newCareerInterests: _careerInterestsController.text,
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _submit(BuildContext context) async {
    handleUpdate();
  }

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
            EditProfileItem(
                widget: TextField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Name"),
            const SizedBox(
              height: 20,
            ),
            EditProfileItem(
                widget: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Email"),
            const SizedBox(
              height: 20,
            ),
            EditProfileItem(
                widget: TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Phone"),
            const SizedBox(
              height: 20,
            ),
            EditProfileItem(
                widget: TextField(
                  controller: _addressController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Address"),
            const SizedBox(
              height: 20,
            ),
            EditProfileItem(
                widget: TextField(
                  controller: _skillsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Skills"),
            const SizedBox(
              height: 20,
            ),
            EditProfileItem(
                widget: TextField(
                  controller: _experiencesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Experiences"),
            const SizedBox(
              height: 20,
            ),
            EditProfileItem(
                widget: TextField(
                  controller: _careerInterestsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                title: "Interests"),
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
