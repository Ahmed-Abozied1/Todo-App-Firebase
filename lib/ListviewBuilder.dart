// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListviewBuilder extends StatefulWidget {
  const ListviewBuilder({super.key});

  @override
  State<ListviewBuilder> createState() => _ListviewBuilderState();
}

class _ListviewBuilderState extends State<ListviewBuilder> {
  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Todos").doc(item);
    documentReference
        .delete()
        .whenComplete(() => print("Todo Deleted Successefully"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Todos").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Somthing Wrong !!"),
          );
        } else if (snapshot.hasData || snapshot.data != null) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  "TODOS",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot<Object?>? documentSnapshot =
                            snapshot.data?.docs[index];
                        return Card(
                          color: Colors.grey.shade400,
                          child: ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                deleteTodo((documentSnapshot != null)
                                    ? (documentSnapshot["todoTitle"])
                                    : "");
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                            leading: Container(
                              width: 26,
                              height: 26,
                              child: const Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                              )),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            title: Text((documentSnapshot != null)
                                ? (documentSnapshot["todoTitle"])
                                : ""),
                          ),
                        );
                      }),
                )
              ],
            ),
          ));
        }
        return _loading();
      },
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
      ),
    );
  }
}
