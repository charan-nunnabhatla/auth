import 'package:authlogin/pages/items_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Widget getData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(includeMetadataChanges: true),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading..."),
          );
        }
        return FutureBuilder(
          future: listOfFeilds(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber[700],
                ),
              );
            }
            return snapshot.data!;
          },
        );
      },
    );
  }

  Future<Widget> listOfFeilds() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('users').doc(user.uid);
    return docRef.get(const GetOptions(source: Source.cache)).then(
        (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      final allKeys = data.keys;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: allKeys.length,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: const Color.fromARGB(255, 64, 233, 255),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    final updates = <String, dynamic>{
                                      allKeys.elementAt(index):
                                          FieldValue.delete()
                                    };
                                    docRef.update(updates);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'))
                            ],
                            title: const Text('Message:'),
                            contentPadding: const EdgeInsets.all(20),
                            content: Text(
                              data.values.elementAt(index),
                            ));
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color:Color.fromARGB(193, 59, 61, 60),
                      border: Border.all(color: Color.fromARGB(195, 78, 77, 77)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    // elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        allKeys.elementAt(index),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );

      // return ListTile(
      //   style: ListTileStyle.list,
      //   title: Text(key),
      //   onTap: () {},
      // );
    }, onError: (e) {
      logger.e(e);
    });
    // return const Text('Error');
  }

  @override
  Widget build(BuildContext context) {
    logger.i("in home page");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(user.email!),
        actions: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(CupertinoIcons.arrow_up_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Items()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: getData(),
    );
  }
}
