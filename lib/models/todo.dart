import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

const uuid = Uuid();

@HiveType(typeId: 1)
class ToDo {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final DateTime createdDate;
  @HiveField(3)
  final DateTime dueDate;
  @HiveField(4)
  bool isDone;

  ToDo({
    required this.title,
    required this.createdDate,
    required this.dueDate,
    required this.isDone,
  }) : id = uuid.v4();
}
