import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class ToDoItems extends StatefulWidget {
  const ToDoItems({super.key, required this.todo});
  final ToDo todo;

  @override
  State<ToDoItems> createState() => _ToDoItemsState(todo: todo);
}

class _ToDoItemsState extends State<ToDoItems> {
  _ToDoItemsState({required this.todo});
  final ToDo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        child: Column(
          children: [
            CheckboxListTile(
                title: Text(
                  todo.title,
                  style: const TextStyle(fontSize: 18),
                ),
                value: todo.isDone,
                onChanged: (bool? val) {
                  setState(() {
                    todo.isDone = val!;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
