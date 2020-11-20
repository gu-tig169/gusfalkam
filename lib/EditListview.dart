import 'package:flutter/material.dart';
import './model.dart';

// Detta är andra vyn på appen

class EditListview extends StatefulWidget {
  final TodoTask task;

  EditListview(this.task);

  @override
  State<StatefulWidget> createState() {
    return EditListviewState(task);
  }
}

class EditListviewState extends State<EditListview> {
  String message;
  bool status;

  TextEditingController textEditingController;

  EditListviewState(TodoTask task) {
    this.message = task.message;
    this.status = task.status;

    textEditingController = TextEditingController(text: task.message);

    textEditingController.addListener(() {
      setState(() {
        message = textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var outlinedButton = OutlinedButton(
      onPressed: () {
        Navigator.pop(context, TodoTask(message: message, status: status));
      },
      child: Text(
        '+ Add',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
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
            _textInputField(),
            Container(height: 50),
            outlinedButton,
          ],
        ),
      ),
    );
  }

  // Text inmatningsfälet för att lägga till task med controller
  Widget _textInputField() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(hintText: 'I need to do...'),
      ),
    );
  }
}
