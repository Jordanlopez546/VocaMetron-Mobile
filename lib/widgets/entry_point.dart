import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../screens/career_screen.dart';
import '../screens/ai_chat_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/custom_appbar.dart';
import '../providers/chat.dart';
import '../providers/career.dart';
import '../providers/profile.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  static const routeName = '/entry-point';

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;
  late PageController _pageController;

  bool _isLoading = false;

  void _onPress() async {
    final profile = Provider.of<Profile>(context, listen: false);

    final skills = profile.skills ?? '';
    final careerInterests = profile.careerInterests ?? '';
    final experiences = profile.experiences ?? '';

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Career>(context, listen: false)
          .generateUserCareers(skills, experiences, careerInterests);
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Failed to generate career paths. Please try again.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<String> _titles = ['Careers', 'VocaMetron AI', 'Settings'];
  final Color _primaryColor = const Color.fromRGBO(0, 166, 166, 1.0);
  // Color.fromRGBO(0, 76, 159, 1) - The Other blue
  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);
  final Color _tabBackgroundColor = Colors.white;
  final Color _iconColor = Colors.white;

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
    // Ensure messages are loaded before building the UI
    Provider.of<ChatbotProvider>(context, listen: false).loadMessages();

    return Scaffold(
      appBar: CustomAppbar(
        title: _titles[_selectedIndex],
      ),
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: _onScreenChange,
          children: [
            CareerScreen(_isLoading),
            AiChatScreen(),
            const SettingsScreen()
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
              activeColor: _primaryColor,
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
                  icon: Icons.chat,
                  text: 'AI Chat',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ]),
        ),
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _onPress,
              backgroundColor: _primaryColor,
              splashColor: _backgroundColor,
              child: const Icon(Icons.add, color: Colors.white, size: 30))
          : null,
    );
  }
}
