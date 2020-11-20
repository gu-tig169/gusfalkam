import 'package:flutter/material.dart';
import 'Constants.dart';

class TodoTask {
  UniqueKey id;
  String message;
  bool status = false;

  TodoTask({this.id, this.message, this.status});
}

//mappar appen med notifier
class MyState extends ChangeNotifier {
  List<TodoTask> _list = [];
  List<TodoTask> get list => _list;

  // Adderar en task/filrerar
  void addTodo(TodoTask todo) {
    _list.add(todo);
    print("add");
    print(_list.where((item) => item.status == false));
    notifyListeners();
  }

  //tar bort en task
  void removeTask(TodoTask task) {
    _list.remove(task);
    notifyListeners();
  }

//ger task ett nytt värde för att checka i boxen
  void toggleDone(TodoTask task, bool newValue) {
    task.status = newValue;
    notifyListeners();
  }

// filtrerar listan
  void filterChange(String choice) {
    print("Debug filterChange");
    Filter.show = choice;
    notifyListeners();
  }
}
