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
                title: Text('Invalid Input'),
                content: Text('Please make sure a valid was entered.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("Sure"),
                  ),
                ],
              ));
    }
    widget.onAddTodo(
      ToDo(
        title: title,
        createdDate: DateTime.now(),
        dueDate: DateTime.now(),
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
                child: Text('save task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
