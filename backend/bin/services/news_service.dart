import '../dao/news_dao.dart';
import '../models/news_model.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final NewsDao _newsDao;
  NewsService(this._newsDao);

  @override
  Future<bool> delete(int id) async {
    _newsDao.delete(id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return await _newsDao.findAll();
  }

  @override
  Future<NewsModel?> findById(int id) async {
    return await _newsDao.findById(id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    Future<bool> result;
    if (value.id != null) {
      result = _newsDao.update(value);
    } else {
      return await _newsDao.create(value);
    }

    return result;
  }
}
