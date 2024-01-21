import '../infra/database/db_configuration.dart';
import '../infra/database/sql_user_queries.dart';
import '../models/user_model.dart';
import 'repository.dart';

class UserRepository implements Repository<UserModel> {
  final DBConfiguration _dbConfiguration;
  final SQLUserQueries _sqlUserQuery;

  UserRepository(this._dbConfiguration) : _sqlUserQuery = SQLUserQueries();

  @override
  Future<bool> create(UserModel value) async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.create, [value.name, value.email, value.password]);
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.delete, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.findAll);
    return result.map((r) => UserModel.fromMap(r.fields)).toList().cast<UserModel>();
  }

  @override
  Future<UserModel?> findById(int id) async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.findById, [id]);
    return result.affectedRows == 0 ? null : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.update, [value.name, value.password, value.id]);
    return result.affectedRows > 0;
  }

  Future<UserModel?> findByEmail(String email) async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.findByEmail!, [email]);
    return result.affectedRows == 0 ? null : UserModel.fromEmail(result.first.fields);
  }

  Future<UserModel?> findByIdAndEmail(int id, String email) async {
    var result = await _dbConfiguration.execQuery(_sqlUserQuery.findByIdAndEmail!, [id, email]);
    return result.affectedRows == 0 ? null : UserModel.fromMap(result.first.fields);
  }
}
