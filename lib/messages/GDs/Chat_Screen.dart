import 'package:flutter/material.dart';
import 'messages.dart';
import 'new_messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Lato')),
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
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      backgroundColor: Colors.grey[50],
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
