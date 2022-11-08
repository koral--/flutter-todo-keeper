/*
Copyright (c) 2022 Kodeco LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
distribute, sublicense, create a derivative work, and/or sell copies of the
Software in any work that is designed, intended, or marketed for pedagogical or
instructional purposes related to programming, coding, application development,
or information technology.  Permission for such use, copying, modification,
merger, publication, distribution, sublicensing, creation of derivative works,
or sale is expressly withheld.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

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
  //TODO make list restorable
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
    //TODO make route restorable
    final item = await showDialog<ToDoItem>(
        context: context, builder: (context) => const AddItemPage());

    if (item != null) {
      setState(() => _toDos.add(item));
    }
  }
}
