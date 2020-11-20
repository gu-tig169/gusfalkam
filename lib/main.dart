import 'package:flutter/material.dart';
import 'ListView.dart';
import 'model.dart';
import 'package:provider/provider.dart';

//Först vyn

void main() {
  var state = MyState();

  //wrappar  applikationen i notifier
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

// Main metoden. Här körs appen. Listview Visas först enligt home property.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do app',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Listview(),
    );
  }
}
