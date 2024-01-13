import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/database/db_configuration.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'models/user_model.dart';
import 'utils/app_config.dart';

void main() async {
  final _di = Injects.initialize();
  final envConfig = AppConfig();

  var connection = await _di.getInstance<DBConfiguration>().connection;
  var result = await connection.query('SELECT * FROM users');

  for (ResultRow r in result) {
    UserModel user = UserModel.fromMap(r.fields);
    print(user.toString());
  }

  var cascadeHandler = Cascade()
      .add(_di.getInstance<LoginApi>().getHandler())
      .add(_di.getInstance<BlogApi>().getHandler(isSecurity: true))
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(handler: handler, address: envConfig.serverAddress, port: envConfig.serverPort);
}
