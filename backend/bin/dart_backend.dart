import 'package:shelf/shelf.dart';
import 'api/blog_api.dart';
import 'api/login_api.dart';
import 'infra/custom_server.dart';

void main() async {
  var cascadeHandler = Cascade()
      .add(LoginApi().handler).add(BlogApi().handler).handler;

  await CustomServer().initialize(cascadeHandler);
}
