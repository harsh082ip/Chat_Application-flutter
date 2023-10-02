import 'package:chat_application/controller/fetch_info_controller.dart';
import 'package:chat_application/controller/firebase_auth.dart';
import 'package:chat_application/views/screen/auth/login_screen.dart';
import 'package:chat_application/views/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? imgUrl;
  String? name;
  String? email;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    imgUrl =
        await Fetch_Info.fetchImageUrl(FirebaseAuth.instance.currentUser!.uid)
            as String?;
    name =
        await Fetch_Info.fetchUserName(FirebaseAuth.instance.currentUser!.uid)
            as String?;
    email =
        await Fetch_Info.fetchUserEmail(FirebaseAuth.instance.currentUser!.uid)
            as String?;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 26, 32, 44),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.21,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(imgUrl ?? ""),
                ),
                Text(
                  name ?? "Name",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(email ?? "E-mail",
                    style: TextStyle(color: Colors.white, fontSize: 15.0)),
              ],
            ),
          ),
          Container(
            color: Color.fromARGB(255, 122, 129, 148),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.69258,
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile Settings'),
                ),
                ListTile(
                  onTap: () {
                    Get.to(HomeScreen());
                  },
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                const ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification'),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                const ListTile(
                  leading: Icon(Icons.policy_outlined),
                  title: Text('Terms and Conditions'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.315),
                ListTile(
                  title: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 26, 32, 44)),
                      onPressed: () {
                        Auth.instance.logout();
                      },
                      icon: Icon(Icons.logout),
                      label: Text('LOGOUT')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
