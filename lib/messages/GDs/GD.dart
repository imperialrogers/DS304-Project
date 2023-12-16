// import 'package:ds304/messages/GDs/GroupList.dart';
// import 'package:ds304/messages/GDs/add_GD.dart';
// import 'package:flutter/material.dart';

// class Members extends StatelessWidget {
//   const Members({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Colors.blue[400]!,
//                 Colors.blue[800]!,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         title: const Text(
//           'Group Discussions',
//           style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'Lato'),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 2,
//       ),
//       body: const GroupList(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromARGB(255, 15, 95, 234),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const GDInputScreen(),
//             ),
//           );
//         },
//         child: const Icon(Icons.add, color: Colors.white),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/chat/Member_List.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/messages/GDs/GroupList.dart';
import 'package:ds304/messages/GDs/add_GD.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  State<Members> createState() => _MessageState();
}

class _MessageState extends State<Members> {
  String selectedCategory = 'All Chats';
  //
  final TextEditingController titleController = TextEditingController();
  String? imageUrl;

  bool isImageExpanded = false;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }

  uploadImage() async {
    // getting image file extension
    if (imageUrl == null || imageUrl == "") return;
    File file = File(imageUrl!);
    final ext = file.path.split('.').last;

    // storage file ref with path
    final ref = FirebaseStorage.instance.ref().child(
        'images/${APIs.me.id}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    // updating image in firestore database
    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('group-chats').add({
      'display_image': url,
      'userId': APIs.me.id,
      'group_name': titleController.text,
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      cursorColor: const Color.fromARGB(255, 15, 95, 234),
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Group Name',
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 15, 95, 234),
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            if (imageUrl != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: PhotoView(
                                  imageProvider:
                                      Image.file(File(imageUrl!)).image,
                                ),
                              ),
                            if (imageUrl == null)
                              const Center(
                                child: Icon(
                                  Icons.upload_file,
                                  size: 70,
                                  color: Colors.black54,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          uploadImage();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(206, 15, 95, 234),
                        ),
                        child: const Text('Create New Group Discussion',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 4.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [], // Remove the shadow
          ),
          padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0), // Adjust the padding to move the title down
          child: AppBar(
            title: const Text(
              'Group Discussion',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: const Color(0xffFFFFFF),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Implement your search functionality here
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryBox(
                text: 'All',
                selected: selectedCategory == 'All Chats',
                onPressed: () {
                  setState(() {
                    selectedCategory = 'All Chats';
                  });
                },
              ),
              CategoryBox(
                text: 'Tech',
                selected: selectedCategory == '2020',
                onPressed: () {
                  setState(() {
                    selectedCategory = '2020';
                  });
                },
              ),
              CategoryBox(
                text: 'NonTech',
                selected: selectedCategory == '2021',
                onPressed: () {
                  setState(() {
                    selectedCategory = '2021';
                  });
                },
              ),
              CategoryBox(
                text: 'Placements',
                selected: selectedCategory == '2022',
                onPressed: () {
                  setState(() {
                    selectedCategory = '2022';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 7),
          // Display MemberList based on the selected category
          Expanded(
            child: GroupList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 15, 95, 234),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GDInputScreen(),
            ),
          );
        },
        child: const Icon(Icons.add_box_rounded, color: Colors.white),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onPressed;

  const CategoryBox({
    required this.text,
    this.selected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: selected
              ? Colors.blue
              : Colors.grey[200], // Use blue color for 'All Chats'
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black, // Text color
          ),
        ),
      ),
    );
  }
}
