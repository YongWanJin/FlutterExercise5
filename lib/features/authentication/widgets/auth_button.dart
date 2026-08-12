import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;

  const AuthButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // FractionallySizedBox : 부모 위젯의 Padding에 비례해서 위젯의 크기를 조정할 수 있는 위젯
      widthFactor: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Sizes.size14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200, width: Sizes.size1),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
