import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

import 'add_item_page.dart';
import 'restorable_todo_item_list.dart';
import 'todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RestorationMixin {
  final _scrollOffset = RestorableDouble(0);
  final _scrollController = ScrollController();
  final _toDos = RestorableToDoItemList();
  late final _addItemRoute = RestorableRouteFuture<ToDoItem?>(
      onPresent: (navigator, arguments) => navigator.restorablePush(
            _addItemDialogRouteBuilder,
            arguments: arguments,
          ),
      onComplete: (ToDoItem? item) {
        if (item != null) {
          setState(() => _toDos.value = [..._toDos.value, item]);
        }
      });

  static DialogRoute<ToDoItem?> _addItemDialogRouteBuilder(
    BuildContext context,
    Object? arguments,
  ) =>
      DialogRoute(
        context: context,
        builder: (_) => const AddItemPage(),
      );

  @override
  void initState() {
    super.initState();
    _scrollController
        .addListener(() => _scrollOffset.value = _scrollController.offset);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollController.jumpTo(_scrollOffset.value));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ToDos'),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _toDos.value.isEmpty
                  ? const [Text('You have no ToDos')]
                  : _buildToDoList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addItemRoute.present,
          tooltip: 'Add item',
          child: const Icon(Icons.add),
        ),
      );

  List<Widget> _buildToDoList() => _toDos.value
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

  @override
  void dispose() {
    _toDos.dispose();
    _addItemRoute.dispose();
    _scrollController.dispose();
    _scrollOffset.dispose();
    super.dispose();
  }

  @override
  String? get restorationId => 'home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_toDos, 'home_todos');
    registerForRestoration(_addItemRoute, 'add_item_route');
    registerForRestoration(_scrollOffset, 'scroll_offset');
  }
}
