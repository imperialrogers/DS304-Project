// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ds304/helpers/apis.dart';
// import 'package:ds304/pages/notification.dart';
// import 'package:ds304/widget/circle_button.dart';
// import 'package:ds304/widget/create_post_container.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:share/share.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController commentController = TextEditingController();
//   bool isPostSaved = false;

//   @override
//   void initState() {
//     super.initState();
//     APIs.getSelfInfo();

//     //for updating user active status according to lifecycle events
//     //resume -- active or online
//     //pause  -- inactive or offline
//     SystemChannels.lifecycle.setMessageHandler((message) {
//       log('Message: $message');

//       if (APIs.auth.currentUser != null) {
//         if (message.toString().contains('resume')) {
//           APIs.updateActiveStatus(true);
//         }
//         if (message.toString().contains('pause')) {
//           APIs.updateActiveStatus(false);
//         }
//       }

//       return Future.value(message);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Alumni Connect",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 14, 93, 238), // Change the color to blue
//           ),
//         ),
//         actions: [
//           CircleButton(
//             icon: MdiIcons.bell,
//             iconSize: 25.0,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const NotificationScreen(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           const CreatePostContainer(url: ""),
//           Expanded(
//             child: FutureBuilder(
//               future: Future.value(FirebaseAuth.instance.currentUser),
//               builder: (ctx, futureSnapshot) {
//                 if (futureSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 return StreamBuilder(
//                   stream: FirebaseFirestore.instance
//                       .collection('feed')
//                       .orderBy('time', descending: false)
//                       .snapshots(),
//                   builder: (ctx, feedSnapshot) {
//                     if (feedSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     final feedDocs = feedSnapshot.data!.docs;

//                     return ListView.builder(
//                       itemCount: feedDocs.length,
//                       itemBuilder: (ctx, index) {
//                         return Card(
//                           margin: const EdgeInsets.all(8.0),
//                           color: Colors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // User Info Section
//                                 Row(
//                                   children: [
//                                     const CircleAvatar(
//                                       radius: 25.0,
//                                       // Replace with the user's profile image
//                                       backgroundImage: NetworkImage(
//                                           "https://your-profile-image-url"),
//                                     ),
//                                     const SizedBox(width: 8.0),
//                                     // Flexible widget to handle overflow
//                                     Flexible(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             feedDocs[index]['userName'],
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16.0,
//                                             ),
//                                           ),
//                                           Text(
//                                             // Format the timestamp as needed
//                                             feedDocs[index]['time'].toString(),
//                                             style: const TextStyle(
//                                                 color: Colors.grey),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 8.0),
//                                 // Post Content Section
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 5),
//                                   child: Text(
//                                     feedDocs[index]['caption'],
//                                     style: const TextStyle(
//                                         fontSize: 14.0,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8.0),
//                                 // Post Image
//                                 GestureDetector(
//                                   onDoubleTap: () {
//                                     // Handle double-tap action (e.g., incrementing likes)
//                                   },
//                                   child: Image.network(
//                                       feedDocs[index]['image_url']),
//                                 ),

//                                 const SizedBox(height: 8.0),
//                                 // Divider
//                                 const Divider(),
//                                 // Like, Comment, Share, Save Buttons
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.thumb_up,
//                                         size: 18,
//                                       ),
//                                       onPressed: () {
//                                         // Handle like button tap
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.comment,
//                                         size: 18,
//                                       ),
//                                       onPressed: () {
//                                         // Handle comment button tap
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.share,
//                                         size: 18,
//                                       ),
//                                       onPressed: () {
//                                         String postUrl =
//                                             feedDocs[index]['image_url'];
//                                         Share.share(
//                                             'Check out this post: $postUrl');
//                                       },
//                                     ),
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.save,
//                                         size: 18,
//                                         // color: isPostSaved ? Colors.blue : null,
//                                       ),
//                                       onPressed: () {
//                                         // Handle save button tap
//                                         // setState(() {
//                                         //   isPostSaved = !isPostSaved;
//                                         // });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                                 // Comment Section
//                                 _buildCommentSection(index),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildCommentSection(int index) {
//     return Column(
//       children: [
//         // Display existing comments

//         // Add new comment
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: commentController,
//                   decoration: const InputDecoration(
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide:
//                           BorderSide(color: Color.fromARGB(255, 16, 113, 192)),
//                     ),
//                     hintText: 'Add a comment...',
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send),
//                 onPressed: () {
//                   // Handle sending a new comment
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:ds304/pages/notification.dart';
import 'package:ds304/widget/create_post_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController commentController = TextEditingController();
  List<bool> isPostLikedList = List.filled(100, false);
  bool isPostSaved = false;
  bool isCommented = false;
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "ConnectX",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 14, 93, 238), // Change the color to blue
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (BuildContext context) {
                    return GiffyDialog.image(
                      scrollable: true,
                      // surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      title: const Text(
                        'Create new post',
                        textAlign: TextAlign.center,
                      ),
                      Image.asset(
                        'assets/images/upload.png',
                        height: 50,
                        fit: BoxFit.contain,
                      ),
                      content: const CreatePostContainer(url: ""),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'CANCEL'),
                          child: const Text('CANCEL'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
                size: 30,
              )),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.value(FirebaseAuth.instance.currentUser),
              builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('feed').snapshots(),
                  builder: (ctx, feedSnapshot) {
                    if (feedSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final feedDocs = feedSnapshot.data!.docs;

                    return ListView.builder(
                      itemCount: feedDocs.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 1.0,
                          margin: const EdgeInsets.all(8.0),
                          surfaceTintColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // User Info Section
                                Row(
                                  children: [
                                    const SizedBox(width: 10.0),
                                    // Flexible widget to handle overflow
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            feedDocs[index]['userName'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          Text(
                                            // Format the timestamp as needed
                                            // ignore: prefer_interpolation_to_compose_strings
                                            DateTime.parse(
                                                        feedDocs[index]['time'])
                                                    .day
                                                    .toString() +
                                                "/" +
                                                DateTime.parse(
                                                        feedDocs[index]['time'])
                                                    .month
                                                    .toString() +
                                                "/" +
                                                DateTime.parse(
                                                        feedDocs[index]['time'])
                                                    .year
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            // Format the timestamp as needed
                                            DateTime.parse(
                                                        feedDocs[index]['time'])
                                                    .hour
                                                    .toString() +
                                                ":" +
                                                DateTime.parse(
                                                        feedDocs[index]['time'])
                                                    .minute
                                                    .toString(),
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          GestureDetector(
                                            onDoubleTap: () {
                                              // Handle double-tap action (e.g., incrementing likes)
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  feedDocs[index]['image_url'],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            // Format the timestamp as needed
                                            feedDocs[index]['caption'],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 8.0),
                                // // Post Content Section
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 5),
                                //   child: Text(
                                //     feedDocs[index]['caption'],
                                //     style: const TextStyle(
                                //         fontSize: 14.0,
                                //         fontWeight: FontWeight.w500),
                                //   ),
                                // ),
                                const SizedBox(height: 8.0),
                                // Post Image

                                const SizedBox(height: 8.0),
                                // Divider
                                // Like, Comment, Share, Save Buttons
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        IconData(
                                          isPostLikedList[index]
                                              ? 0xf443
                                              : 0xf442,
                                          fontFamily: CupertinoIcons.iconFont,
                                          fontPackage:
                                              CupertinoIcons.iconFontPackage,
                                        ),
                                        color: isPostLikedList[index]
                                            ? Colors.red
                                            : null,
                                      ),
                                      onPressed: () {
                                        // Handle like button tap
                                        setState(() {
                                          isPostLikedList[index] =
                                              !isPostLikedList[index];
                                        });
                                      },
                                    ),
                                    const Text("Like"),
                                    const SizedBox(width: 35),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.comment,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        // Handle comment button tap
                                        setState(() {
                                          isCommented = !isCommented;
                                        });
                                      },
                                    ),
                                    const Text("Comment"),
                                    const SizedBox(width: 35),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.ios_share_outlined,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        String postUrl =
                                            feedDocs[index]['image_url'];
                                        Share.share(
                                            'Check out this post: $postUrl');
                                      },
                                    ),
                                    const Text("Share"),
                                  ],
                                ),
                                // Comment Section
                                if (isCommented) _buildCommentSection(index)
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCommentSection(int index) {
    return Column(
      children: [
        // Display existing comments

        // Add new comment
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 16, 113, 192)),
                    ),
                    hintText: 'Add a comment...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Handle sending a new comment
                  setState(() {
                    isCommented = !isCommented;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
