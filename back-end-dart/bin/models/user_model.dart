class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel();

  UserModel.create(
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
      map["id"]?.toInt() ?? 0,
      map["name"] ?? '',
      map["email"] ?? '',
      map["is_active"] == 1,
      map["created_at"],
      map["updated_at"],
    );
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map["id"]?.toInt()
      ..password = map["password"];
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "is_active": isActive,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
