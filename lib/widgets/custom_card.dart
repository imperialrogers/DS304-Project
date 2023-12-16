import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const CustomCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Container(
        color: Colors.white,
        child: Center(
          child: ListTile(
            iconColor: Colors.black54,
            textColor: Colors.black,
            leading: Icon(icon, size: 20),
            title: Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lato')),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () {
              onTap();
            },
          ),
        ),
      ),
    );
  }
}
