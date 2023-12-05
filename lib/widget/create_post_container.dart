import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/widget/profile_avatar.dart';
import 'package:ds304/widget/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Get User Image
class CreatePostContainer extends StatelessWidget {
  final String url;
  const CreatePostContainer({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = "https://images.unsplash.com/photo-1525253086316-d0c936c814f8";
    TextEditingController textEditingController = TextEditingController();
    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: TextField(
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                    hintText: 'What\'s on your mind?'),
              ))
            ],
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () => print('Add Photos'),
                  icon: const Icon(
                    Icons.photo_library,
                    color: Colors.green,
                  ),
                  label: const Text(
                    'Add Photos',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    if (textEditingController.text.isNotEmpty) {
                      FirebaseFirestore.instance.collection('feed').add({
                        'caption': textEditingController.text,
                        'image_url': url,
                        'time': Timestamp.now(),
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'likes': 0,
                        'shares': 0,
                      });
                      textEditingController.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.photo_library,
                    color: Colors.green,
                  ),
                  label: const Text(
                    'Post',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
