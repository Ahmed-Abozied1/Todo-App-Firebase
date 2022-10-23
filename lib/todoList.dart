// ignore_for_file: prefer_const_constructors, unnecessary_new, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:todolist_firebase/ListviewBuilder.dart';
import 'package:todolist_firebase/addButton.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListviewBuilder(), floatingActionButton: AddButton());
  }
}
