import 'package:shelf/shelf.dart';
import 'controllers/login_controller.dart';
import 'controllers/news_controller.dart';
import 'controllers/user_controller.dart';
import 'infra/dependency_injector/injects.dart';

class CascadeHandler {
  final _di = Injects.initialize();

  Handler build() {
    return Cascade()
        .add(_di.getInstance<LoginController>().getHandler())
        .add(_di.getInstance<NewsController>().getHandler(isSecurity: true))
        .add(_di.getInstance<UserController>().getHandler(isSecurity: true))
        .handler;
  }
}
