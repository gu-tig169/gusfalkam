import 'dart:convert';

import 'model.dart';
import 'package:http/http.dart' as http;

const API_URL = 'https://todoapp-api-vldfm.ondigitalocean.app';
const API_KEY = 'a939286c-ce18-440a-a5ee-a2d43bf66753';

class Api {
  //Ta bort en task från databasen

  static Future deleteTaskDB(String id) async {
    await http.delete('$API_URL/todos/$id?key=$API_KEY');
  }

// Lägg till en task i databsen
  static Future createTaskDB(TodoTask task) async {
    print(task);
    Map<String, dynamic> json = TodoTask.toJson(task);

    print(json);
    await http.post('$API_URL/todos?key=$API_KEY',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'title': task.message,
          'done': task.status,
        }));
    print('done');
  }

  static Future changeTaskDB(TodoTask task) async {
    print(task);
    Map<String, dynamic> json = TodoTask.toJson(task);
    print(json);
    var taskid = task.id;
    await http.put('$API_URL/todos/$taskid?key=$API_KEY',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'title': task.message,
          'done': task.status,
        }));
    print('done');
  }

  static Future<List<TodoTask>> fetchList() async {
    var response = await http.get('$API_URL/todos?key=$API_KEY');
    String bodyString = response.body;
    print(response.body);
    var json = jsonDecode(bodyString);
    print(json);

    return json.map<TodoTask>((todo) {
      return TodoTask.fromJson(todo);
    }).toList();
  }
}
