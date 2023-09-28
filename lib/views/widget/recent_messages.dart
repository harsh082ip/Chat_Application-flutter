import 'package:flutter/material.dart';

class Recent_Messages extends StatefulWidget {
  String name;
  String profile_pic_url;
  Recent_Messages(
      {super.key, required this.profile_pic_url, required this.name});

  @override
  State<Recent_Messages> createState() => _Recent_MessagesState();
}

class _Recent_MessagesState extends State<Recent_Messages> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.network(
                  widget
                      .profile_pic_url, // Moved this line inside Image.network
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25.0),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // Add some space between the image and the text
          Container(
            margin: EdgeInsets.only(left: 18.0),
            alignment: Alignment.topLeft,
            child: Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
