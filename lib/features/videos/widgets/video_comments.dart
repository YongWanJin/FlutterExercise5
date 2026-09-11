import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const new({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  /// 입력 창 이외의 부분을 탭하면 화면에 표시된 키보드가 사라지는 기능
  void _onBodyTap() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          automaticallyImplyLeading: false,
          title: Text("22765 comments"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _onBodyTap,
          child: Stack(
            children: [
              ListView.separated(
                padding: EdgeInsets.only(
                  right: Sizes.size16,
                  left: Sizes.size16,
                  top: Sizes.size24,
                  bottom:
                      Sizes.size96 + Sizes.size20, // 입력창이 맨 마지막 댓글을 덮는 현상 방지
                ),
                separatorBuilder: (context, index) => Gaps.v20,
                itemCount: 10,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(radius: 18, child: Text("용완")),
                    Gaps.h10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '용완',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizes.size14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Gaps.v3,
                          Text(
                            "이것은 댓글입니다.이것은 댓글입니다.이것은 댓글입니다.이것은 댓글입니다.이것은 댓글입니다.",
                          ),
                        ],
                      ),
                    ),
                    Gaps.h10,
                    Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size20,
                          color: Colors.grey.shade500,
                        ),
                        Gaps.v2,
                        Text(
                          "52.2K",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.size6,
                      right: Sizes.size10,
                      bottom: Sizes.size10,
                      top: Sizes.size5,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          child: Text("용완"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: TextField(
                            onTap: _onStartWriting,
                            cursorColor: Theme.of(context).primaryColor,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              hintText: "Wirte a comment ...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: Sizes.size12,
                                vertical: Sizes.size6,
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsetsGeometry.only(
                                  right: Sizes.size14,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    if (_isWriting)
                                      GestureDetector(
                                        onTap: _onBodyTap, // 임시
                                        child: FaIcon(
                                          FontAwesomeIcons.circleArrowUp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
