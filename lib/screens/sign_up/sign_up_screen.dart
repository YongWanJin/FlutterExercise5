import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                style: TextStyle(fontSize: Sizes.size16, color: Colors.black45),
                textAlign: TextAlign.center,
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
          elevation: 1,
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Aleary have an account?"),
                Gaps.h5,
                Text(
                  "Log in",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
