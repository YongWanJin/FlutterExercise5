import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/main_navigation/new_navigation_screen.dart';
import 'package:tiktok_clone/features/onbording/interests_screen.dart';

void main() async {
  // 앱의 화면 방향 고정
  WidgetsFlutterBinding.ensureInitialized(); // 위젯과 flutter 엔진을 초기화시켜 연결함
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]); // 고정시킬 화면 방향

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        primaryColor: Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // home: SignUpScreen(),
      // home: InterestsScreen(),
      home: MainNavigationScreen(),
      // home: ActivityScreen(),
    );
  }
}
