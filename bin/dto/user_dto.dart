class UserDTO {
  String? name;
  String? email;
  String? password;

  UserDTO();

  factory UserDTO.fromRequest(Map map) {
    return UserDTO()
      ..name = map["name"]
      ..email = map["email"]
      ..password = map["password"];
  }
}
