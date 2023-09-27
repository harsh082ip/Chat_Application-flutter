import 'package:chat_application/controller/firebase_auth.dart';
import 'package:chat_application/views/reset_password.dart';
import 'package:chat_application/views/screen/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggedin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 42, 49, 59),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 50.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  // padding: EdgeInsets.only(top: 20.0),
                  alignment: Alignment.topLeft,
                  child: Text('Hello there, \nWelcome Back',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'EMAIL ADDRESS',
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
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
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
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Get.to(ResetPassword());
                      }, 
                      child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 16.0,
                      ),
                    ),)
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40.0,
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  margin: const EdgeInsets.only(top: 75.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 122, 123, 152),
                      shape: const StadiumBorder(),
                    ),
                    child: isLoggedin == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text('SIGN IN',
                            style: TextStyle(
                              fontSize: 20.0,
                            )),
                    onPressed: () async {
                      setState(() {
                        isLoggedin = true;
                      });

                      // Perform the login operation asynchronously
                      try {
                        Auth.instance.login(
                            emailController.text, passwordController.text);
                        // If login is successful, navigate or perform other actions here
                      } catch (error) {
                        // Handle login failure here
                        print("Login failed: $error");
                      } finally {
                        setState(() {
                          isLoggedin = false;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Center(
                  child: Text(
                    " - - - OR LOGIN WITH - - - ",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: 45.0,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 122, 123, 152),
                        shape: const StadiumBorder(),
                        elevation: 1),
                    onPressed: () {
                      null;
                    },
                    icon: Row(
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 40.0,
                        ),
                        const SizedBox(
                          width: 25.0,
                        )
                      ],
                    ),
                    label: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'Sign in with',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      TextSpan(
                          text: ' Google',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold))
                    ])),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.offAll(const SignUp_Screen());
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 18.0,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
