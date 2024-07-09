import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';
import '../screens/login_screen.dart';

class DeleteAccountItem extends StatefulWidget {
  const DeleteAccountItem({super.key});

  @override
  State<DeleteAccountItem> createState() => _DeleteAccountItemState();
}

class _DeleteAccountItemState extends State<DeleteAccountItem> {
  Future<void> handleLogout() async {
    final profile = Provider.of<Profile>(context, listen: false);

    try {
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Confirm Delete Account'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await profile.deleteUser();
        if (!mounted) return; // Check if the widget is still in the tree

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deleted account successfully')),
        );

        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } catch (error) {
      if (!mounted) return; // Check if the widget is still in the tree

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete your account: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: handleLogout,
      child: SizedBox(
        width: screenWidth,
        child: Row(
          children: [
            CircleAvatar(
              radius: screenWidth * 0.075,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: screenWidth * 0.085,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Text(
              "Delete Account",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.045,
                  color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
