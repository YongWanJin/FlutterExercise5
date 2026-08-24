import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class DetailNavigationScreen extends StatefulWidget {
  const DetailNavigationScreen({super.key});

  @override
  State<DetailNavigationScreen> createState() => _DetailNavigationScreenState();
}

class _DetailNavigationScreenState extends State<DetailNavigationScreen> {
  int _clickedNumber = 0;

  void _click() {
    setState(() {
      _clickedNumber = _clickedNumber + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$_clickedNumber", style: TextStyle(fontSize: Sizes.size20)),
          Gaps.v10,
          GestureDetector(
            onTap: () => _click(),
            child: Text("+", style: TextStyle(fontSize: Sizes.size20)),
          ),
        ],
      ),
    );
  }
}
