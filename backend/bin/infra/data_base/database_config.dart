import '../../utils/dot_env_service.dart';

class DatabaseConfig {
  final String serverAddress;
  final int serverPort;
  final String dbHost;
  final int dbPort;
  final String dbUser;
  final String dbPass;
  final String dbSchema;

  DatabaseConfig({
    required this.serverAddress,
    required this.serverPort,
    required this.dbHost,
    required this.dbPort,
    required this.dbUser,
    required this.dbPass,
    required this.dbSchema,
  });

  factory DatabaseConfig.fromDotEnv(DotEnvService service) {
    return DatabaseConfig(
      serverAddress: service["server_address"] as String,
      serverPort: int.parse(service["server_port"] as String),
      dbHost: service["db_host"] as String,
      dbPort: int.parse(service["db_port"] as String),
      dbUser: service["db_user"] as String,
      dbPass: service["db_pass"] as String,
      dbSchema: service["db_schema"] as String,
    );
  }
}
