import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './EditListview.dart';
import './model.dart';
import './Constants.dart';

// Fösta vyn

class Listview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Center(
          child: Text('MY TODO LIST', textAlign: TextAlign.center),
        ),

        // Drop down menu använder provider från model (filterChange).
        // med constants och lista från klassen/filen Constants.
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

// Retunerar en filtrerad lista (listFiltred) med state.
//Consumer som lyssnar på vårt state
      body: Consumer<MyState>(
        builder: (context, state, child) => TodoList(state.listFiltered),
      ),

      // Min knapp som navigerar till EditListview.
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

  // Metoden för drop down menu
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

//Klassen som skapar filtrerad lista.
class TodoList extends StatelessWidget {
  final List<TodoTask> listFiltered;

  TodoList(this.listFiltered);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children:
            listFiltered.map((task) => todoWidget(context, task)).toList());
  }

// Widget för ikon raden med checkbox och tabort funktion.
  Widget todoWidget(context, task) {
    return Card(
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(task.message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 19.0,
                decoration: task.status == false
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                decorationThickness: 2.18)),
        value: task.status,
        onChanged: (bool newValue) {
          //Checkar i checkbox med provider.
          var state = Provider.of<MyState>(context, listen: false);
          state.toggleDone(task, newValue);
        },

        //Genom att man trycket på knappen raderas en task här med provider.
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
