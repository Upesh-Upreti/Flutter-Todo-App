import 'package:hive/hive.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/data/todo.dart' as todo_items;
import '../utils/constants.dart';

class ToDoDatabase {
  List<ToDo> _todoItems = [];
  //reference to our hive box
  final _todoBox = Hive.box(ToDoConstants.HIVE_BOX);

  List<ToDo> get todoItems {
    return _todoItems;
  }

  void createInitialItems() {
    //if this is the first time ever the app in lunched, then strat with some dummy data.
    _todoBox.put(ToDoConstants.HIVE_KEY, todo_items.todos);
    loadItems();
  }

  void loadItems() {
    _todoItems = List<ToDo>.from(_todoBox.get(ToDoConstants.HIVE_KEY));
  }

  void addItem(ToDo item) {
    _todoItems.add(item);
    _updateItem();
  }

  void deleteItem(ToDo item) {
    _todoItems.removeAt(_todoItems.indexOf(item));
    _updateItem();
  }

  int getIndex(ToDo item) {
    return _todoItems.indexOf(item);
  }

  void insertBackItem(int index, ToDo item) {
    _todoItems.insert(index, item);
    _updateItem();
  }

  void _updateItem() {
    _todoBox.put(ToDoConstants.HIVE_KEY, _todoItems);
  }

  void onDone(ToDo todo, bool status) {
    final index = getIndex(todo);
    _todoItems[index].isDone != _todoItems[index].isDone;
    _updateItem();
  }
}
