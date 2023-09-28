import 'package:chat_application/views/screen/auth/login_screen.dart';
import 'package:chat_application/views/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1600), () {
      User? user = FirebaseAuth.instance.currentUser;
      user != null
          ? Get.offAll(const HomeScreen())
          : Get.offAll(Login_Screen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amberAccent,
      ),
    );
  }
}
