import 'package:flutter/material.dart';
import './Constants.dart';

class TodoTask {
  String message;
  bool status = false;

  TodoTask({this.message, this.status});
}

class MyState extends ChangeNotifier {
  List<TodoTask> _list = [];
  List<TodoTask> get list => _list;
  List<TodoTask> _filteredList = [];
  List<TodoTask> get listFiltered => _filteredList;
  

  void addTodo(TodoTask todo) {
    _list.add(todo);
    _filteredList = list.where((task) => task.message == task.message).toList();
    notifyListeners();
  }

  void removeTask(TodoTask task) {
    _list.remove(task);
    _filteredList.remove(task);
    notifyListeners();
  }

  void toggleDone(TodoTask task, bool newValue) {
    task.status = newValue;
    notifyListeners();
  }

  void filterChange(String choice) {
    Filter.show = choice;
    filteredList(choice);
    notifyListeners();
  }

  List<TodoTask> filteredList(String choice) {
    _filteredList.clear();
    if (choice == 'done') {
      _filteredList = list.where((task) => task.status == true).toList();
      return _filteredList;
    } else if (choice == 'undone') {
      print("notDONE");

      _filteredList = list.where((task) => task.status == false).toList();

      return _filteredList;
    } else if (choice == 'all') {
      print("ALL");
      _filteredList =
          list.where((task) => task.message == task.message).toList();
      return _filteredList;
    }
    return _filteredList;
  }
}
