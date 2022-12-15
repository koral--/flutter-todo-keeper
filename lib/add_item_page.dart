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

import 'todo_item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState
    extends State<AddItemPage> /* TODO: add the RestorationMixin */ {
  // TODO: replace with restorable controller
  final _controller = TextEditingController();

  // TODO: replace with restorable date
  DateTime dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) => AlertDialog(
      title: const Text('Item details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (_) => _onItemConfirmed(context),
            controller: _controller, // TODO: replace with value property
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          const Text('Date:'),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              // TODO: replace with value property
              child: Text(DateFormat.yMd().format(dueDate)),
            ),
            onTap: () => _onDateTap(context), // TODO: present restorable route
          ),
          const SizedBox(height: 16.0),
          OutlinedButton(
            onPressed: () => _onItemConfirmed(context),
            child: const Text('Add'),
          ),
        ],
      ));

  void _onItemConfirmed(BuildContext context) {
    Navigator.of(context).pop(ToDoItem(
      _controller.text,
      dueDate, // TODO: replace with value property
    ));
  }

  // TODO: replace with restorable route
  Future<void> _onDateTap(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2243),
    );
    if (newDate != null) {
      setState(() => dueDate = newDate);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: dispose the date
    // TODO: dispose the route
    super.dispose();
  }

// TODO: implement the RestorationMixin members
// TODO: register route for restoration
}
