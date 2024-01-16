abstract class GenericService<T> {
  Future<T?> findById(int id);

  Future<List<T>> findAll();

  Future<bool> save(T value);

  Future<bool> delete(int id);
}
