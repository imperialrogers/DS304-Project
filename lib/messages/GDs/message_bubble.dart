import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
    this.message,
    this.isMe,
    this.userName, {
    required this.key,
  });

  // ignore: prefer_typing_uninitialized_variables
  final message;
  final String userName;
  final isMe;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.blue[400]
                    : Colors.grey[500]!.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 160,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
