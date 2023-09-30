import 'package:flutter/material.dart';
import 'package:chat_list/chat_list.dart';
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
  final ScrollController _scrollController = ScrollController();

  final List<Message> _messageList = [
    Message(
        content: "Hi, Bill! This is the simplest example ever.",
        ownerType: OwnerType.sender,
        ownerName: "Higor Lapa"),
    Message(
        content:
            "Let's make it better , Higor. Custom font size and text color",
        textColor: Colors.black38,
        fontSize: 18.0,
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "Bill, we have to talk about business",
        fontSize: 12.0,
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "Wow, I like it. Tell me what I can do for you, pal.",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
      content: "Nice",
      ownerType: OwnerType.sender,
      ownerName: "Higor",
    ),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
      content: "Nice",
      ownerType: OwnerType.sender,
      ownerName: "Higor",
    ),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
      content: "Nice",
      ownerType: OwnerType.sender,
      ownerName: "Higor",
    ),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
        content: "Nice",
        ownerType: OwnerType.receiver,
        ownerName: "Bill Gates"),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
    Message(
      content: "Nice",
      ownerType: OwnerType.sender,
      ownerName: "Higor",
    ),
    Message(
        content: "I'm just a copy",
        ownerType: OwnerType.sender,
        ownerName: "Higor"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(widget.profileURL)),
        backgroundColor: Color.fromARGB(255, 27, 32, 45),
        elevation: 0,
        title: Text(widget.name),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromARGB(255, 27, 32, 45),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 27, 32, 45),
                child: ChatList(
                  children: _messageList,
                  scrollController: _scrollController,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  hintText: 'Message',
                  hintStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
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
                    onPressed: () {},
                    icon: Icon(Icons.send),
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Color.fromARGB(255, 27, 32, 45),