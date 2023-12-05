import 'package:ds304/helpers/apis.dart';
import 'package:ds304/messages/GDs/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting)
          // ignore: curly_braces_in_flow_control_structures
          return const Center(
            child: CircularProgressIndicator(),
          );

        return StreamBuilder(
          stream: APIs.getAllGDMessages(id),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['msg'],
                chatDocs[index]['fromId'] == futureSnapshot.data!.uid,
                chatDocs[index]['username'],
                key: ValueKey(
                  chatDocs[index].id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
