import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping", "Brands"];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

// 코드챌린지1 : 탭 넘어갈 때 키보드 자동으로 내리기(addListener, setState...)
// 코드챌린지2 : 검색창 cupertino 안쓰고 직접 구현하기

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;
  bool _isWriting = false;

  void _clickAnotherTab() {
    if (_tabController.indexIsChanging) {
      FocusScope.of(context).unfocus();
    }
  }

  void _onClearTap() {
    _textEditingController.clear();
    setState(() {
      _isWriting = false;
    });
  }

  void _onSubmitted(String value) {
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onChanged(String value) {
    setState(() {
      _isWriting = true;
    });
  }

  void _onImageTap() {
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_clickAnotherTab);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: _textEditingController,
                onSubmitted: _onSubmitted,
                onChanged: _onChanged,
                decoration: InputDecoration(
                  hintText: "Search",
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  contentPadding: EdgeInsets.only(top: Sizes.size4),
                  focusedBorder: InputBorder.none,
                  prefixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: Sizes.size20,
                      ),
                    ],
                  ),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size6),
                        child: GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            splashFactory: NoSplash.splashFactory,
            padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
            isScrollable: true,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [for (var tab in tabs) Tab(child: Text(tab))],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size10,
                vertical: Sizes.size10,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size20,
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size14),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: GestureDetector(
                        onTap: _onImageTap,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/1.PNG",
                          image: "https://images.unsplash.com/photo-1626808642875-0aa545482dfb?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                      ),
                    ),
                  ),
                  Gaps.v10,
                  Text(
                    "이것은 내가 업로드한 사진입니다. 아주아주 아름다운 사진입니다. 나는 이 사진에 대해 더 설명하고 싶습니다.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v2,
                  DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(
                            "assets/images/myFace.PNG",
                          ),
                        ),
                        Gaps.h4,
                        Expanded(
                          child: Text(
                            "My Nick Name is very Long",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.grey.shade600,
                          size: Sizes.size16,
                        ),
                        Gaps.h2,
                        Text("2.5M"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            for (var tab in tabs.skip(1)) Center(child: Text(tab)),
          ],
        ),
      ),
    );
  }
}
