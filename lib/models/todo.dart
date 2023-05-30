import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ToDo {
  ToDo({
    required this.title,
    required this.createdDate,
    required this.dueDate,
  })  : id = uuid.v4(),
        isDone = false;

  final String title;
  final String id;
  final DateTime createdDate;
  final DateTime dueDate;
  bool isDone;
}
