import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/messages/GDs/GD.dart';
import 'package:ds304/pages/message.dart';
import 'package:ds304/pages/notification.dart';
import 'package:ds304/user/more.dart';
import 'package:ds304/widget/circle_button.dart';
import 'package:ds304/widget/create_post_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alumni Connect"),
        actions: [
          CircleButton(
              icon: MdiIcons.bell,
              iconSize: 30.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: [
          CreatePostContainer(url: ""),
          Expanded(
            child: FutureBuilder(
              future: Future.value(FirebaseAuth.instance.currentUser),
              builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('feed')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (ctx, feedSnapshot) {
                    if (feedSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final feedDocs = feedSnapshot.data!.docs;

                    return ListView.builder(
                      reverse: true,
                      itemCount: feedDocs.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          height: 500,
                          color: Colors.grey,
                          ///////////////////////////////////////// Individual Feed item Modify this /////////////////////////////////
                          child: Column(
                            children: [
                              Text(feedDocs[index]['caption']),
                              Text(feedDocs[index]['userId']),
                              Image.network(feedDocs[index]['imageUrl']),
                            ],
                          ),
                        );
                        ////////////////////////////////////////////
                      },
                    );
                  },
                );
              },
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
                        builder: (context) => Members(),
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
                        builder: (context) => Message(),
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
