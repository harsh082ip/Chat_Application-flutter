import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
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
                  height: 160,
                  width: 160,
                  child: Image.asset(
                    'assets/images/user.png',
                    fit: BoxFit.cover,
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
                      onPressed: () {
                        print('pressed');
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                        size: 28.0,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
