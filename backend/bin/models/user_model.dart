class UserModel {
  final int id;
  final String name;
  final String email;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel(
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map["id"]?.toInt() ?? 0,
      map["name"] ?? '',
      map["email"] ?? '',
      map["is_active"] == 1,
      map["created_at"],
      map["updated_at"],
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
