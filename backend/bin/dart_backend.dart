import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/data_base/database_config.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/dot_env_service.dart';
import 'package:mysql1/mysql1.dart';

void main() async {
  final service = DotEnvService.instance;
  final dbConfig = DatabaseConfig.fromDotEnv(service);

  var connection = await MySqlConnection.connect(ConnectionSettings(
      host: dbConfig.dbHost,
      port: dbConfig.dbPort,
      user: dbConfig.dbUser,
      password: dbConfig.dbPass,
      db: dbConfig.dbSchema));

  var result = await connection.query('SELECT * FROM users');
  print(result);
  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.getInstance<LoginApi>().getHandler())
      .add(_di.getInstance<BlogApi>().getHandler(isSecurity: true))
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(handler: handler, address: dbConfig.serverAddress, port: dbConfig.serverPort);
}
