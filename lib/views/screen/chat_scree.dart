import 'package:flutter/material.dart';

// rgba(27,32,45,255) background
// sender message rgba(122,129,148,255)
// reciever message rgba(55,62,78,255)
/// textfield rgba(55,62,78,255)

class Chat_Screen extends StatefulWidget {
  String profileURL;
  String name;
  Chat_Screen({super.key, required this.name, required this.profileURL});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage("https://images.pexels.com/photos/17667517/pexels-photo-17667517/free-photo-of-clouds-over-a-small-beachside-church.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
        ),
        backgroundColor: Color.fromARGB(255, 27, 32, 45),
        elevation: 0,
        title: Text(widget.name),
      ),
      body: Container(
        color: Color.fromARGB(255, 27, 32, 45),
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: 'Message',
                  hintStyle: const TextStyle(
                    color: Colors.white
                  ),
                 focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                 ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.send),
                    color: Colors.grey,),
                    
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}