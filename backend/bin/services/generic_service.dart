abstract class GenericService<T> {
  T findById(int id);

  List<T> findAll();

  bool save(T value);

  bool delete(int id);
}
