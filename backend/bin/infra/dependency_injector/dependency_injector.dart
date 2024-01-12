typedef T InstanceCreator<T>();

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;

  // constructor
  _InstanceGenerator(this._instanceCreator, bool isSingleton) : _isFirstGet = isSingleton;

  T getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }

    return _instance as T;
  }
}

class DependencyInjector {
  DependencyInjector._();

  static final DependencyInjector _singleton = DependencyInjector._();

  factory DependencyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  void register<T extends Object>(InstanceCreator<T> instance, {bool isSingleton = false}) =>
      _instanceMap[T] = _InstanceGenerator(instance, isSingleton);

  T getInstance<T extends Object>() {
    final instanceGenerator = _instanceMap[T];
    if (instanceGenerator != null) {
      final instance = instanceGenerator.getInstance();
      if (instance != null && instance is T) return instance;
    }

    throw Exception("[Error] -> Instance of type ${T.toString()} not found in DependencyInjector.");
  }
}
