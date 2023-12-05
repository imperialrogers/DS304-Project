import 'package:ds304/messages/GDs/GroupList.dart';
import 'package:ds304/messages/GDs/add_GD.dart';
import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  const Members({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group Discussions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GroupList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GDInputScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
