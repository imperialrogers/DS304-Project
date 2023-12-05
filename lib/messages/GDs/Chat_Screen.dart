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
        title: Text(title),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(
                id: id,
              ),
            ),
            NewMessage(chatId: id),
          ],
        ),
      ),
    );
  }
}
