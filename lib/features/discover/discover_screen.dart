import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping", "Brands"];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Discover"),
          bottom: TabBar(
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
                  AspectRatio(
                    aspectRatio: 9 / 16,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: "assets/images/1.PNG",
                      image: "https://images.unsplash.com/photo-1626808642875-0aa545482dfb?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
