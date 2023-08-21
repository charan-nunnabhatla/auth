import 'package:flutter/material.dart';

Widget textFeild(TextEditingController textEditingController, String lable,
    bool obsobscureText) {
  return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        obscureText: obsobscureText,
        // textCapitalization: TextCapitalization.characters,
        onChanged: (value) {
          // textEditingController.value = TextEditingValue(
          // text: value.toUpperCase(), selection: textEditingController.selection);
        },
        style: const TextStyle(
          color: Color.fromARGB(255, 250, 250, 250),
          // fontSize: 20,
          // fontWeight: FontWeight.w400
        ),
        // strutStyle: const StrutStyle(
        // fontFamily: 'arial', fontSize: 10, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
        // onSubmitted: (value) => setState(() {}),
        controller: textEditingController,
        decoration: InputDecoration(
          // hintText: 'HallTicket Number',
          label: Text(lable),
          floatingLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 142, 187, 218),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'arial',
            // fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 92, 92, 92),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 67, 212, 152)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ));
}

class UserDetails {
  String name;
  String email;
  String uid;

  UserDetails({required this.name, required this.uid, required this.email});

  Map<String, dynamic> toMap() {
    return {"name": name, "uid": uid, "email": email};
  }

  @override
  String toString() {
    return 'UserDetails{"name":$name, "uid": $uid, "email": $email}';
  }
}

