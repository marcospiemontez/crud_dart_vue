class NewsModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  NewsModel();

  factory NewsModel.fromMap(Map map) {
    return NewsModel()
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
    return 'NewsModel{id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId}';
  }
}
