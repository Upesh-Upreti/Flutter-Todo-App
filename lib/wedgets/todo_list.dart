import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/wedgets/todo_items.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({super.key, required this.todos, required this.onRemoveTodo});

  final List<ToDo> todos;
  final void Function(ToDo todo) onRemoveTodo;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(todos[index].id),
        onDismissed: (direction) => onRemoveTodo(todos[index]),
        child: ToDoItems(
          todo: todos[index],
        ),
      ),
    );
  }
}
