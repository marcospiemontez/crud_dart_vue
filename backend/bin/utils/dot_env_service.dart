import 'dart:io';
import 'parser_extension.dart';

class DotEnvService {
  final Map<String, String> _map = {};
  static DotEnvService instance = DotEnvService._();

  DotEnvService._() {
    _init();
  }

  Future<void> _init() async {
    final file = File(".env");
    final envText = file.readAsStringSync();

    for (var line in envText.split('\n')) {
      final lineBreak = line.split("=");
      if (lineBreak.length == 2) {
        _map[lineBreak[0]] = lineBreak[1];
      }
    }
  }

  Future<T> get<T>({required String key}) async {
    if (_map.isEmpty) await _init();
    return _map[key]!.toType(T);
  }

  String? operator [](String key) {
    return _map[key];
  }
}
