import 'package:authlogin/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authlogin/utils/utils.dart';
import 'package:logger/logger.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final newEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  var logger = Logger();

  Future signUp() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: newEmailController.text.trim(),
          password: newPasswordController.text.trim());
      await FirebaseAuth.instance.signOut();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInHomePage(),
          ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account created"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e.code);
      logger.e(e.message);
    }
  }

  @override
  void dispose() {
    newEmailController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Sign-up'),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Join us!',
              style: TextStyle(
                  fontSize: 80,
                  fontFamily: 'arial',
                  color: Color.fromARGB(162, 255, 255, 255)),
            ),
          ),
          textFeild(newEmailController, 'Enter Username', false),
          textFeild(newPasswordController, 'Enter Password', true),
          Center(
            child: ElevatedButton(
              onPressed: signUp,
              child: const Text('Create'),
            ),
          )
        ]));
  }
}
