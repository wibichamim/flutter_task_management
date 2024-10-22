import 'dart:convert';

import 'package:equatable/equatable.dart';

Task notesFromMap(String str) => Task.fromMap(json.decode(str));
String notesToMap(Task data) => json.encode(data.toMap());

class Task extends Equatable {
  final int? id;
  final String title;
  final String content;
  final int? isCompleted;

  const Task({
    this.id,
    required this.title,
    required this.content,
    this.isCompleted = 0,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        isCompleted: json["isCompleted"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "isCompleted": isCompleted,
      };

  @override
  List<Object?> get props => [id, title, content, isCompleted];
}
