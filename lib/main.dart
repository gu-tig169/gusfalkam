import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: MainView(),
    ));

// Vy 1 MainView

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Center(
          child: Text('TIG 169 TODO List', textAlign: TextAlign.center),
        ),

        //drop down menu,
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return {'all', 'done', 'undone'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),

      //retunerar listan, floatingActionButton navigerar till SecoondView
      body: _list(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondView()));
        },
      ),
    );
  }
}

// Listan över aktiviteter

Widget _list() {
  return ListView(
    children: [
      _iconRow(false, "cleaning"),
      _iconRow(false, "study"),
      _iconRow(true, "exrecise"),
      _iconRow(true, "drink beer"),
      _iconRow(true, "call mom"),
      _iconRow(true, "buy present"),
    ],
  );
}

Widget _iconRow(checkBoxValue, text) {
  return Row(
    children: [
      Checkbox(
        value: checkBoxValue,
        onChanged: (bool newValue) {
          print('You tapped the checkbox');
        },
      ),
      Expanded(
        child: Text(text),
      ),
      Expanded(
          child: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          print('You tapped the close button');
        },
      )),
    ],
  );
}

// SecondView Vy2

class SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to list'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 5),
            _nameInputField(),
            Container(height: 50),
            OutlinedButton(
              onPressed: () {
                print('button pressed');
              },
              child: Text(
                '+ Add',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameInputField() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(hintText: 'I need to do...'),
      ),
    );
  }
}
