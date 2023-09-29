import 'dart:developer';

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  String name;
  String profileUrl;
  CustomListTile({super.key, required this.name, required this.profileUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 0), // Set padding to zero
        title: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        subtitle: Text(
          'This is demo recent message💖💖',
          style: TextStyle(color: const Color.fromARGB(255, 208, 206, 206)),
        ),
        trailing: Text(
          'Sep 29',
          style: TextStyle(color: Color.fromARGB(255, 208, 206, 206)),
        ),
        leading: CircleAvatar(
          radius: 30, // Adjust the radius as needed
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(profileUrl),
        ),
        onTap: () {
          log('pressed');
        },
      ),
    );
  }
}
