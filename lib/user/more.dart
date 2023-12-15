import 'package:ds304/Profile_Screen.dart';
import 'package:ds304/auth/onBoard.dart';
import 'package:ds304/dialogs.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/pages/chat.dart';
import 'package:ds304/pages/homescreen.dart';
import 'package:ds304/pages/notification.dart';
import 'package:ds304/user/BlogScreen.dart';
import 'package:ds304/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  Widget personal(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 8.0),
            child: Text(
              "PERSONAL",
              style: TextStyle(
                color: Color.fromARGB(255, 99, 98, 98),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              height: 160,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    CustomCard(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    CustomCard(
                      icon: Icons.message,
                      title: 'Messages',
                      onTap: () {
                        // Handle card 3 tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget community(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 8.0),
            child: Text(
              "COMMUNITY",
              style: TextStyle(
                color: Color.fromARGB(255, 99, 98, 98),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              height: 158,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    CustomCard(
                      icon: Icons.article_rounded,
                      title: 'Blog',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    CustomCard(
                      icon: Icons.alt_route_sharp,
                      title: 'Activity',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget logout(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 8.0),
            child: Text(
              "OTHERS",
              style: TextStyle(
                color: Color.fromARGB(255, 99, 98, 98),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              height: 90,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                child: Column(
                  children: [
                    CustomCard(
                      icon: MdiIcons.logout,
                      title: 'Sign Out',
                      onTap: () async {
                        //for showing progress dialog
                        Dialogs.showProgressBar(context);

                        await APIs.updateActiveStatus(false);

                        //sign out from app
                        await APIs.auth.signOut().then((value) async {
                          await GoogleSignIn().signOut().then((value) {
                            //for hiding progress dialog
                            Navigator.pop(context);

                            //for moving to home screen
                            Navigator.pop(context);

                            APIs.auth = FirebaseAuth.instance;

                            //replacing home screen with login screen
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const onBoard()));
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[400]!,
                Colors.blue[800]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card
            SizedBox(
              height: 120,
              child: Card(
                margin: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ListTile(
                      title: const Text('MY BIO'),
                      subtitle: const Text('View, update and Modify'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Navigate to a new screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProfileScreen(user: APIs.me),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            personal(context),
            const SizedBox(
              height: 18,
            ),
            community(context),
            const SizedBox(
              height: 18,
            ),
            logout(context)
          ],
        ),
      ),
    );
  }
}
