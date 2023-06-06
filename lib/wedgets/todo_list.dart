import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/wedgets/todo_items.dart';

class ToDoList extends StatelessWidget {
  const ToDoList(
      {super.key,
      required this.todos,
      required this.onRemoveTodo,
      required this.onCheckDone});

  final List<ToDo> todos;
  final void Function(ToDo todo) onRemoveTodo;
  final void Function(ToDo todo, bool isDone) onCheckDone;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) => onRemoveTodo(todos[index]),
        child: ToDoItems(
          todo: todos[index],
          onCheckDone: onCheckDone,
        ),
      ),
    );
  }
}
