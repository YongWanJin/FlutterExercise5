import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class BodyText extends StatefulWidget {
  final String text;

  const BodyText({super.key, required this.text});

  @override
  State<BodyText> createState() => _BodyTextState();
}

class _BodyTextState extends State<BodyText> {
  bool _seeMore = false;
  TextStyle bodyTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  void _onSeeMoreTap() {
    setState(() {
      _seeMore = !_seeMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onSeeMoreTap,
      child: _seeMore
          ? SizedBox(width: 310, child: Text(widget.text, style: bodyTextStyle))
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.text.substring(0, 20)} ...",
                  style: bodyTextStyle,
                ),
                Gaps.h10,
                Text(
                  "See",
                  style: TextStyle(color: Colors.white, fontSize: Sizes.size16),
                ),
                Gaps.h4,
                Text(
                  "more",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
