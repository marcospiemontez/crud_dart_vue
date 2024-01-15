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

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map["name"]
      ..email = map["email"]
      ..password = map["password"];
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
