class NoteModel {
  String id;
  String content;
  DateTime date;

  NoteModel({
    required this.id,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'date': date.toIso8601String(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      content: json['content'],
      date: DateTime.parse(json['date']),
    );
  }
}
