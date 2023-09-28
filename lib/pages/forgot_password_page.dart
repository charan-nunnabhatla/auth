import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authlogin/utils/utils.dart';
import 'package:logger/logger.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailcontroller = TextEditingController();

  final logger = Logger();

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim())
          .then((value) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Please check your email to reset your password'),
              );
            });
      });
    } on FirebaseAuthException catch (e) {
      logger.e(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'We will send reset link to reset your password',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'arial',
                    color: Color.fromARGB(193, 255, 255, 255)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            textFeild(emailcontroller, 'Enter email', false),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => resetPassword,
              child: const Text("Send"),
            ),
          ],
        ),
      ),
    );
  }
}
