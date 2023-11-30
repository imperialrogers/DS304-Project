import 'package:ds304/pages/members.dart';
import 'package:ds304/pages/message.dart';
import 'package:ds304/pages/notification.dart';
import 'package:ds304/screens/more.dart';
import 'package:ds304/widget/circle_button.dart';
import 'package:ds304/widget/create_post_container.dart';
import 'package:ds304/widget/data.dart';
import 'package:ds304/widget/post_container.dart';
import 'package:ds304/widget/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Alumni Connect',
              style: TextStyle(
                  color: Color.fromARGB(255, 74, 93, 117),
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2),
            ),
            centerTitle: false,
            floating: true,
            //ACTIONS -> adiciona os ícones a direita  do titulo
            actions: [
              CircleButton(
                  icon: Icons.search, iconSize: 30.0, onPressed: () => {}),
              CircleButton(
                  icon: MdiIcons.bell,
                  iconSize: 30.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  }),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          const SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: currentUser)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final Post post = posts[index];
                return PostContainer(post: post);
              },
              childCount: posts.length,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Members',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Members(),
                      ),
                    );
                  },
                ),
                GButton(
                  icon: MdiIcons.chat,
                  text: 'Messages',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Message(),
                      ),
                    );
                  },
                ),
                GButton(
                  icon: MdiIcons.notificationClearAll,
                  text: 'More',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoreScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
