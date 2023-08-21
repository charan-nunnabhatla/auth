import 'package:authlogin/pages/item_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:authlogin/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logger = Logger();
  void signOut() async {
    Supabase.instance.client.auth.signOut(scope: SignOutScope.global);
  }

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();
  var notes = ['kdfj', 'skdjf', 'lksdjfl', 'lksdjf'];
  void onAddPressed() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Details'),
            scrollable: true,
            content: Column(
              children: [
                textFeild(nameEditingController, 'Name', false),
                textFeild(bodyEditingController, 'Body', false),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      notes.add(nameEditingController.text);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    logger.i("in home page");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In'),
        actions: [
          IconButton(
              onPressed: onAddPressed,
              icon: const Icon(CupertinoIcons.add_circled)),
          IconButton(
              onPressed: signOut,
              icon: const Icon(CupertinoIcons.arrow_up_circle)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemPage(title: notes[index])),
              );
            },
            child: Card(
              elevation: 2,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${index + 1}'),
                ),
                Text(notes[index]),
                const Spacer(),
              ]),
            ),
          );
        },
      ),
    );
  }
}
