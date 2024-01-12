import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({List<Middleware> middlewares = const []});

  Handler createHandler({required Handler router, List<Middleware> middlewares = const []}) {
    final _di = DependencyInjector();
    var _securityService = _di.getInstance<SecurityService>();

    var pipe = Pipeline();
    for (var middleware in middlewares) {
      pipe = pipe.addMiddleware(middleware);
    }

    return pipe.addHandler(router);
  }
}
