import 'package:shelf/shelf.dart';
import 'apis/news_api.dart';
import 'apis/login_api.dart';
import 'apis/user_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/app_config.dart';

void main() async {
  final _di = Injects.initialize();
  final envConfig = AppConfig();

  var cascadeHandler = Cascade()
      .add(_di.getInstance<LoginApi>().getHandler())
      .add(_di.getInstance<NewsApi>().getHandler(isSecurity: true))
      .add(_di.getInstance<UserApi>().getHandler(isSecurity: true))
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MInterception.contentTypeJson)
      .addMiddleware(MInterception.cors)
      .addHandler(cascadeHandler);

  await CustomServer().initialize(handler: handler, address: envConfig.serverAddress, port: envConfig.serverPort);
}
