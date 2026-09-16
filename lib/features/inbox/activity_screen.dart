import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All activity")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: ListView(
          children: [
            Gaps.v14,
            Text(
              "New",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.grey.shade500,
              ),
            ),
            Gaps.v14,
            for (var _notification in _notifications)
              Dismissible(
                key: Key(_notification),
                onDismissed: (direction) => _onDismissed(_notification),
                background: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.green,
                  child: Padding(
                    padding: EdgeInsets.only(left: Sizes.size10),
                    child: FaIcon(
                      FontAwesomeIcons.checkDouble,
                      color: Colors.white,
                      size: Sizes.size32,
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.only(right: Sizes.size10),
                    child: FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.white,
                      size: Sizes.size32,
                    ),
                  ),
                ),
                child: ListTile(
                  minVerticalPadding: Sizes.size16,
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: Sizes.size52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: Sizes.size1,
                      ),
                    ),
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.bell, color: Colors.black),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: "Account updates:",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: Sizes.size16,
                      ),
                      children: [
                        TextSpan(
                          text: " Upload longer videos",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: " $_notification",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: Sizes.size16,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
