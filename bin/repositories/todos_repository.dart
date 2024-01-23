import '../infra/database/db_configuration.dart';
import '../infra/database/sql_todos_queries.dart';
import '../models/todos_model.dart';
import 'repository.dart';

class TodosRepository implements Repository<TodosModel> {
  final DBConfiguration _dbConfiguration;
  final SQLTodosQueries _sqlTodosQuery;

  TodosRepository(this._dbConfiguration) : _sqlTodosQuery = SQLTodosQueries();

  @override
  Future<bool> create(TodosModel value) async {
    var result = await _dbConfiguration.execQuery(_sqlTodosQuery.create, [value.title, value.description, value.userId]);
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(_sqlTodosQuery.delete, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<TodosModel>> findAll() async {
    var result = await _dbConfiguration.execQuery(_sqlTodosQuery.findAll);
    return result.map((r) => TodosModel.fromMap(r.fields)).toList().cast<TodosModel>();
  }

  @override
  Future<TodosModel?> findById(int id) async {
    var result = await _dbConfiguration.execQuery(_sqlTodosQuery.findById, [id]);
    return result.isEmpty ? null : TodosModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(TodosModel value) async {
    var result = await _dbConfiguration.execQuery(_sqlTodosQuery.update, [value.title, value.description, value.id]);
    return result.affectedRows > 0;
  }
}
