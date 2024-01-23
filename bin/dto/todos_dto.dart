class TodosDTO {
  int? id;
  String? title;
  String? description;
  int? userId;

  TodosDTO({this.id, this.title, this.description, this.userId});

  factory TodosDTO.fromRequest(Map map) {
    return TodosDTO()
      ..id = map["id"]?.toInt()
      ..title = map["title"]
      ..description = map["description"]
      ..userId = map["user_id"]?.toInt();
  }
}
