import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/body_text.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
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
      VideoPlayerController.asset("assets/videos/e.mp4");

  bool _isPaused = false;
  bool _isMuted = false;

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
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      setState(() {
        _isMuted = true;
      });
    }
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _onVolumePressed() async {
    if (_isMuted) {
      setState(() {
        _isMuted = false;
      });
      await _videoPlayerController.setVolume(0.5);
    } else {
      setState(() {
        _isMuted = true;
      });
      await _videoPlayerController.setVolume(0);
    }
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
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  /// Home에서 재생될 영상이 화면에 노출되는 정도에 따라서 재생할지 말지 여부를 결정
  void _onVisibilityChanged(VisibilityInfo info) {
    // 아래로 넘긴 영상이 화면에 100% 노출되었을 때에만 재생
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    // bottom navigation tap에서 다른 탭으로 넘어갈 때에는 중지
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
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

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) => VideoComments(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
    _onTogglePause();
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
          Positioned(
            bottom: 30,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@yongwan_Jin",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "물장구 치는 딸래미",
                  style: TextStyle(fontSize: Sizes.size16, color: Colors.white),
                ),
                Gaps.v6,
                BodyText(
                  text: "#AI생성 #모비노기 수영장에서 물장구를 치는 우리집 딸래미가 너무너무 귀엽다. 정말로 한가해 보인다. 옆자리에 마실 것을 가져다 주고 싶다.",
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                IconButton(
                  onPressed: _onVolumePressed,
                  icon: FaIcon(
                    _isMuted
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volume,
                    color: Colors.white,
                  ),
                ),
                Gaps.v16,
                CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    foregroundImage: AssetImage("assets/images/myFace.PNG"),
                  ),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                  onTap: () {},
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidComment,
                  text: "33K",
                  onTap: () => _onCommentsTap(context),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
