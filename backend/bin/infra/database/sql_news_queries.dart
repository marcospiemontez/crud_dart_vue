import 'sql_queries.dart';

class SQLNewsQueries extends SQLQueries {
  SQLNewsQueries() : super(
    create: "INSERT INTO news (title, description, user_id) VALUES (?, ?, ?)",
    delete: "DELETE FROM news WHERE id = ?",
    findAll: "SELECT * FROM news",
    findById: "SELECT * FROM news WHERE id = ?",
    update: "UPDATE news SET title = ?, description = ? WHERE id = ?",
  );
}
