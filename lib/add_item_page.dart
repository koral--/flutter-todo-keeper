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

class _AddItemPageState extends State<AddItemPage> with RestorationMixin {
  final _controller = RestorableTextEditingController();
  final _dueDate = RestorableDateTime(DateTime.now());

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) =>
      DialogRoute<DateTime>(
        context: context,
        builder: (context) => DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime.now(),
          lastDate: DateTime(2243),
        ),
      );

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: (newDate) {
      if (newDate != null) {
        setState(() => _dueDate.value = newDate);
      }
    },
    onPresent: (NavigatorState navigator, Object? arguments) =>
        navigator.restorablePush(
      _datePickerRoute,
      arguments: _dueDate.value.millisecondsSinceEpoch,
    ),
  );

  @override
  Widget build(BuildContext context) => AlertDialog(
      title: const Text('Item details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (_) => _onItemConfirmed(context),
            controller: _controller.value,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          const Text('Date:'),
          InkWell(
            onTap: _restorableDatePickerRouteFuture.present,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(DateFormat.yMd().format(_dueDate.value)),
            ),
          ),
          const SizedBox(height: 16.0),
          OutlinedButton(
            onPressed: () => _onItemConfirmed(context),
            child: const Text('Add'),
          ),
        ],
      ));

  void _onItemConfirmed(BuildContext context) =>
      Navigator.of(context).pop(ToDoItem(
        _controller.value.text,
        _dueDate.value,
      ));

  @override
  void dispose() {
    _controller.dispose();
    _dueDate.dispose();
    _restorableDatePickerRouteFuture.dispose();
    super.dispose();
  }

  @override
  String? get restorationId => 'add_item_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_controller, 'title');
    registerForRestoration(_dueDate, 'due_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }
}
