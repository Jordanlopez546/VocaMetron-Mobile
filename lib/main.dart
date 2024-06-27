import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/entry_point.dart';
import './screens/notification_screen.dart';
import './screens/interview_tips_screen.dart';
import './screens/ai_chat_screen.dart';
import './screens/career_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const VocaMetron());
}

class VocaMetron extends StatelessWidget {
  const VocaMetron({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EntryPoint(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      routes: {
        NotificationScreen.routeName: (ctx) => const NotificationScreen(),
        InterviewTipsScreen.routeName: (ctx) => const InterviewTipsScreen(),
        AiChatScreen.routeName: (ctx) => const AiChatScreen(),
        CareerDetailScreen.routeName: (ctx) => const CareerDetailScreen()
      },
    );
  }
}
