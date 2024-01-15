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
      ..description = map["description"]
      ..createdAt = map["createdAt"]
      ..updatedAt = map["updatedAt"]
      ..userId = map["user_id"]?.toInt();
  }

  factory NewsModel.fromRequest(Map map) {
    return NewsModel()
      ..title = map["title"]
      ..description = map["description"]
      ..userId = map["user_id"]?.toInt();
  }

  Map toJson() {
    return {"id": id, "title": title, "description": description};
  }

  @override
  String toString() {
    return 'NewsModel{id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId}';
  }
}
