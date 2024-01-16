abstract class Repository<T> {
  Future<bool> create(T value);

  Future<T?> findById(int id);

  Future<List<T>> findAll();

  Future<bool> update(T value);

  Future<bool> delete(int id);
}
