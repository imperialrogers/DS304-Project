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
    return Column(
      children: [
        const Divider(),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.sentences,
                      enableSuggestions: true,
                      controller: _controller,
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value;
                        });
                      },
                      decoration: const InputDecoration(
                          hintText: 'Send a message...',
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: _enteredMessage.trim().isEmpty
                      ? const Color.fromARGB(255, 15, 95, 234)
                      : const Color.fromARGB(255, 49, 119, 239),
                  child: IconButton(
                    onPressed:
                        _enteredMessage.trim().isEmpty ? null : _sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
