import 'package:mysql1/mysql1.dart';

import '../../utils/app_config.dart';
import 'db_configuration.dart';

class MySqlDBConfiguration implements DBConfiguration {
  final envConfig = AppConfig();
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    _connection ??= throw Exception('[ERROR/DB] -> Failed Create Connection from DB');

    return _connection!;
  }

  @override
  Future<MySqlConnection> createConnection() async {
    return await MySqlConnection.connect(ConnectionSettings(
      host: envConfig.dbHost,
      port: envConfig.dbPort,
      user: envConfig.dbUser,
      password: envConfig.dbPass,
      db: envConfig.dbSchema,
    ));
  }
}
