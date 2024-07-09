import 'package:flutter/material.dart';
// import 'package:badges/badges.dart' as badges;

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        // actions: const [
        // Container(
        //   decoration: BoxDecoration(
        //       color: _primaryColor, borderRadius: BorderRadius.circular(10)),
        //   child: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushNamed(InterviewTipsScreen.routeName);
        //     },
        //     icon: const Icon(
        //       Icons.question_answer,
        //       size: 27,
        //       color: Colors.white,
        //     ),
        //     tooltip: 'Interview Tips',
        //   ),
        // ),
        // const SizedBox(
        //   width: 15,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //       color: _primaryColor, borderRadius: BorderRadius.circular(10)),
        //   child: badges.Badge(
        //     position: badges.BadgePosition.topEnd(top: 0, end: 3),
        //     showBadge: true,
        //     badgeContent: const Text(
        //       '2',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     child: IconButton(
        //       onPressed: () {
        //         Navigator.of(context).pushNamed(NotificationScreen.routeName);
        //       },
        //       icon: const Icon(
        //         Icons.notifications_active,
        //         size: 28,
        //         color: Colors.white,
        //       ),
        //       tooltip: 'Notifications',
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 15,
        // ),
        // ],
        actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/icon.png', width: 60, height: 100)),
          const SizedBox(
            width: 10,
          )
        ],
        title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
