import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/widget/profile_avatar.dart';
import 'package:ds304/widget/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

//Get User Image
class CreatePostContainer extends StatefulWidget {
  final String url;
  const CreatePostContainer({Key? key, required this.url}) : super(key: key);

  @override
  State<CreatePostContainer> createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  String? selectedImagePath;
  Future<void> _openGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // Process the selected image as needed
    if (image != null) {
      // Handle the selected image
      print('Selected Image Path: ${image.path}');
      setState(() {
        selectedImagePath = image.path;
      });
    }
  }

  void _clearSelectedImage() {
    setState(() {
      selectedImagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(100, 0, 0, 0), // Shadow color
              spreadRadius: 1.0,
              blurRadius: 5.0,
              offset: Offset(0, 3), // Changes the shadow position
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileAvatar(imageUrl: widget.url),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8),
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'What\'s on your mind?',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                  ],
                ))
              ],
            ),
            const Divider(
              height: 10.0,
              thickness: 0.5,
            ),
            if (selectedImagePath != null)
              Container(
                height: 100.0, // Adjust the height as needed
                width: 200.0, // Adjust the width as needed
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    Image.file(
                      File(selectedImagePath!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    Positioned(
                      top: 1.0,
                      right: 1.0,
                      child: Container(
                        width: 40.0, // Width of the circular container
                        height: 40.0, // Height of the circular container
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black54),
                          onPressed: _clearSelectedImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _openGallery(context);
                      },
                      icon: const Icon(
                        Icons.photo_library,
                        color: Color.fromARGB(255, 6, 101, 178),
                      ),
                      label: const Text(
                        'Photo/Video',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const VerticalDivider(width: 8.0),
                    TextButton.icon(
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty ||
                            selectedImagePath != null) {
                          FirebaseFirestore.instance.collection('feed').add({
                            'caption': textEditingController.text,
                            'image_url': widget.url,
                            'time': Timestamp.now(),
                            'userId': FirebaseAuth.instance.currentUser!.uid,
                            'likes': 0,
                            'shares': 0,
                          });
                          textEditingController.clear();
                          _clearSelectedImage();
                        }
                      },
                      icon: const Icon(
                        Icons.post_add,
                        color: Color.fromARGB(255, 6, 101, 178),
                      ),
                      label: const Text(
                        'Upload Post',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
