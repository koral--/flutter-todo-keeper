import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'todo_item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  //TODO make controller restorable
  final _controller = TextEditingController();
  //TODO make date restorable
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
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          const Text('Date:'),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(DateFormat.yMd().format(dueDate)),
            ),
            onTap: () => _onDateTap(context),
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
      dueDate,
    ));
  }

  Future<void> _onDateTap(BuildContext context) async {
    //TODO make route and picker state restorable
    final newDate = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );
    if (newDate != null) {
      setState(() => dueDate = newDate);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
