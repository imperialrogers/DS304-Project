import 'package:ds304/Profile_Screen.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/messages/GDs/GD.dart';
import 'package:ds304/pages/chat.dart';
import 'package:ds304/pages/notification.dart';
import 'package:ds304/screens/setting_screen.dart';
import 'package:ds304/user/BlogScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ds304/widgets/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  void _showAimsOptions(BuildContext context) {
    String videoCallAppUrl = "https://aims.iiitdwd.ac.in/aims/";

    launch(videoCallAppUrl);
  }

  void _showWebsiteOptions(BuildContext context) {
    String videoCallAppUrl = "https://iiitdwd.ac.in/";

    launch(videoCallAppUrl);
  }

  void _showAcademicsOptions(BuildContext context) {
    String videoCallAppUrl = "https://iiitdwd.ac.in/academics.php";

    launch(videoCallAppUrl);
  }

  Widget personal(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    CustomCard(
                      icon: Icons.person_outlined,
                      title: 'Members',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Members(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      icon: Icons.movie_edit,
                      title: 'Blog',
                      onTap: () {
                        // Handle card 3 tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BlogScreen(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      icon: MdiIcons.webSync,
                      title: 'Institute Website',
                      onTap: () {
                        // Handle card 3 tap
                        _showWebsiteOptions(context);
                      },
                    ),
                    CustomCard(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        // Handle card 3 tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      icon: MdiIcons.accountHardHat,
                      title: 'AIMS Portal',
                      onTap: () {
                        _showAimsOptions(context);
                      },
                    ),
                    CustomCard(
                      icon: MdiIcons.webSync,
                      title: 'Academics Details',
                      onTap: () {
                        _showAcademicsOptions(context);
                      },
                    ),
                    CustomCard(
                      icon: Icons.notifications_active_outlined,
                      title: 'Terms and Conditions',
                      onTap: () {},
                    ),
                    CustomCard(
                      icon: Icons.insert_drive_file_outlined,
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                    CustomCard(
                      icon: MdiIcons.logout,
                      title: 'Sign Out',
                      onTap: () {
                        FirebaseAuth.instance.signOut();
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
      backgroundColor: const Color.fromARGB(255, 247, 241, 241),
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
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
                      title: const Text('Profile'),
                      subtitle: const Text('View, update and Modify'),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
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
          ],
        ),
      ),
    );
  }
}
