import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widegets/detail_navigation_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widegets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widegets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 3;
  bool _isSelected = false;
  LongPressStartDetails details = LongPressStartDetails();

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
        fullscreenDialog: true,
      ),
    );
  }

  void _onPosetVideoLogPresss(LongPressStartDetails details) {
    setState(() {
      _isSelected = true;
    });
  }

  void _onPosetVideoLogPresssEnd(_) {
    setState(() {
      _isSelected = false;
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Container(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 커스텀 디자인 버전 하단 바
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(offstage: _selectedIndex != 0, child: VideoTimelineScreen()),
          Offstage(offstage: _selectedIndex != 1, child: DiscoverScreen()),
          Offstage(offstage: _selectedIndex != 3, child: InboxScreen()),
          Offstage(offstage: _selectedIndex != 4, child: UserProfileScreen()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 86,
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.solidHouse,
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Discover",
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              PostVideoButton(
                isSelected: _isSelected,
                onTap: () => _onPostVideoButtonTap(),
                onLongPress: () => _onPosetVideoLogPresss(details),
                onLongPressEnd: (gesture) => _onPosetVideoLogPresssEnd(gesture),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Inbox",
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Profile",
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );

    /// Material Design 2 버전 하단 바
    // return Scaffold(
    //   body: screens[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.shifting,
    //     selectedItemColor: Theme.of(context).primaryColor,
    //     currentIndex: _selectedIndex,
    //     onTap: _onTap,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.house),
    //         label: "Home",
    //         tooltip: "press long and you can see hints.",
    //         backgroundColor: Colors.amber,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    //         label: "Search1",
    //         tooltip: "press long and you can see hints.",
    //         backgroundColor: Colors.blue,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    //         label: "Search2",
    //         tooltip: "press long and you can see hints.",
    //         backgroundColor: Colors.pink,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    //         label: "Search3",
    //         tooltip: "press long and you can see hints.",
    //         backgroundColor: Colors.white,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    //         label: "Search4",
    //         tooltip: "press long and you can see hints.",
    //         backgroundColor: Colors.green,
    //       ),
    //     ],
    //   ),
    // );
  }
}
