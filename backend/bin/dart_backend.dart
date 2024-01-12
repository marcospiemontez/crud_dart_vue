import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/dependency_injector/injects.dart';
import 'infra/middleware_interception.dart';
import 'utils/dot_env_service.dart';

void main() async {
  final service = DotEnvService.instance;

  final _di = Injects.initialize();

  var cascadeHandler = Cascade()
      .add(_di.getInstance<LoginApi>().getHandler())
      .add(_di.getInstance<BlogApi>().getHandler(isSecurity: true))
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadeHandler);

  String? serverAddress;
  int? serverPort;
  serverAddress = service["server_address"] as String;
  serverPort = int.parse(service["server_port"] as String);

  await CustomServer().initialize(handler: handler, address: serverAddress, port: serverPort);
}
