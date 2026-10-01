import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatsDetailScreen extends StatefulWidget {
  const ChatsDetailScreen({super.key});

  @override
  State<ChatsDetailScreen> createState() => _ChatsDetailScreenState();
}

class _ChatsDetailScreenState extends State<ChatsDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> messageLog = [];

  void _onMassageSendTap() {
    setState(() {
      messageLog.add(_textEditingController.value.text);
    });
    _textEditingController.clear();
  }

  void _onBackgroundTap() {
    FocusScope.of(context).unfocus();
  }

  void _onMessageLongPressEnd(int index) {
    Clipboard.setData(ClipboardData(text: messageLog[index]));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget buildMessage({
    required BuildContext context,
    required int index,
    required String text,
    required bool isMine,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMine
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: () => _onMessageLongPressEnd(index),
          child: Container(
            padding: EdgeInsets.all(Sizes.size14),
            decoration: BoxDecoration(
              color: isMine ? Colors.blue : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Sizes.size20),
                topRight: Radius.circular(Sizes.size20),
                bottomLeft: Radius.circular(
                  isMine ? Sizes.size20 : Sizes.size5,
                ),
                bottomRight: Radius.circular(
                  isMine ? Sizes.size5 : Sizes.size20,
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: Sizes.size16),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              CircleAvatar(
                radius: Sizes.size24,
                backgroundColor: Color.fromARGB(234, 233, 200, 247),
                child: Text("부키", style: TextStyle(fontSize: Sizes.size14)),
              ),
              Positioned(
                bottom: -3,
                right: 0,
                child: Container(
                  width: Sizes.size18,
                  height: Sizes.size18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(color: Colors.white, width: Sizes.size3),
                  ),
                ),
              ),
            ],
          ),
          title: Text("부키", style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onBackgroundTap,
            child: ListView.separated(
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: messageLog.length,
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = true;
                if (messageLog.isNotEmpty) {
                  return buildMessage(
                    context: context,
                    text: messageLog[index],
                    index: index,
                    isMine: isMine,
                  );
                }
                return Container();
              },
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Sizes.size20),
                          topRight: Radius.circular(Sizes.size20),
                          bottomLeft: Radius.circular(Sizes.size20),
                          bottomRight: Radius.circular(Sizes.size5),
                        ),
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white,
                          suffix: FaIcon(FontAwesomeIcons.faceSmile),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h12,
                  GestureDetector(
                    onTap: _onMassageSendTap,
                    child: Container(
                      width: Sizes.size36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.solidPaperPlane,
                          color: Colors.white,
                          size: Sizes.size18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 하단부 bottomAppBar 마저 작성하기(코드 챌린지)
