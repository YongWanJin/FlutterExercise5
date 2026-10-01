import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chats_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  // 변수 _key는 어떤 위젯 트리에서도 위젯 AnimatedList의 상태(State)에 접근할 수 있게 해준다.
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];
  final Duration _duration = Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      // 위젯 AnimatedList의 상태(State)의 _items.length번째 인덱스에 임의의 데이터를 저장하고,
      // 해당 인덱스와 관련된 itembuilder를 호출해서 애니메이션과 함께 랜더링한다.
      _key.currentState!.insertItem(_items.length, duration: _duration);
      _items.add(_items.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(color: Colors.red, child: _makeTile(index)),
        ),
        duration: _duration,
      );
    }
    _items.removeAt(index);
  }

  void _onChatTap() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ChatsDetailScreen()));
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: _onChatTap,
      leading: CircleAvatar(radius: 30, child: Text("부키")),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            // 이때 출력되는 index는 현재 AnimatedList이 참조중인 위치의 index이다.
            // (_items에 저장된 데이터를 출력하는 것이 아님!)
            "Tenko Shibuki ($index)",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text("02:41 PM", style: TextStyle(fontSize: Sizes.size12)),
        ],
      ),
      subtitle: Text("Don't forget to make video"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct messages"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        actions: [
          IconButton(onPressed: _addItem, icon: FaIcon(FontAwesomeIcons.plus)),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: EdgeInsets.symmetric(vertical: Sizes.size10),
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
              return FadeTransition(
                key: UniqueKey(),
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: _makeTile(index),
                ),
              );
            },
      ),
    );
  }
}
