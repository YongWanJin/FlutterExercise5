import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final int _itemCount = 5;

  final PageController _pageController = PageController();
  final Duration scrollDuration = const Duration(milliseconds: 150);
  final Curve scrollCurves = Curves.linear;

  // List<Color> colors = [Colors.blue, Colors.red, Colors.yellow, Colors.teal];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: scrollDuration,
      curve: scrollCurves,
    );
    // if (page == _itemCount - 1) {
    //   _itemCount = _itemCount + 4;
    //   colors.addAll([Colors.blue, Colors.red, Colors.yellow, Colors.teal]);
    setState(() {});
    // }
  }

  void _onVideoFinished() {
    _pageController.nextPage(duration: scrollDuration, curve: scrollCurves);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      pageSnapping: true,
      scrollDirection: Axis.vertical,
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished),
    );
  }
}
