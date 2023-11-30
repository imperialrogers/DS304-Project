import 'package:flutter/material.dart';

/// Individual List Item's UI
class MessageListItem extends StatelessWidget {
  MessageListItem({Key? key, required String message}) : super();

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
        title: const Text(
          "SENDER",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        horizontalTitleGap: 8,
        //Date
        trailing: Text(
          DateTime.now().toString().substring(0, 10),
          style: const TextStyle(
            color: Color.fromARGB(255, 152, 151, 151),
          ),
        ),
        subtitle: const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            "Messages that are sent and received will be shown here.",
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
