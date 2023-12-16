// import 'package:ds304/chat/Member_List.dart';
// import 'package:flutter/material.dart';

// class Message extends StatefulWidget {
//   const Message({super.key});

//   @override
//   State<Message> createState() => _MessageState();
// }

// class _MessageState extends State<Message> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFFFFF),
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
//           'Messages',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 2,
//       ),
//       body: const MemberList(),
//     );
//   }
// }

import 'package:ds304/chat/Member_List.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  String selectedCategory = 'All Chats';

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
              'Recent Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
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
                text: 'All Chats',
                selected: selectedCategory == 'All Chats',
                onPressed: () {
                  setState(() {
                    selectedCategory = 'All Chats';
                  });
                },
              ),
              CategoryBox(
                text: '2020',
                selected: selectedCategory == '2020',
                onPressed: () {
                  setState(() {
                    selectedCategory = '2020';
                  });
                },
              ),
              CategoryBox(
                text: '2021',
                selected: selectedCategory == '2021',
                onPressed: () {
                  setState(() {
                    selectedCategory = '2021';
                  });
                },
              ),
              CategoryBox(
                text: '2022',
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
            child: MemberList(),
          ),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
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
