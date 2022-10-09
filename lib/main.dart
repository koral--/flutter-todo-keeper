import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(const ToDoKeeperApp());

class ToDoKeeperApp extends StatelessWidget {
  const ToDoKeeperApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'ToDo Keeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
}
