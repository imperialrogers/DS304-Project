import 'package:ds304/chat/Member_List.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MemberList(),
    );
  }
}


/*

SizedBox(
              height: 120,
              child: Card(
                margin: const EdgeInsets.all(12.0),
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
                          leading: const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://www.pngkey.com/png/detail/52-523516_empty-profile-picture-circle.png'),
                          ),
                          title: Text("Rohit Chaudhari"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              ),
                            );
                            // Add any functionality when tapping the card
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

*/