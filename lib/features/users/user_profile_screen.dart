import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/counting.dart';
import 'package:tiktok_clone/features/users/widgets/persistant_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, index) {
            return [
              SliverAppBar(
                title: Text("Yongwan"),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: FaIcon(FontAwesomeIcons.bell),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.size16),
                    child: FaIcon(FontAwesomeIcons.ellipsis),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Gaps.v5,
                    CircleAvatar(
                      radius: Sizes.size52,
                      backgroundImage: AssetImage("assets/images/myFace.PNG"),
                    ),
                    Gaps.v10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "@YongwanJin",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.blue,
                          size: Sizes.size16,
                        ),
                      ],
                    ),
                    Gaps.v16,
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Counting(number: "37", category: "Following"),
                          VerticalDivider(
                            width: Sizes.size28,
                            thickness: Sizes.size1,
                            indent: Sizes.size10,
                            endIndent: Sizes.size10,
                            color: Colors.grey.shade200,
                          ),
                          Counting(number: "10.5M", category: "Followers"),
                          VerticalDivider(
                            width: Sizes.size28,
                            thickness: Sizes.size1,
                            indent: Sizes.size10,
                            endIndent: Sizes.size10,
                            color: Colors.grey.shade200,
                          ),
                          Counting(number: "149.3M", category: "Likes"),
                        ],
                      ),
                    ),
                    Gaps.v8,
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(
                                  Sizes.size4,
                                ),
                              ),
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: Sizes.size16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Gaps.h3,
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(
                                  Sizes.size4,
                                ),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.youtube,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Gaps.h3,
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(
                                  Sizes.size4,
                                ),
                              ),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.squareCaretDown,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v10,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                      child: Text(
                        "Watch my cool and beautiful videos! Watch my cool and beautiful videos! Watch my cool and beautiful videos!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.link, size: Sizes.size12),
                        Gaps.h4,
                        Text(
                          "https://myHomepage.com",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistantTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 14,
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 14,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: "assets/images/1.PNG",
                              image: "https://images.unsplash.com/photo-1626808642875-0aa545482dfb?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            left: 5,
                            child: Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.play,
                                  color: Colors.white,
                                  size: Sizes.size16,
                                ),
                                Gaps.h4,
                                Text(
                                  "4.1M",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(child: Text("page 2")),
            ],
          ),
        ),
      ),
    );
  }
}
