import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();
  void signOut() async {
    FirebaseAuth.instance.signOut();
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    logger.i("in home page");
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Logged In'),
          actions: [
            IconButton(
                onPressed: signOut,
                icon: const Icon(CupertinoIcons.arrow_up_circle)),
          ],
        ),
        body: Center(
          child: Text('Logged in as: ${user.email!}'),
        ));
  }
}
