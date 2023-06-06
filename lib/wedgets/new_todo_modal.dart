import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';

class NewTodoModal extends StatefulWidget {
  const NewTodoModal({super.key, required this.onAddTodo});
  final void Function(ToDo todo) onAddTodo;

  @override
  State<NewTodoModal> createState() => _NewTodoModalState();
}

class _NewTodoModalState extends State<NewTodoModal> {
  final todoController = TextEditingController();
  void addTodo() {
    final String title = todoController.text.trim();

    if (title.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 211, 185, 184),
                title: const Text('Invalid Input'),
                content:
                    const Text('Please make sure a valid task was entered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Sure"),
                  ),
                ],
              ));

      return;
    }
    widget.onAddTodo(
      ToDo(
        title: title,
        createdDate: DateTime.now(),
        dueDate: DateTime.now(),
        isDone: false,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Column(
        children: [
          TextField(
            controller: todoController,
            maxLength: 50,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              label: Text('Add task here.'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: addTodo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('save task'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
