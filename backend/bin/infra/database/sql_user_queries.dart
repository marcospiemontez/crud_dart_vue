class SQLUserQueries {
  final String create = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
  final String delete = "DELETE FROM users WHERE id = ?";
  final String findAll = "SELECT * FROM users";
  final String findById = "SELECT * FROM users WHERE id = ?";
  final String update = "UPDATE users SET name = ?, password = ? WHERE id = ?";
}
