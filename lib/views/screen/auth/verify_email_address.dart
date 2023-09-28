import 'dart:async';

import 'package:chat_application/views/screen/add_profile_screen.dart';
import 'package:chat_application/views/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/firebase_auth.dart';

class Verify_Email extends StatefulWidget {
  Verify_Email({super.key, required this.name});
  String? name;
  @override
  State<Verify_Email> createState() => _Verify_EmailState();
}

class _Verify_EmailState extends State<Verify_Email> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      Auth.instance.sendVerificationLink();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    } else {
      Get.off(ProfileScreen(
        name: widget.name,
      ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? ProfileScreen(
            name: widget.name,
          )
        : Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 42, 49, 59),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 100.0)
                          .copyWith(top: 30.0),
                      child: Image.asset('assets/images/mail.png'),
                    ),
                    const Text(
                      'Verify your email address',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontFamily: 'ADLaMDisplay'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0)
                          .copyWith(top: 30.0),
                      child: const Text(
                        'We have just send email verification link on your email. Please check email and click on that link to verify your email address',
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0)
                          .copyWith(top: 15.0),
                      child: const Text(
                        'If not auto redirect after verification, click on the continue button',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55.0,
                      margin: const EdgeInsets.symmetric(horizontal: 85.0)
                          .copyWith(top: 20.0),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          isEmailVerified ? HomeScreen() : null;
                        },
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.black, fontSize: 28.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: InkWell(
                        onTap: () {
                          Auth.instance.sendVerificationLink();
                          Future.delayed(Duration(seconds: 5));
                        },
                        child: const Text(
                          'Resend E-mail link',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 11, 138, 241)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: TextButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Back to Login',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
