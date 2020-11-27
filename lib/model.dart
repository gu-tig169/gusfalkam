import 'package:flutter/material.dart';
import './Constants.dart';
import 'package:my_app/api.dart';

class TodoTask {
  String id;
  String message;
  bool status = false;

  TodoTask({this.id, this.message, this.status});

  static Map<String, dynamic> toJson(TodoTask todo) {
    return {
      'message': todo.message,
      'state': todo.status,
    };
  }

  static TodoTask fromJson(Map<String, dynamic> json) {
    return TodoTask(
      id: json['id'],
      message: json['title'],
      status: json['done'],
    );
  }
}

class MyState extends ChangeNotifier {
  List<TodoTask> _listFetched = [];
  List<TodoTask> get listFetched => _listFetched;

  Future getList() async {
    List<TodoTask> list = await Api.fetchList();
    _listFetched = list;
    notifyListeners();
  }

  void addTodo(TodoTask todo) async {
    if (todo.message == null) {
      await getList();
    } else {
      await Api.createTaskDB(todo);
      await getList();
    }
  }

  void removeTask(TodoTask todo) async {
    await Api.deleteTaskDB(todo.id);
    await getList();
  }

  void toggleDone(TodoTask todo, bool newValue) async {
    todo.status = newValue;
    await Api.changeTaskDB(todo);
    await getList();
  }

  void filterChange(String choice) async {
    Filter.show = choice;
    await Api.fetchList();
    await getList();
    filterList(choice);

    notifyListeners();
  }

  void filterList(String choice) {
    if (choice == "all") {
      _listFetched = listFetched.toList();
    } else if (choice == "undone") {
      _listFetched = listFetched.where((task) => task.status == false).toList();
    } else if (choice == "done") {
      _listFetched = listFetched.where((task) => task.status == true).toList();
    }
  }
}
