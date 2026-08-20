import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/new_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  /// 화면 드래그 동작 감지
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  /// 화면에서 손을 때는 순간 감지
  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterTap() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: AnimatedCrossFade(
            firstChild: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v80,
                      Text(
                        "Watch cool videos!",
                        style: TextStyle(
                          fontSize: Sizes.size40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v16,
                      Text(
                        "Videos are personalized for you based on what you watch, like, and share.",
                        style: TextStyle(fontSize: Sizes.size20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            secondChild: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v80,
                      Text(
                        "Follow the rules.",
                        style: TextStyle(
                          fontSize: Sizes.size40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gaps.v16,
                      Text(
                        "Take care of one another! Pliease!",
                        style: TextStyle(fontSize: Sizes.size20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: _showingPage == Page.first
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 300),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          height: 100,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: Sizes.size16,
              top: Sizes.size8,
              left: Sizes.size24,
              right: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _showingPage == Page.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: _onEnterTap,
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Enter the app!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
