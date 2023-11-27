import 'package:ds304/pages/chat.dart';
import 'package:ds304/screens/blog_screen.dart';
import 'package:ds304/screens/details.dart';
import 'package:ds304/screens/profile_page.dart';
import 'package:ds304/screens/profile_screen.dart';
import 'package:ds304/screens/setting_screen.dart';
import 'package:ds304/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:ds304/widgets/search.dart';

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
              height: 280,
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
                            builder: (context) => const DetailsScreen(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      icon: Icons.emoji_events,
                      title: 'My Achievements',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailsScreen(),
                          ),
                        );
                      },
                    ),
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
                    CustomCard(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
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
              height: 150,
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
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                    ),
                    CustomCard(
                      icon: Icons.alt_route_sharp,
                      title: 'Activity',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailsScreen(),
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

  Widget video(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 8.0, top: 8.0),
            child: Text(
              "VIDEOs",
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
                      icon: Icons.videocam_outlined,
                      title: 'Promo Videos',
                      onTap: () {
                        // Navigate to a new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profile(
                              title: 'Profile',
                            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Button
            const SearchWidget(),
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
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://www.pngkey.com/png/detail/52-523516_empty-profile-picture-circle.png'),
                      ),
                      title: const Text('John Doe'),
                      subtitle: const Text('Info'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Navigate to a new screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
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
            video(context),
          ],
        ),
      ),
    );
  }
}
