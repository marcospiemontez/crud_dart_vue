class NewsModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NewsModel(this.id, this.title, this.description, this.image, this.createdAt, this.updatedAt);

  factory NewsModel.fromJson(Map map) {
    return NewsModel(
      map['id'] as int?,
      map['title'],
      map['description'],
      map['image'],
      map['createdAt'] != null ? DateTime.fromMicrosecondsSinceEpoch(map['createdAt']) : DateTime.now(),
      map['updatedAt'] != null ? DateTime.fromMicrosecondsSinceEpoch(map['updatedAt']) : null,
    );
  }

  Map toJson() {
    return {"id": id, "title": title, "description": description, "image": image};
  }

  @override
  String toString() {
    return 'NewModel{id: $id, title: $title, descriptions: $description, image: $image, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
