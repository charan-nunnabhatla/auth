import 'package:flutter/material.dart';
import 'package:authlogin/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final newEmailController = TextEditingController();

  final newPasswordController = TextEditingController();

  var logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              child: const Text('Create'),
              onPressed: () {
                // createUserWithEmail(
                //     newEmailController.text, newPasswordController.text);
                createUserWithEmail(
                    newEmailController.text, newPasswordController.text);
              },
            ),
          )
        ]));
  }

  void createUserWithEmail(String email, String password) async {
    try {
      logger.i('in create user page');
      Supabase.instance.client.auth
          .signInWithPassword(password: password, email: email);
    } catch (e) {
      logger.e(e);
    }
  }
}
