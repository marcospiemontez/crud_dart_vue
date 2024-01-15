import '../models/news_model.dart';
import '../utils/list_extension.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final List<NewsModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<NewsModel> findById(int id) async {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    NewsModel? model = _fakeDB.firstWhereOrNull((e) => e.id == value.id);
    if (model == null) {
      _fakeDB.add(value);
    } else {
      int index = _fakeDB.indexOf(model);
      _fakeDB[index] = value;
    }

    return true;
  }
}
