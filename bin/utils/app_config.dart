import 'dart:io';

import 'environment_config.dart';
import './parser_extension.dart';

class AppConfig implements EnvironmentConfig {
  final Map<String, String> _config;

  AppConfig() : _config = _loadConfig();

  static Map<String, String> _loadConfig() {
    final config = <String, String>{};
    final file = File('.env');

    if (file.existsSync()) {
      final lines = file.readAsLinesSync();
      for (final line in lines) {
        final parts = line.split('=');
        if (parts.length == 2) {
          config[parts[0].trim()] = parts[1].trim();
        }
      }
    }

    return config;
  }

  @override
  String get dbHost => _config['DB_HOST'] as String;

  @override
  int get dbPort => _config['DB_PORT']?.toType(int);

  @override
  String get dbUser => _config['DB_USER'] as String;

  @override
  String get dbPass => _config['DB_PASS'] as String;

  @override
  String get dbSchema => _config['DB_SCHEMA'] as String;

  @override
  String get jwtKey => _config['JWT_KEY'] as String;

  @override
  String get serverAddress => _config['SERVER_ADDRESS']as String;

  @override
  int get serverPort => _config['SERVER_PORT']?.toType(int);
}
