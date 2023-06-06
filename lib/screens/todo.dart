import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/todo_database.dart';
import 'package:todo/utils/constants.dart';
import 'package:todo/wedgets/new_todo_modal.dart';
import '../models/todo.dart';
import '../wedgets/todo_list.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final ToDoDatabase db = ToDoDatabase();
  final Box todoBox = Hive.box(ToDoConstants.HIVE_BOX);

  //As of now we are only using a key('todoItems) to store todo items
  //Since we are using a list of class ToDo to store todos

  //print(todoBox.get(ToDoConstants.HIVE_KEY));
  @override
  void initState() {
    if (todoBox.get(ToDoConstants.HIVE_KEY) == null) db.createInitialItems();
    db.loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void addTodo(ToDo value) {
      setState(() {
        db.addItem(value);
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
      final indexTodo = db.getIndex(todo);
      setState(() {
        db.deleteItem(todo);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Todo item deleted'),
          action: SnackBarAction(
              label: 'undo',
              onPressed: () {
                setState(() {
                  db.insertBackItem(indexTodo, todo);
                });
              }),
        ),
      );
    }

    void onDone(ToDo todo, bool isDone) {
      db.onDone(todo, isDone);
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
                  child: db.todoItems.isNotEmpty
                      ? ToDoList(
                          todos: db.todoItems,
                          onRemoveTodo: removeTodo,
                          onCheckDone: onDone,
                        )
                      : emptyContent)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: openAddTodoOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
