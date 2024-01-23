import '../models/todos_model.dart';
import '../repositories/todos_repository.dart';
import 'generic_service.dart';

class TodosService implements GenericService<TodosModel> {
  final TodosRepository _todosRepository;

  TodosService(this._todosRepository);

  @override
  Future<bool> delete(int id) async {
    _todosRepository.delete(id);
    return true;
  }

  @override
  Future<List<TodosModel>> findAll() async {
    return await _todosRepository.findAll();
  }

  @override
  Future<TodosModel?> findById(int id) async {
    return await _todosRepository.findById(id);
  }

  @override
  Future<bool> save(TodosModel value) async {
    Future<bool> result;
    if (value.id != null) {
      result = _todosRepository.update(value);
    } else {
      return await _todosRepository.create(value);
    }

    return result;
  }
}
