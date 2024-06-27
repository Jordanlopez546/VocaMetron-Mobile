import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../screens/notification_screen.dart';
import '../screens/interview_tips_screen.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(InterviewTipsScreen.routeName);
            },
            icon: const Icon(
              Icons.question_answer,
              size: 27,
            ),
            tooltip: 'Interview Tips',
          ),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            showBadge: true,
            badgeContent: const Text(
              '2',
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationScreen.routeName);
              },
              icon: const Icon(
                Icons.notifications_active,
                size: 28,
              ),
              tooltip: 'Notifications',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
