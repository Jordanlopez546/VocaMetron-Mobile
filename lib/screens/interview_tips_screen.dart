import 'package:flutter/material.dart';

import '../widgets/stack_screen_appbar.dart';

class InterviewTipsScreen extends StatelessWidget {
  static const routeName = '/interview-tips-screen';

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  const InterviewTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StackScreenAppbar('Interview Tips'),
      backgroundColor: _backgroundColor,
    );
  }
}
