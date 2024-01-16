class NewsDTO {
  int? id;
  String? title;
  String? description;
  int? userId;

  NewsDTO({this.id, this.title, this.description, this.userId});

  factory NewsDTO.fromRequest(Map map) {
    return NewsDTO()
      ..id = map["id"]?.toInt()
      ..title = map["title"]
      ..description = map["description"]
      ..userId = map["user_id"]?.toInt();
  }
}
