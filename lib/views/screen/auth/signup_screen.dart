import 'package:flutter/material.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
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
                    decoration: InputDecoration(
                      labelText: 'Name',
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
                    decoration: InputDecoration(
                      labelText: 'Email Address',
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
                    Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 16.0,
                      ),
                    ),
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
                    onPressed: () {},
                    child: const Text('SIGN IN',
                        style: TextStyle(
                          fontSize: 20.0,
                        )),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.034),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ? ',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    TextButton(
                        onPressed: () {},
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
