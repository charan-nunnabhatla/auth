import 'package:authlogin/pages/forgot_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:authlogin/utils/utils.dart';
import 'package:authlogin/pages/sign_up_page.dart';
import 'package:logger/logger.dart';

class SignInHomePage extends StatefulWidget {
  const SignInHomePage({super.key});

  @override
  State<SignInHomePage> createState() => _SignInHomePageState();
}

class _SignInHomePageState extends State<SignInHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var logger = Logger();

  void signinButton(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign-in'),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 70,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Welcome back!',
            style: TextStyle(
                fontSize: 80,
                fontFamily: 'arial',
                color: Color.fromARGB(161, 211, 240, 234)),
          ),
        ),
        textFeild(emailController, 'Email', false),
        textFeild(passwordController, 'Password', true),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                return signinButton(context);
              },
              child: const Text('Sign-in'),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                'New User?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
            ),
            const Text('-'),
            TextButton(
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ForgotPassword()));
              },
            ),
          ],
        ),
      ]),
    );
  }
}
