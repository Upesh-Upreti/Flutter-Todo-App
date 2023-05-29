import 'package:flutter/material.dart';
import 'package:todo/data/todo.dart' as todo_items;
import 'package:todo/wedgets/new_todo_modal.dart';
import '../models/todo.dart';
import '../wedgets/todo_list.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<ToDo> todoItems = todo_items.todos;
  @override
  Widget build(BuildContext context) {
    void addTodo(ToDo value) {
      setState(() {
        todoItems.add(value);
      });
    }

    void openAddTodoOverlay() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => NewTodoModal(
          onAddTodo: addTodo,
        ),
      );
    }

    void removeTodo(ToDo todo) {
      final indexTodo = todoItems.indexOf(todo);
      setState(() {
        todoItems.remove(todo);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Todo item deleted'),
          action: SnackBarAction(
              label: 'undo',
              onPressed: () {
                setState(() {
                  todoItems.insert(indexTodo, todo);
                });
              }),
        ),
      );
    }

    Widget emptyContent = const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh! Nothing to show.',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            'Start adding some!',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Things Todo',
            style: TextStyle(),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 71, 175, 223),
              Color.fromARGB(255, 247, 243, 21)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: todoItems.length > 0
                      ? ToDoList(
                          todos: todoItems,
                          onRemoveTodo: removeTodo,
                        )
                      : emptyContent)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: openAddTodoOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
