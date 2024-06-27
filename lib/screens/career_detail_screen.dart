import 'package:flutter/material.dart';

import '../widgets/stack_screen_appbar.dart';

class CareerDetailScreen extends StatelessWidget {
  static const routeName = '/career/career-detail-screen';

  final Color _backgroundColor = const Color.fromRGBO(234, 242, 255, 1.0);

  const CareerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StackScreenAppbar('Title'),
      backgroundColor: _backgroundColor,
    );
  }
}
