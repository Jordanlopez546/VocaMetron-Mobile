import 'package:flutter/material.dart';

import '../widgets/stack_screen_appbar.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/settings/help-screen';

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StackScreenAppbar('Help'),
      // body: ,
      backgroundColor: _backgroundColor,
    );
  }
}
