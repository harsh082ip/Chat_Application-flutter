import 'dart:developer';
import 'dart:io';

import 'package:chat_application/controller/block_chat_controller.dart';
import 'package:chat_application/controller/chat_images.dart';
import 'package:chat_application/controller/fetch_info_controller.dart';
import 'package:chat_application/views/screen/image_full_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_pic_controller.dart';
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
  bool isUserBlocked = false;
  File? imgpath;
  final TextEditingController text = TextEditingController();
  String? fdocId;
  late bool blockStatus = false; // Initialize with a default value.
  late String whoHasBlocked = ''; // Initialize with a default value.

  late final Stream<QuerySnapshot> docSnap;
  @override
  void initState() {
    super.initState();
    initializeBlockStatus();
  }

  Future<void> initializeBlockStatus() async {
    bool status = await BlockChat_Controller.fetchBlockStatus(widget.uid);
    setState(() {
      blockStatus = status;
    });

    // You can also fetch the 'whoHasBlocked' value here if needed.
    // For now, I'm assuming it's a String and is fetched in a similar manner.
    String blockedBy = await BlockChat_Controller.fetchBlockUser(widget.uid);
    setState(() {
      whoHasBlocked = blockedBy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 32, 45),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 27, 32, 45),
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileURL),
            ),
            SizedBox(
              width: 25.0,
            ),
            Text(
              widget.name,
              style: TextStyle(fontSize: 25.0),
            ),
          ],
        ),
        actions: <Widget>[
          // IconButton(
          //     onPressed: () {
          //       log(isUserBlocked.toString());
          //     },
          // icon: Icon(Icons.display_settings)),
          whoHasBlocked == FirebaseAuth.instance.currentUser!.uid
              ? Switch(
                  value: blockStatus,
                  onChanged: (val) {
                    setState(() {
                      blockStatus = !blockStatus;
                      log('isUserBlocked $isUserBlocked');
                      BlockChat_Controller.updateBlockStatus(
                          fdocId.toString(), blockStatus,
                          whoHasBlocked:
                              FirebaseAuth.instance.currentUser!.uid);
                    });
                  })
              : Container()
        ],
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
                      child: CircularProgressIndicator(),
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
                  log('isUserBlocked $isUserBlocked');
                  final messages = snapshot.data!.docs
                      .where((doc) =>
                          (doc['participants'] as List).contains(
                              FirebaseAuth.instance.currentUser!.uid) &&
                          (doc['participants'] as List).contains(widget.uid))
                      .toList();
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  log(documents.length.toString());
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      // extracting docId for updating blockStatus
                      final docId = messages[index].id.toString();
                      fdocId = docId;
                      log(docId);
                      final message =
                          messages[index].data() as Map<String, dynamic>;
                      log(message.toString());
                      final messageList = message['messages'] as List<dynamic>;
                      blockStatus = message['isChatBlocked'];
                      whoHasBlocked = message['whoHasBlocked'];
                      return Column(
                        // Wrap the Align widgets in a Column
                        children: messageList.map((messageItem) {
                          final text = messageItem['text'];
                          final imageOrText = messageItem['istextAnImage'];
                          final sender_uid = messageItem['sender_uid'];
                          final isUserBlocked = messageItem['isUserBlocked'];
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
                            child: Wrap(
                              // Use Wrap to allow content to wrap
                              crossAxisAlignment: WrapCrossAlignment
                                  .start, // Align children to the start
                              children: [
                                Container(
                                  padding: EdgeInsets.all(7.0),
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: sender_uid ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? Color.fromARGB(255, 122, 129, 148)
                                        : Color.fromARGB(255, 55, 62, 78),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: imageOrText
                                      ? Container(
                                          margin: EdgeInsets.all(0.0),
                                          padding: EdgeInsets.all(0.0),
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(ImageFullScreen(
                                                  imgPath: text));
                                            },
                                            child: Image.network(
                                              text,
                                              height: 250.0,
                                              width: 250.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : SelectableText(
                                          text,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                ),
                              ],
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
              margin: EdgeInsets.all(12.0),
              child: blockStatus
                  ? whoHasBlocked == FirebaseAuth.instance.currentUser!.uid
                      ? Text('You have blocked this contact')
                      : Text('You have been blocked by this contact')
                  : TextFormField(
                      controller: text,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        fillColor: Color.fromARGB(255, 55, 62, 78),
                        filled: true,
                        hintText:
                            imgpath != null ? "Image selected" : "Message",
                        hintStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 122, 129, 148),
                          ),
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () async {
                            final newImgPath = await Profile_Pic.pickFile();
                            if (newImgPath != null) {
                              setState(() {
                                imgpath = File(newImgPath.path);
                              });
                            }
                          },
                          icon: Icon(Icons.upload_file),
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (text.text != "") {
                              debugPrint(
                                  FirebaseAuth.instance.currentUser!.uid);
                              debugPrint(widget.uid);
                              ChatModel chatModel = ChatModel(
                                  uid1: FirebaseAuth.instance.currentUser!.uid,
                                  uid2: widget.uid,
                                  text: text.text,
                                  isUserBlocked: isUserBlocked);

                              chatModel.sendMessage(false);
                            }

                            if (imgpath != null) {
                              log(imgpath.toString());
                              String? downurl =
                                  await Upload_ChatImages.uploadChatImages(
                                      imgpath!.path);

                              if (downurl != null) {
                                ChatModel chatModel = ChatModel(
                                    uid1:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    uid2: widget.uid,
                                    text: downurl.toString(),
                                    isUserBlocked: isUserBlocked);
                                chatModel.sendMessage(true);
                                setState(() {
                                  imgpath = null;
                                });
                              }
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
