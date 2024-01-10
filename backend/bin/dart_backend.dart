import 'package:shelf/shelf.dart';
import 'apis/blog_api.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'infra/middleware_interception.dart';
import 'services/news_service.dart';
import 'utils/dot_env_service.dart';

void main() async {
  var cascadeHandler = Cascade().add(LoginApi().handler).add(BlogApi(NewsService()).handler).handler;
  final service = DotEnvService.instance;
  var handler = Pipeline().addMiddleware(logRequests()).addMiddleware(MiddlewareInterception().middleware).addHandler(cascadeHandler);

  String? serverAddress;
  int? serverPort;
  serverAddress = service["server_address"] as String;
  serverPort = int.parse(service["server_port"] as String);

  await CustomServer().initialize(handler: handler, address: serverAddress, port: serverPort);
}
