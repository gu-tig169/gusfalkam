import 'package:flutter/material.dart';
import 'ListView.dart';
import 'model.dart';
import 'package:provider/provider.dart';

// Här körs koden med Notifyprovider som  alla widget i vår app
// får tillgång till utan att vi behöver "skicka runt den" till alla
//widgets i appen. 
// home : Listview()

void main() {
  var state = MyState();
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.comfortable,
      ),
      home: Listview(),
    );
  }
}
