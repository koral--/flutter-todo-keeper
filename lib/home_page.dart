import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_item_page.dart';
import 'todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ToDoItem> _toDos = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDos'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _toDos.isEmpty
                  ? const [Text('You have no ToDos')]
                  : _buildToDoList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddItemDialog,
          tooltip: 'Add item',
          child: const Icon(Icons.add),
        ),
      );

  List<Widget> _buildToDoList() => _toDos
      .map((item) => [
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(DateFormat.yMd().format(item.dueDate)),
            const SizedBox(height: 16.0),
          ])
      .expand((element) => element)
      .toList(growable: false);

  Future<void> _showAddItemDialog() async {
    final item = await showDialog<ToDoItem>(
        context: context, builder: (context) => const AddItemPage());

    if (item != null) {
      setState(() => _toDos.add(item));
    }
  }
}
