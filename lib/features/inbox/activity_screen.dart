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

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _notifications = List.generate(20, (index) => "${index}h");
  final List<Map<String, dynamic>> _tabs = [
    {"title": "All activity", "icon": FontAwesomeIcons.solidMessage},
    {"title": "Likes", "icon": FontAwesomeIcons.solidHeart},
    {"title": "Comments", "icon": FontAwesomeIcons.solidComments},
    {"title": "Mentions", "icon": FontAwesomeIcons.at},
    {"title": "Followers", "icon": FontAwesomeIcons.solidUser},
    {"title": "From TikTok", "icon": FontAwesomeIcons.tiktok},
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  /// 상단 AppBar의 아이콘 버튼 chevronDown에 적용할 모션
  late final Animation<double> _arrowAnimation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_animationController);

  /// 상단 AppBar의 아이콘 버튼을 탭했을 때 나타나는 패널에 적용할 모션
  late final Animation<Offset> _panelAnimation = Tween(
    begin: Offset(0, -1),
    end: Offset.zero,
  ).animate(_animationController);

  // All activities 패널 후방에 적용할 회색 장벽(클릭 불가능) 애니메이션
  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

  void _onDismissed(String notification) {
    _notifications.remove(notification);
    setState(() {});
  }

  void _toggleAnimations() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("All activity"),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: FaIcon(FontAwesomeIcons.chevronDown, size: Sizes.size14),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: Stack(
          children: [
            ListView(
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
                          child: FaIcon(
                            FontAwesomeIcons.bell,
                            color: Colors.black,
                          ),
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
            if (_showBarrier)
              AnimatedModalBarrier(
                color: _barrierAnimation,
                dismissible: true,
                onDismiss: _toggleAnimations,
              ),
            SlideTransition(
              position: _panelAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Sizes.size5),
                    bottomRight: Radius.circular(Sizes.size5),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var tab in _tabs)
                      ListTile(
                        title: Row(
                          children: [
                            FaIcon(
                              tab["icon"],
                              color: Colors.black,
                              size: Sizes.size16,
                            ),
                            Gaps.h20,
                            Text(
                              tab["title"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
