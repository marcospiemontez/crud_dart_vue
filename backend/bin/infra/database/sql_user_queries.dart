import 'sql_queries.dart';

class SQLUserQueries extends SQLQueries {
  SQLUserQueries()
      : super(
          create: "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
          delete: "DELETE FROM users WHERE id = ?",
          findAll: "SELECT * FROM users",
          findById: "SELECT * FROM users WHERE id = ?",
          update: "UPDATE users SET name = ?, password = ? WHERE id = ?",
          findByEmail: "SELECT * FROM users WHERE email = ?",
        );
}
