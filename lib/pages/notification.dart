import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Notifications',
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
        toolbarHeight: 65,
      ),
      body: ListView.builder(
        itemCount: 5, // replace with actual notification count
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {},
            key: Key("$index"),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              // background color when swiping to delete
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.all(0), // Adjust card margin
              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(8), // Adjust content padding
                leading: const CircleAvatar(
                  // Add a user profile image or notification icon
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'Notification Title $index',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Notification Message $index',
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: const Text(
                  '3d ago',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
