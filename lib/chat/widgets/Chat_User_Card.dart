import 'package:cached_network_image/cached_network_image.dart';
import 'package:ds304/chat/Chat_Screen.dart';
import 'package:ds304/helpers/Profile_Dialog.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/helpers/my_date_util.dart';
import 'package:ds304/models/chat_user.dart';
import 'package:ds304/models/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  //last message info (if null --> no message)
  Message? _message;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(user: widget.user),
          ),
        );
      },
      splashColor: Color.fromARGB(255, 111, 196, 235), // Hover color
      borderRadius: BorderRadius.circular(15),
      child: StreamBuilder(
        stream: APIs.getLastMessage(widget.user),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
          if (list.isNotEmpty) _message = list[0];

          return Container(
            margin:
                EdgeInsets.symmetric(horizontal: mq.width * .015, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 2.2,
                  blurRadius: 4,
                ),
              ],
            ),
            child: ListTile(
              leading: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => ProfileDialog(user: widget.user),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(mq.height * .03),
                  child: CachedNetworkImage(
                    width: mq.height * .055,
                    height: mq.height * .055,
                    imageUrl: widget.user.image,
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(child: Icon(CupertinoIcons.person)),
                  ),
                ),
              ),
              title: Text(
                widget.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: 'Lato',
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                _message != null
                    ? _message!.type == Type.image
                        ? 'image'
                        : _message!.msg
                    : widget.user.about,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  fontFamily: 'Lato',
                ),
              ),
              trailing: _message == null
                  ? null
                  : _message!.read.isEmpty && _message!.fromId != APIs.user.uid
                      ? Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      : Text(
                          MyDateUtil.getLastMessageTime(
                            context: context,
                            time: _message!.sent,
                          ),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }
}
