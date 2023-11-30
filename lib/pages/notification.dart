import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            'Notifications',
            style: TextStyle(
                color: Color.fromARGB(200, 50, 53, 51),
                fontWeight: FontWeight.bold,
                fontSize: 19),
          ),
        ),
        toolbarHeight: 55,
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      body: ListView.builder(
        itemCount: 5, // replace with actual notification count
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {},
            key: const Key(""),
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
            child: Container(
              padding: const EdgeInsets.all(5),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(70)),
              child: Card(
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'Notification Title $index', // replace with actual notification title
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Notification Message $index', // replace with actual notification message
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Text(
                    '3d ago', // replace with actual timestamp
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () {
                    // TODO: Implement notification tap logic
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
