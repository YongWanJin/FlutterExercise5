import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void _onEamilTap(BuildContext context) {
    Navigator.of(context).pushNamed(UsernameScreen.routeName);
  }

  // void _onEamilTap(BuildContext context) {
  //   Navigator.of(context).push(
  //     PageRouteBuilder(
  //       transitionDuration: Duration(seconds: 1),
  //       reverseTransitionDuration: Duration(seconds: 1),
  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //         final offsetAnimation = Tween(
  //           begin: Offset(0, -1),
  //           end: Offset.zero,
  //         ).animate(animation);
  //         final opacityAnimation = Tween(
  //           begin: 0.5,
  //           end: 1.0,
  //         ).animate(animation);
  //         return SlideTransition(
  //           position: offsetAnimation,
  //           child: FadeTransition(opacity: opacityAnimation, child: child),
  //         );
  //       },
  //       pageBuilder: (context, animation, secondaryAnimation) =>
  //           UsernameScreen(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          // * 회원 가입 안내문 * //
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    "Sign up for TikTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      gesture: () => _onEamilTap(context),
                      icon: FaIcon(FontAwesomeIcons.user),
                      text: "Use email & password",
                    ),
                    Gaps.v16,
                    AuthButton(
                      gesture: () {},
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: "Continue with Apple",
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            gesture: () => _onEamilTap(context),
                            icon: FaIcon(FontAwesomeIcons.user),
                            text: "Use email & password",
                          ),
                        ),
                        Gaps.v16,
                        Expanded(
                          child: AuthButton(
                            gesture: () {},
                            icon: FaIcon(FontAwesomeIcons.apple),
                            text: "Continue with Apple",
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          // * 하단 바 (Login) * //
          bottomNavigationBar: Container(
            // 상단 그림자 경계선
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 1.0,
                  offset: Offset(0, 1.1),
                ),
              ],
            ),
            // 하단 바 내용물
            child: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aleary have an account?"),
                    Gaps.h5,
                    GestureDetector(
                      onTap: () => _onLoginTap(context),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
