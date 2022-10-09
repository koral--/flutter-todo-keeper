class ToDoItem {
  final String title;
  final DateTime dueDate;

  const ToDoItem(this.title, this.dueDate);

  // ignore: avoid_annotating_with_dynamic
  factory ToDoItem.fromJson(dynamic json) => ToDoItem(
        json['title'] as String,
        DateTime.fromMillisecondsSinceEpoch(json['dueDate'] as int),
      );

  Map<String, Object> toJson() => {
        'title': title,
        'dueDate': dueDate.millisecondsSinceEpoch,
      };
}
