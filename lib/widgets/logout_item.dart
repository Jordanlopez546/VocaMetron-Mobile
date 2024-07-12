import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/chat.dart';
import '../providers/interview_tip.dart';
import '../providers/career.dart';
import '../screens/login_screen.dart';

class LogoutItem extends StatefulWidget {
  const LogoutItem({super.key});

  @override
  State<LogoutItem> createState() => _LogoutItemState();
}

class _LogoutItemState extends State<LogoutItem> {
  Future<void> handleLogout() async {
    final auth = Provider.of<Auth>(context, listen: false);
    final chat = Provider.of<ChatbotProvider>(context, listen: false);
    final tip = Provider.of<InterviewTipsProvider>(context, listen: false);
    final career = Provider.of<Career>(context, listen: false);

    try {
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Logout'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await auth.signOut();
        chat.clearMessages();
        tip.clearTips();
        career.clearCareers();
        if (!mounted) return; // Check if the widget is still in the tree

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged out successfully')),
        );

        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } catch (error) {
      if (!mounted) return; // Check if the widget is still in the tree

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $error')),
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
                Icons.logout_outlined,
                color: Colors.black38,
                size: screenWidth * 0.085,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.04,
            ),
            Text(
              "Log Out",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: screenWidth * 0.045),
            ),
          ],
        ),
      ),
    );
  }
}
