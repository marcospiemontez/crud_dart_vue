import 'package:password_dart/password_dart.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import 'generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  @override
  Future<bool> delete(int id) async => _userRepository.delete(id);

  @override
  Future<List<UserModel>> findAll() => _userRepository.findAll();

  @override
  Future<UserModel?> findById(int id) async => _userRepository.findById(id);

  @override
  Future<bool> save(UserModel value) async {
    Future<bool> result;
    if (value.id != null) {
      result = _userRepository.update(value);
    } else {
      final hash = Password.hash(value.password!, PBKDF2());
      value.password = hash;
    }
    return _userRepository.create(value);
  }

  Future<UserModel?> findByEmail(String email) async => _userRepository.findByEmail(email);

  Future<UserModel?> findByIdAndEmail(int id, String email) async {
    return _userRepository.findByIdAndEmail(id, email);
  }
}
