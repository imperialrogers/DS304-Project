import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final String title;
  const TagList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[300],
        ),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        )),
      ),
    );
  }
}
