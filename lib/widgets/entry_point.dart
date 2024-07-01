import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/career_screen.dart';
import '../screens/jobs_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/resume_screen.dart';
import '../widgets/custom_appbar.dart';
import '../screens/ai_chat_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  static const routeName = '/entry-point';

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<String> _titles = ['Careers', 'Jobs', 'Resume', 'Settings'];
  final Color _primaryColor = const Color.fromRGBO(0, 166, 166, 1.0);
  // Color.fromRGBO(0, 76, 159, 1) - The Other blue
  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);
  final Color _tabBackgroundColor = Colors.white;
  final Color _iconColor = Colors.white;
  final Color _activeColor = const Color.fromRGBO(0, 166, 166, 1.0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onScreenChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabChange(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: _titles[_selectedIndex],
      ),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onScreenChange,
          children: const [
            CareerScreen(),
            JobsScreen(),
            ResumeScreen(),
            SettingsScreen()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: _primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
              backgroundColor: _primaryColor,
              color: _iconColor,
              activeColor: _activeColor,
              tabBackgroundColor: _tabBackgroundColor,
              padding: const EdgeInsets.all(16),
              gap: 10,
              selectedIndex: _selectedIndex,
              onTabChange: _onTabChange,
              tabs: const [
                GButton(
                  icon: Icons.work,
                  text: 'Careers',
                ),
                GButton(
                  icon: Icons.business_center,
                  text: 'Jobs',
                ),
                GButton(
                  icon: Icons.description,
                  text: 'Resume',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AiChatScreen.routeName);
        },
        backgroundColor: _tabBackgroundColor,
        tooltip: 'VocaMetron AI Chat',
        foregroundColor: _activeColor,
        splashColor: _backgroundColor,
        child: const Icon(Icons.chat),
      ),
    );
  }
}
