import 'package:ds304/constants.dart';
import 'package:ds304/member_list_item.dart';
import 'package:ds304/message_list_item.dart';
import 'package:ds304/search_widget.dart';
import 'package:flutter/material.dart';

class MembersScreen extends StatefulWidget {
  static const routeName = "/user-list-screen";
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  ///Initial Variables
  bool _isLoading = false;

  TextEditingController _searchController = TextEditingController();

  ///Init
  @override
  void initState() {
    super.initState();
  }

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
                    "Members List",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 230, 230, 230),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //SEARCH BAR
            SearchWidget(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownMenu(
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 1, label: "Alphabetical"),
                      DropdownMenuEntry(value: 2, label: "Recent Passout"),
                      DropdownMenuEntry(value: 3, label: "Oldest Passout"),
                    ],
                    hintText: "Sort By",
                    label: Text("Sort By"),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownMenu(
                    enableSearch: true,
                    menuHeight: 30,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 1, label: "All"),
                      DropdownMenuEntry(value: 2, label: "Students"),
                      DropdownMenuEntry(value: 3, label: "Faculty"),
                    ],
                    hintText: "All",
                    label: Text("Filter By"),
                  ),
                ),
              ],
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
                      itemCount: membersList.length,
                      itemBuilder: (context, index) {
                        return UserListItem(
                          userName: membersList[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
