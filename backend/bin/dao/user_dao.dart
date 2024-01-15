import '../infra/database/db_configuration.dart';
import '../infra/database/sql_user_queries.dart';
import '../models/user_model.dart';
import 'dao.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  final SQLUserQueries _sqlQuery;

  UserDAO(this._dbConfiguration) : _sqlQuery = SQLUserQueries();

  @override
  Future<bool> create(UserModel value) async {
    var result = await _execQuery(_sqlQuery.create, [value.name, value.email, value.password]);
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _execQuery(_sqlQuery.delete, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    var result = await _execQuery(_sqlQuery.findAll);
    return result.map((r) => UserModel.fromMap(r.fields)).toList().cast<UserModel>();
  }

  @override
  Future<UserModel?> findById(int id) async {
    var result = await _execQuery(_sqlQuery.findById, [id]);
    return result.affectedRows == 0 ? null : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _execQuery(_sqlQuery.update, [value.name, value.password, value.id]);
    return result.affectedRows > 0;
  }

  _execQuery(String sql, [List? params]) async {
    var connection = await _dbConfiguration.connection;
    return await connection.query(sql, params);
  }
}
