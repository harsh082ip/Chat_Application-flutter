import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  String name;
  String profileUrl;
   CustomListTile({super.key, required this.name, required this.profileUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        child: Image.network(profileUrl),
      ),
      onTap: () {
        
      },
    );
  }
}