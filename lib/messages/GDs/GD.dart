import 'package:ds304/messages/GDs/GroupList.dart';
import 'package:ds304/messages/GDs/add_GD.dart';
import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  const Members({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[400]!,
                Colors.blue[800]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Group Discussions',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: 'Lato'),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 2,
      ),
      body: const GroupList(),
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
