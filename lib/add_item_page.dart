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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(DateFormat.yMd().format(_dueDate.value)),
            ),
            onTap: () => _restorableDatePickerRouteFuture.present(),
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
