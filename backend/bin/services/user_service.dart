import '../dao/user_dao.dart';
import '../models/user_model.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {

  final UserDAO _userDAO;
  UserService(this._userDAO);

  @override
  Future<bool> delete(int id) async => _userDAO.delete(id);

  @override
  Future<List<UserModel>> findAll() => _userDAO.findAll();

  @override
  Future<UserModel?> findById(int id) async => _userDAO.findById(id);

  @override
  Future<bool> save(UserModel value) async {
    Future<bool> result;
    if (value.id != null) {
      result = _userDAO.update(value);
    } else {
      result = _userDAO.create(value);
    }
    return result;
  }
}
