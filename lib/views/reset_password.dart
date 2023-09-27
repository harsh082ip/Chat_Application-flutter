import 'package:chat_application/controller/firebase_auth.dart';
import 'package:chat_application/views/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  TextEditingController _emailController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 76, 103),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Recieve an email to \n reset your password. ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),),
            const SizedBox(height: 40.0,),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter you email',
              ),
            ),

            SizedBox(height: 40.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: (){
                  Auth.reset_password(_emailController.text.toString());
                    Navigator.pop(context);
                }, 
              child: Text('Send Email'),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.blueGrey,
                shape:StadiumBorder(),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}