import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Constants.dart';
import './EditListview.dart';
import './model.dart';

class Listview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Center(
          child: Text('TODO LIST', textAlign: TextAlign.center),
        ),
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
        builder: (context, state, child) => TodoList(state.listFetched),
      ),
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
      Filter.show = "all";
    } else if (choice == Constants.done) {
      Filter.show = "done";
    } else if (choice == Constants.undone) {
      Filter.show = "notDone";
    }
  }
}

class TodoList extends StatelessWidget {
  final List<TodoTask> _listFetched;
  TodoList(this._listFetched);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children:
            _listFetched.map((task) => variableName(context, task)).toList());
  }

  Widget variableName(context, task) {
    return Card(
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(task.message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                decoration: task.status == false
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                decorationThickness: 2.18)),
        value: task.status,
        onChanged: (bool newValue) {
          var state = Provider.of<MyState>(context, listen: false);
          state.toggleDone(task, newValue);
        },
        secondary: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            var state = Provider.of<MyState>(context, listen: false);
            state.removeTask(task);
          },
        ),
      ),
    );
  }
}
