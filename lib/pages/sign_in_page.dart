import 'package:flutter/material.dart';
import 'package:authlogin/utils/utils.dart';
import 'package:authlogin/pages/sign_up_page.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInHomePage extends StatefulWidget {
  const SignInHomePage({super.key});

  @override
  State<SignInHomePage> createState() => _SignInHomePageState();
}

class _SignInHomePageState extends State<SignInHomePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var logger = Logger();
  final supabase = Supabase.instance.client;

  void signin() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await supabase.auth.signInWithPassword(
          password: passwordController.text, email: emailController.text);

      Navigator.pop(context);
    } catch (e) {
      logger.e(e);
      Navigator.pop(context);
    }
    logger.i('after try block');
    Navigator.pop(context);
  }

  void errorPasswordMessage(String errorText) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(title: Text(errorText)),
          );
        });
  }

  void errorEmailMessage(String errorText) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(title: Text(errorText)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-in'),
      ),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Welcome back!',
            style: TextStyle(
                fontSize: 80,
                fontFamily: 'arial',
                color: Color.fromARGB(162, 255, 255, 255)),
          ),
        ),
        textFeild(emailController, 'Email', false),
        textFeild(passwordController, 'Password', true),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: signin,
              child: const Text('Sign-in'),
            ),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                'New User?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
            const Text('-'),
            TextButton(
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ]),
    );
  }
}
