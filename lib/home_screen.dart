import 'dart:async';
import 'package:ds304/constants.dart';
import 'package:ds304/message_list_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/user-list-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Initial Variables
  bool _isLoading = false;
  var listening;
  var listeningM;
  TextEditingController _searchController = TextEditingController();

  ///Screen UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Blogs",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  //SEARCH BAR

                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.add_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 10.0,
              ),
              child: TextFormField(
                controller: _searchController,
                onFieldSubmitted: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 230, 230, 230),
                  hintText: "Search User",
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 79, 79, 79)),
                  labelText: 'Search User',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 133, 133, 133)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color.fromARGB(255, 133, 133, 133),
                  ),
                ),
              ),
            ),
            Expanded(
              /// If messages are loading, show CircularIndicator else list messages
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  :
                  // : StreamBuilder(
                  //     stream: widget.client.streamConversations(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return ListView.builder(
                  //           shrinkWrap: true,
                  //           itemCount: messages.length,
                  //           itemBuilder: (context, index) {
                  //             return MessageListItem(
                  //               message: messages[index],
                  //               client: widget.client,
                  //             );
                  //           },
                  //         );
                  //       }
                  //       if (snapshot.data != null) {}

                  //       return ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: messages.length,
                  //         itemBuilder: (context, index) {
                  //           return MessageListItem(
                  //             message: messages[index],
                  //             client: widget.client,
                  //           );
                  //         },
                  //       );
                  //     },
                  //   ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageListItem(
                          message: messages[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  ///Load All Conversations
  Future<void> setMessages() async {}
}
