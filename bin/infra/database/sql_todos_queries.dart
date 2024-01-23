import 'sql_queries.dart';

class SQLTodosQueries extends SQLQueries {
  SQLTodosQueries()
      : super(
          create: "INSERT INTO todos (title, description, user_id) VALUES (?, ?, ?)",
          delete: "DELETE FROM todos WHERE id = ?",
          findAll: "SELECT * FROM todos",
          findById: "SELECT * FROM todos WHERE id = ?",
          update: "UPDATE todos SET title = ?, description = ? WHERE id = ?",
        );
}
