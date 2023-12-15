import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Chat_Screen.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('group-chats').snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapshot.data!.docs;
            return ListView.builder(
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) =>
                  //Individual Chat Card Modify this
                  SizedBox(
                height: 90,
                child: Card(
                  color: Colors.transparent,
                  margin: const EdgeInsets.all(10.0),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  chatDocs[index]['display_image']),
                            ),
                            title: Text(chatDocs[index]['group_name'],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Lato')),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                    title: chatDocs[index]['group_name'],
                                    id: chatDocs[index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Card ends here
            );
          },
        );
      },
    );
  }
}
