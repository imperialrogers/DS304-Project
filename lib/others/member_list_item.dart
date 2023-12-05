import 'package:flutter/material.dart';

/// Individual List Item's UI
class UserListItem extends StatelessWidget {
  UserListItem({
    Key? key,
    this.userName,
  }) : super();
  final userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      //Image of sender
      child: ListTile(
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ),
        title: Text(
          userName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        horizontalTitleGap: 8,
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            "2023 Passout.",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: Color.fromARGB(255, 83, 83, 83), decorationThickness: 1),
          ),
        ),
        onTap: () async {},
      ),
    );
  }
}
