import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin : 애니메이션 효과가 적용된 위젯이 화면에 등장하거나
  // 그 위젯의 애니메이션이 재생될 때에만
  // ticker (매 프레임마다 신호를 주는 장치)를 활성화시키는 기능을 담은 Mixin.
  // AnimationController를 여러개 쓴다면 TickerProvicderStateMixin을 사용하면 된다.

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/a.mp4");

  bool _isPaused = false;

  late final AnimationController _animationController;
  // Flutter의 애니메이션은 변화가 일어날때마다 화면을 다시 build하는 방식으로 구현된다.
  // _animationController.addListener()에 콜백 함수로 Setstate()를 넣거나
  // AnitaedBuilder를 사용해서 애니메이션을 실제로 적용한다.

  final Duration _animationDuration = Duration(milliseconds: 200);

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initViedoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initViedoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );

    // 이 코드는 AnimatedBuilder으로 대체함.
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  /// 영상 화면이 완전히 노출될 때 영상을 재생함
  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // upperBound를 lowerBound로 전환
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_animationController.value);
    return VisibilityDetector(
      // VisibilityDetector : 현재 시청중인 영상이 얼마나 화면에 노출되고 있는지 추적하는 위젯.
      // 'visibility_detector'라는 외부 패키지를 설치하여 사용할 수 있다.
      key: Key("${widget.index}"), // 현재 시청중인 영상
      onVisibilityChanged: _onVisibilityChanged, // 화면 노출도에 따라서 실행할 함수
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(color: Colors.black),
          ),
          Positioned.fill(child: GestureDetector(onTap: _onTogglePause)),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
