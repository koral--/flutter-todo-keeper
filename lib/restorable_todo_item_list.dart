import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'todo_item.dart';

class RestorableToDoItemList extends RestorableValue<List<ToDoItem>> {
  @override
  List<ToDoItem> createDefaultValue() => [];

  @override
  void didUpdateValue(List<ToDoItem>? oldValue) {
    notifyListeners();
  }

  @override
  List<ToDoItem> fromPrimitives(Object? data) => data is! List ? [] : data
        .whereType<String>()
        .map((e) => ToDoItem.fromJson(jsonDecode(e)))
        .toList(growable: false);

  @override
  Object? toPrimitives() =>
      value.map((e) => jsonEncode(e)).toList(growable: false);
}
