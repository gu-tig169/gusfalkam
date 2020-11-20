import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './EditListview.dart';
import './model.dart';
import './Constants.dart';

class Listview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(
          child: Text('TIG169 TODO', textAlign: TextAlign.center),
        ),

        // Drop down menu
        actions: <Widget>[
          PopupMenuButton<String>(onSelected: (choice) {
            var state = Provider.of<MyState>(context, listen: false);
            state.filterChange(choice);
          }, itemBuilder: (BuildContext context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem<String>(
                value: (choice),
                child: Text(choice),
              );
            }).toList();
          })
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => TodoList(state.list),
      ),

      //FloatingAction Button.
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newTodo = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      EditListview(TodoTask(message: null, status: false))));
          if (newTodo != null) {
            Provider.of<MyState>(context, listen: false).addTodo(newTodo);
          }
        },
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.all) {
      print('all');
      Filter.show = "all";
      print(Filter.show);
    } else if (choice == Constants.done) {
      print('done');
      Filter.show = "done";
      print(Filter.show);
    } else if (choice == Constants.undone) {
      print('undone');
      Filter.show = "undone";
      print(Filter.show);
    }
  }
}

//Klassen för listan
class TodoList extends StatelessWidget {
  final List<TodoTask> list;
  TodoList(this.list);

  Widget build(BuildContext context) {
    return ListView(
        children: list.map((task) => _todoTask(context, task)).toList());
  }
}

//Checkboxen med provider från model.dart
Widget _todoTask(context, task) {
  return ListTile(
    leading: Checkbox(
      value: task.status,
      onChanged: (bool newValue) {
        var state = Provider.of<MyState>(context, listen: false);
        state.toggleDone(task, newValue);
      },
    ),
    title: Text(task.message,
        style: TextStyle(
            decoration: task.status == false
                ? TextDecoration.none
                : TextDecoration.lineThrough,
            decorationThickness: 2.18)),

    //Här raderas en task
    trailing: IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        var state = Provider.of<MyState>(context, listen: false);
        state.removeTask(task);
      },
    ),
  );
}
