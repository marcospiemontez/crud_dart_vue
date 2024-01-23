class TodosModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  TodosModel();

  factory TodosModel.fromMap(Map map) {
    return TodosModel()
      ..id = map["id"]?.toInt()
      ..title = map["title"]
      ..description = map["description"].toString()
      ..createdAt = map["created_at"]
      ..updatedAt = map["updated_at"]
      ..userId = map["user_id"]?.toInt();
  }

  Map toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "user_id": userId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'TodosModel{id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId}';
  }
}
