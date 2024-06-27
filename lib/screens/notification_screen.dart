import 'package:flutter/material.dart';

import '../widgets/stack_screen_appbar.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification-screen';

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StackScreenAppbar('Notifications'),
      // body: ,
      backgroundColor: _backgroundColor,
    );
  }
}
