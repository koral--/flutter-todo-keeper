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

class _HomePageState
    extends State<HomePage> /* TODO: add the RestorationMixin */ {
  // TODO: change the type to RestorableToDoItemList
  final List<ToDoItem> _toDos = [];

  // TODO: add scroll offset and controller

  @override
  void initState() {
    super.initState();
    // TODO: listen to the scroll position changes
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDos'),
        ),
        body: SingleChildScrollView(
          // TODO: assign scroll controller
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _toDos.isEmpty // TODO: use value field of the list
                  ? const [Text('You have no ToDos')]
                  : _buildToDoList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddItemDialog, // TODO: present restorable route
          tooltip: 'Add item',
          child: const Icon(Icons.add),
        ),
      );

  List<Widget> _buildToDoList() => _toDos // TODO: use value field of the list
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

  // TODO: replace with restorable route
  Future<void> _showAddItemDialog() async {
    final item = await showDialog<ToDoItem>(
        context: context, builder: (context) => const AddItemPage());

    if (item != null) {
      setState(() => _toDos.add(item)); // TODO: create a new instance of a list
    }
  }

  @override
  void dispose() {
    // TODO: dispose the restorable list
    // TODO: dispose the scroll controller and offset
    // TODO: dispose the route
    super.dispose();
  }

// TODO: implement the RestorationMixin methods
// TODO: register the list for restoration
// TODO: registering the scroll offset for restoration
// TODO: register the route for restoration
}
