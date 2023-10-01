import 'dart:developer';
import 'dart:io';

import 'package:chat_application/controller/profile_pic_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/upload_profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  String? name;
  ProfileScreen({super.key, required this.name});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  File? imgpath;
  bool isImageloading = false;
  final TextEditingController nicknameController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 42, 49, 59),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Profile info',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 42, 49, 59),
        child: Column(
          children: [
            Container(
              child: const Text(
                'Please provide your name and an optional profile photo',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),

           const  SizedBox(
              height: 40.0,
            ),
            // profile avatar
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.grey, shape: BoxShape.circle),
                  height: 160.0,
                  width: 160.0,
                ),
                Container(
                  height: 160.0,
                  width: 160.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle, // Set the shape to circle
                  ),
                  child: isImageloading == false
                      ? imgpath == null
                          ? Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.cover,
                            )
                          : ClipOval(
                              // Use ClipOval to clip the image to a circle
                              child: Image.file(
                                imgpath!,
                                fit: BoxFit.cover,
                              ),
                            )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                Positioned(
                  bottom: -10,
                  right: 8,
                  child: Container(
                    // // height: 20,
                    // // width: 20,
                    // decoration: BoxDecoration(
                    //     // color: Colors.white,
                    //     borderRadius: BorderRadius.circular(100.0)),
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          isImageloading = true;
                        });
                        print('pressed');
                        final newImgPath = await Profile_Pic.pickFile();
                        if (newImgPath != null) {
                          setState(() {
                            imgpath = File(newImgPath.path);
                            isImageloading = false;
                          });
                        } else {}
                        setState(() {
                          isImageloading = false;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Nickname input field
            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 40.0),
              child: TextFormField(
                controller: nicknameController,
                decoration: InputDecoration(
                  labelText: 'Nick Name',
                  labelStyle: TextStyle(color: Colors.grey.shade300),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .grey.shade300), // Change the border color here
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors
                            .grey.shade100), // Change the border color here
                  ),
                ),
              ),
            ),

            //
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.42,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              // margin: const EdgeInsets.only(top: 75.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 122, 123, 152),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  log(imgpath!.path);
                  Upload_Profile_Pic.uploadProfilePic(
                      imgpath!.path, nicknameController.text, widget.name);
                },
                child: const Text('Next',
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
