import 'package:flutter/material.dart';

import '../widgets/stack_screen_appbar.dart';

class AiChatScreen extends StatelessWidget {
  static const routeName = '/vocametron-ai-chat';

  const AiChatScreen({super.key});

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StackScreenAppbar('VocaMetron AI'),
      // body: ,
      backgroundColor: _backgroundColor,
    );
  }
}
