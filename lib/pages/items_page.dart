import 'package:authlogin/utils/utils.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  final nameController = TextEditingController();
  final bodyController = TextEditingController();
  // final storage = FirebaseStorage.instanceFor(bucket: 'gs://lockify-8b531.appspot.com');

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'floatingButton',
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text(
                'Enter name and body that you want to store',
                style: TextStyle(
                  fontFamily: 'arial',
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              textFeild(nameController, 'Name', false),
              textFeild(bodyController, 'Body', false, maxlines: null)
            ],
          ),
        ),
      ),
    );
  }
}
