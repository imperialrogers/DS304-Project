// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/models/gd_message.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String chatId;

  const NewMessage({
    super.key,
    required this.chatId,
  });

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    // APIs.sendGDMessage(groupID, _enteredMessage, Type.text);
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final GDMessage message = GDMessage(
      username: APIs.me.name,
      toId: widget.chatId,
      msg: _enteredMessage,
      fromId: APIs.me.id,
      sent: time,
    );

    final ref = FirebaseFirestore.instance
        .collection('group-chats/${widget.chatId}/chat/');
    await ref.add(message.toJson());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            // onPressed: null,
            icon: Icon(Icons.send),
            color: Colors.red[400],
            disabledColor: const Color.fromARGB(255, 128, 72, 72),
          )
        ],
      ),
    );
  }
}
