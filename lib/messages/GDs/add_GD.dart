// import 'dart:developer';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ds304/helpers/apis.dart';
// import 'package:ds304/messages/GDs/GD.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:photo_view/photo_view.dart';

// class GDInputScreen extends StatefulWidget {
//   const GDInputScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _GDInputScreenState createState() => _GDInputScreenState();
// }

// class _GDInputScreenState extends State<GDInputScreen> {
//   final TextEditingController titleController = TextEditingController();
//   String? imageUrl;

//   bool isImageExpanded = false;

//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         imageUrl = pickedFile.path;
//       });
//     }
//   }

//   uploadImage() async {
//     //getting image file extension
//     if (imageUrl == null || imageUrl == "") return;
//     File file = File(imageUrl!);
//     final ext = file.path.split('.').last;

//     //storage file ref with path
//     final ref = FirebaseStorage.instance.ref().child(
//         'images/${APIs.me.id}/${DateTime.now().millisecondsSinceEpoch}.$ext');

//     //uploading image
//     await ref
//         .putFile(file, SettableMetadata(contentType: 'image/$ext'))
//         .then((p0) {
//       log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
//     });

//     //updating image in firestore database
//     final url = await ref.getDownloadURL();

//     await FirebaseFirestore.instance.collection('group-chats').add({
//       'display_image': url,
//       'userId': APIs.me.id,
//       'group_name': titleController.text,
//     });
//   }

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
//           'Add New Group Discussion',
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
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 8),
//               TextFormField(
//                 cursorColor: const Color.fromARGB(255, 15, 95, 234),
//                 controller: titleController,
//                 decoration: InputDecoration(
//                   labelText: 'Group Name',
//                   labelStyle: TextStyle(
//                     color: Colors.grey[700],
//                     fontSize: 16.0,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.grey.shade400,
//                       ),
//                       borderRadius: BorderRadius.circular(16)),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 15, 95, 234),
//                       ),
//                       borderRadius: BorderRadius.circular(16)),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 16.0,
//                     horizontal: 16.0,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const SizedBox(height: 16),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200], // Container background color
//                     borderRadius: BorderRadius.circular(10), // Rounded corners
//                   ),
//                   child: Stack(
//                     children: [
//                       if (imageUrl != null)
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: PhotoView(
//                             imageProvider: Image.file(File(imageUrl!)).image,
//                           ),
//                         ),
//                       if (imageUrl == null)
//                         const Center(
//                           child: Icon(
//                             Icons.upload_file,
//                             size: 70,
//                             color: Colors.black54,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               SizedBox(
//                 height: 45,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     uploadImage();
//                     Navigator.pop(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Members(),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(206, 15, 95, 234),
//                   ),
//                   child: const Text('Create New Group Discussion',
//                       style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/messages/GDs/GD.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class GDInputScreen extends StatefulWidget {
  const GDInputScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GDInputScreenState createState() => _GDInputScreenState();
}

class _GDInputScreenState extends State<GDInputScreen> {
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
    //getting image file extension
    if (imageUrl == null || imageUrl == "") return;
    File file = File(imageUrl!);
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = FirebaseStorage.instance.ref().child(
        'images/${APIs.me.id}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('group-chats').add({
      'display_image': url,
      'userId': APIs.me.id,
      'group_name': titleController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Add New Group Discussion',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: false,
            backgroundColor: const Color(0xffFFFFFF),
            actions: [],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200], // Container background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Stack(
                    children: [
                      if (imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: PhotoView(
                            imageProvider: Image.file(File(imageUrl!)).image,
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
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Members(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(206, 15, 95, 234),
                  ),
                  child: const Text('Create New Group Discussion',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
