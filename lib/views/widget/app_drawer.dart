import 'package:chat_application/controller/firebase_auth.dart';
import 'package:chat_application/views/screen/auth/login_screen.dart';
import 'package:chat_application/views/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {

 

    return Drawer(
  // backgroundColor: Color.fromARGB(255, 122, 129, 148),
      backgroundColor: const Color.fromARGB(255, 26, 32, 44),
  child: ListView(
    children: [
      //const Center(
      //   child:  UserAccountsDrawerHeader(
      //      currentAccountPictureSize: Size.fromRadius(45.0),
      //      accountName: Align(
      //       alignment: Alignment.center,
      //        child: Text(
      //          'User',
      //          style: TextStyle(fontSize: 22.0,
      //          ),
      //        ),
      //      ),
      //      accountEmail: Align(
      //       alignment: Alignment.center,
      //        child: Text(
      //          'Email',
      //          style: TextStyle(fontSize: 22.0),
      //        ),
      //      ),
      //      decoration: BoxDecoration(
      //        color: Color.fromARGB(255, 26, 32, 44),
      //      ),
      //      currentAccountPicture: CircleAvatar(
      //        backgroundImage: NetworkImage(
      //            "https://firebasestorage.googleapis.com/v0/b/chatapplication-flutter.appspot.com/o/Users%2FProfile_Pic%2FIMG_20230822_150151.jpg?alt=media&token=8cdceb97-8e6d-44b7-8b30-4948f6978ebf"),
      //      ),
      //    ),
      // ),
      Container(
        height: MediaQuery.of(context).size.height*0.21,
        width: MediaQuery.of(context).size.width,
       margin: EdgeInsets.all(15.0),
       padding: EdgeInsets.all(8.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/chatapplication-flutter.appspot.com/o/Users%2FProfile_Pic%2FIMG_20230822_150151.jpg?alt=media&token=8cdceb97-8e6d-44b7-8b30-4948f6978ebf"),),
              Text('UserName', style: TextStyle(color: Colors.white, fontSize: 22.0),),
              SizedBox(height: 15.0,),
              Text('Email', style: TextStyle(color: Colors.white, fontSize: 22.0)),
          ],
        ),
      ),
      Container(
        color:Color.fromARGB(255, 122, 129, 148),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.69258,
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
      const  ListTile(
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