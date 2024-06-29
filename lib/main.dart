import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/notification_screen.dart';
import './screens/interview_tips_screen.dart';
import './screens/ai_chat_screen.dart';
import './screens/career_detail_screen.dart';
import './screens/registration_screen.dart';
import './screens/login_screen.dart';
import './providers/auth.dart';
import './widgets/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const VocaMetron());
}

class VocaMetron extends StatelessWidget {
  const VocaMetron({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const AuthWrapper(),
            theme: ThemeData(
              fontFamily: 'Poppins',
            ),
            routes: {
              NotificationScreen.routeName: (ctx) => const NotificationScreen(),
              InterviewTipsScreen.routeName: (ctx) =>
                  const InterviewTipsScreen(),
              AiChatScreen.routeName: (ctx) => const AiChatScreen(),
              CareerDetailScreen.routeName: (ctx) => const CareerDetailScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              RegistrationScreen.routeName: (ctx) => const RegistrationScreen(),
            },
          ),
        ));
  }
}
