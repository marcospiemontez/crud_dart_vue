import '../infra/database/db_configuration.dart';
import '../infra/database/sql_news_queries.dart';
import '../models/news_model.dart';
import 'dao.dart';

class NewsDao implements DAO<NewsModel> {
  final DBConfiguration _dbConfiguration;
  final SQLNewsQueries _sqlNewsQuery;

  NewsDao(this._dbConfiguration) : _sqlNewsQuery = SQLNewsQueries();

  @override
  Future<bool> create(NewsModel value) async {
    var result = await _dbConfiguration.execQuery(_sqlNewsQuery.create, [value.title, value.description, value.userId]);
    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    var result = await _dbConfiguration.execQuery(_sqlNewsQuery.delete, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    var result = await _dbConfiguration.execQuery(_sqlNewsQuery.findAll);
    return result.map((r) => NewsModel.fromMap(r.fields)).toList().cast<NewsModel>();
  }

  @override
  Future<NewsModel?> findById(int id) async {
    var result = await _dbConfiguration.execQuery(_sqlNewsQuery.findById, [id]);
    return result.affectedRows == 0 ? null : NewsModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(NewsModel value) async {
    var result = await _dbConfiguration.execQuery(_sqlNewsQuery.update, [value.title, value.description, value.id]);
    return result.affectedRows > 0;
  }
}
