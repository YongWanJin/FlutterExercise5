import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class Counting extends StatelessWidget {
  final String number;
  final String category;
  const Counting({super.key, required this.number, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: Sizes.size18),
          textAlign: TextAlign.center,
        ),
        Text(
          category,
          style: TextStyle(color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
