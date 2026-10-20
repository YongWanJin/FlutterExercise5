import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
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
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
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
        bottomAppBarTheme: BottomAppBarThemeData(color: Colors.grey.shade100),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: BottomAppBarThemeData(color: Colors.grey.shade900),
      ),
      initialRoute: SignUpScreen.routeName,
      routes: {
        SignUpScreen.routeName: (context) => SignUpScreen(),
        UsernameScreen.routeName: (context) => UsernameScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        EmailScreen.routeName: (context) => EmailScreen(),
      },
      // home: SignUpScreen(),
      // home: InterestsScreen(),
      // home: MainNavigationScreen(),
      // home: ActivityScreen(),
    );
  }
}
