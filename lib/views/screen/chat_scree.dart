import 'dart:developer';

import 'package:chat_application/controller/fetch_info_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/chat_model.dart';

class Chat_Screen extends StatefulWidget {
  String profileURL;
  String name;
  String uid;
  Chat_Screen(
      {super.key,
      required this.name,
      required this.profileURL,
      required this.uid});

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> {
  final TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: Fetch_Info.fetchChats(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LinearProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('No Items Found'),
                    );
                  }

                  final messages = snapshot.data!.docs
                      .where((doc) =>
                          (doc['participants'] as List).contains(
                              FirebaseAuth.instance.currentUser!.uid) &&
                          (doc['participants'] as List).contains(widget.uid))
                      .toList();

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message =
                          messages[index].data() as Map<String, dynamic>;
                      final messageList = message['messages'] as List<dynamic>;

                      return Column(
                        // Wrap the Align widgets in a Column
                        children: messageList.map((messageItem) {
                          final text = messageItem['text'];
                          final sender_uid = messageItem['sender_uid'];
                          print('Message Text: $text');
                          print('Sender UID: $sender_uid');
                          print(
                              'Current User UID: ${FirebaseAuth.instance.currentUser!.uid}');

                          final alignment = sender_uid ==
                                  FirebaseAuth.instance.currentUser!.uid
                              ? Alignment.centerRight
                              : Alignment
                                  .centerLeft; // Use Alignment.centerLeft for messages from other senders
                          print('Alignment: $alignment');

                          return Container(
                            alignment: alignment,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: sender_uid ==
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? Color.fromARGB(255, 55, 62, 78)
                                      : Color.fromARGB(255, 55, 62, 78)),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                }),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: TextFormField(
                controller: text,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: 'Message',
                  hintStyle: const TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (text != null) {
                        debugPrint(FirebaseAuth.instance.currentUser!.uid);
                        debugPrint(widget.uid);
                        ChatModel chatModel = ChatModel(
                            uid1: FirebaseAuth.instance.currentUser!.uid,
                            uid2: widget.uid,
                            text: text.text);

                        chatModel.sendMessage();
                      }
                      text.clear();
                    },
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
