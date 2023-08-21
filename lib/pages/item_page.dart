import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key, required this.title});
  final String title;

  @override
  State<ItemPage> createState() => ItemPageState();
}

class ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
    );
  }
}
