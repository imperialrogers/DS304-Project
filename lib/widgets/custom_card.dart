import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const CustomCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Card(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 2.0),
        elevation: 4.0,
        child: Container(
          color: Colors.white,
          child: Center(
            child: ListTile(
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: Icon(icon),
              title: Text(title),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                onTap();
              },
            ),
          ),
        ),
      ),
    );
  }
}
