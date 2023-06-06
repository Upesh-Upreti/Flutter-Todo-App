import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class ToDoItems extends StatefulWidget {
  const ToDoItems({super.key, required this.todo, required this.onCheckDone});
  final ToDo todo;
  final void Function(ToDo todo, bool isDone) onCheckDone;

  @override
  State<ToDoItems> createState() => _ToDoItemsState();
}

class _ToDoItemsState extends State<ToDoItems> {
  // _ToDoItemsState({required this.todo});
  // final ToDo todo;

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
                  widget.todo.title,
                  style: const TextStyle(fontSize: 16),
                ),
                value: widget.todo.isDone,
                onChanged: (bool? val) {
                  widget.onCheckDone(widget.todo, val!);
                  setState(() {
                    widget.todo.isDone = val;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
