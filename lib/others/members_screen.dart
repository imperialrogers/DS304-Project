import 'package:ds304/others/constants.dart';

import '../others/member_list_item.dart';
import 'package:flutter/material.dart';

import '../widgets/search.dart';

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
            const SearchWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: (_) {},
                    hint: const Text("Sort By"),
                    alignment: AlignmentDirectional.center,
                    borderRadius: BorderRadius.circular(30),
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Alphabetical"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Recent Passout"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Oldest Passout"),
                      ),
                    ],
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    onChanged: (_) {},
                    hint: const Text("Filter By"),
                    alignment: AlignmentDirectional.center,
                    borderRadius: BorderRadius.circular(30),
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("All"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Students"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Faculty"),
                      ),
                    ],
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
