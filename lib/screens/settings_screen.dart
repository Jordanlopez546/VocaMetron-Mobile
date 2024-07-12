import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/forward_button.dart';
import '../widgets/setting_item.dart';
import '../widgets/logout_item.dart';
import './interview_tips_screen.dart';
import './profile_screen.dart';
import '../widgets/delete_account_item.dart';
import '../providers/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            "Account",
            style: TextStyle(
                fontSize: screenWidth * 0.055, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: screenWidth,
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(EditProfileScreen.routeName),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.08,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/images/blank-profile-picture.png",
                        height: screenHeight * 0.10,
                        width: screenWidth * 0.10,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<Profile>(
                        builder: (ctx, profile, _) => Text(
                          profile.fullName ?? "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * 0.045),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Personal Info",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const ForwardButton()
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text("Settings",
              style: TextStyle(
                  fontSize: screenWidth * 0.055, fontWeight: FontWeight.w500)),
          const SizedBox(
            height: 20,
          ),
          SettingItem(
            title: "Interview Tips",
            icon: Icons.question_answer,
            onTap: () =>
                Navigator.of(context).pushNamed(InterviewTipsScreen.routeName),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // SettingItem(
          //   title: "Notifications",
          //   icon: Icons.notifications,
          //   onTap: () =>
          //       Navigator.of(context).pushNamed(NotificationScreen.routeName),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // SettingItem(
          //   title: "Help",
          //   icon: Icons.help,
          //   onTap: () => Navigator.of(context).pushNamed(HelpScreen.routeName),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Consumer<VocaTheme>(
          //   builder: (ctx, theme, _) => SettingSwitch(
          //     title: theme.isDarkMode ? "Dark Mode" : "Light Mode",
          //     icon: theme.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          //     onTap: theme.toggleTheme,
          //     value: theme.isDarkMode,
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          const LogoutItem(),
          const SizedBox(
            height: 20,
          ),
          const DeleteAccountItem(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
