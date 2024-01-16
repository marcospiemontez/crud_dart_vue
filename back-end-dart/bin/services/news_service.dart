import '../models/news_model.dart';
import '../repositories/news_repository.dart';
import 'generic_service.dart';

class NewsService implements GenericService<NewsModel> {
  final NewsRepository _newsRepository;

  NewsService(this._newsRepository);

  @override
  Future<bool> delete(int id) async {
    _newsRepository.delete(id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return await _newsRepository.findAll();
  }

  @override
  Future<NewsModel?> findById(int id) async {
    return await _newsRepository.findById(id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    Future<bool> result;
    if (value.id != null) {
      result = _newsRepository.update(value);
    } else {
      return await _newsRepository.create(value);
    }

    return result;
  }
}
