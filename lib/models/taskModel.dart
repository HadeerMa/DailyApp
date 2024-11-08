class TaskModel {
  String id;
  String title;
  DateTime dueDate;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      dueDate: DateTime.parse(json['dueDate']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
