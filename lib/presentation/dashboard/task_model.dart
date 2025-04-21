import 'dart:convert';

class TaskModel {
  int id;
  DateTime createdAt;
  String userId;
  String title;
  String data;
  bool isComplete;

  TaskModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.title,
    required this.data,
    required this.isComplete,
  });

  factory TaskModel.fromRawJson(String str) => TaskModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        title: json["title"],
        data: json["data"],
        isComplete: json["is_complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "user_id": userId,
        "title": title,
        "data": data,
        "is_complete": isComplete,
      };
}
