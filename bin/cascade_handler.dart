import 'package:shelf/shelf.dart';
import 'controllers/login_controller.dart';
import 'controllers/todos_controller.dart';
import 'controllers/user_controller.dart';
import 'controllers/user_registration_controller.dart';
import 'infra/dependency_injector/injects.dart';

class CascadeHandler {
  final _di = Injects.initialize();

  Handler build() {
    return Cascade()
        .add(_di.get<LoginController>().getHandler())
        .add(_di.get<UserRegistrationController>().getHandler())
        .add(_di.get<UserController>().getHandler(isSecurity: true))
        .add(_di.get<TodosController>().getHandler(isSecurity: true))
        .handler;
  }
}
