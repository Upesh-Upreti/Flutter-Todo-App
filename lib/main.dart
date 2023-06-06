import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/screens/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/utils/constants.dart';

void main() async {
  await Hive.initFlutter();
  //Creating the hive box(database)
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox(ToDoConstants.HIVE_BOX);

  runApp(
    const MaterialApp(
      home: ToDoScreen(),
    ),
  );
}
