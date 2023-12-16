import 'package:flutter/material.dart';
import 'messages.dart';
import 'new_messages.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final String id;

  Future<void> _openContactList(BuildContext context) async {
    // Example: Open the dialer without a specific phone number
    String url = 'tel:';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 238, 238),
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lato')),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.call,
              color: Colors.black54,
            ),
            onPressed: () {
              _openContactList(context);
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black54,
            ),
            onPressed: () {
              // Add your functionality for the three dots button here
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(233, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: Messages(
              id: id,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NewMessage(chatId: id),
          ),
        ],
      ),
    );
  }
}
