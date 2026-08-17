import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final GestureTapCallback gesture;
  // typedef GestureTapCallback = void Function();
  // 일반적으로 GestureDetector를 버튼 위젯 안에 넣는 것을 추천한다.
  // 버튼을 생성할때마다 매번 GestureDetector로 감싸는 것을 잊는 실수를 방지할 수 있기 때문이다.

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.gesture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gesture,
      child: FractionallySizedBox(
        // FractionallySizedBox : 부모 위젯의 Padding에 비례해서 위젯의 크기를 조정할 수 있는 위젯
        widthFactor: 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes.size14,
            horizontal: Sizes.size14,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200, width: Sizes.size1),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: icon),
              Text(
                text,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
