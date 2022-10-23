// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  creatTodo() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Todos").doc(title);
    Map<String, String> todos = {
      'todoTitle': title,
    };
    documentReference.set(todos).whenComplete(() {
      print("Todo Added Successfully");
    });
  }

  TextEditingController todotitlecontroller = TextEditingController();
  String title = "";
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text("Add Todo"),
              content: TextFormField(
                onChanged: (String value) {
                  title = value;
                },
                controller: todotitlecontroller,
                style: GoogleFonts.roboto(),
                decoration: const InputDecoration(hintText: "Enter Todo"),
              ),
              actions: <Widget>[
                // ignore: unnecessary_new
                new TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    creatTodo();

                    todotitlecontroller.text = "";

                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
