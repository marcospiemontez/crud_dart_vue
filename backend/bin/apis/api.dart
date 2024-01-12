import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware> middlewares = const []});

  Handler createHandler({
    required Handler router,
    List<Middleware> middlewares = const [],
  }) {
    var pipe = Pipeline();
    for (var middleware in middlewares) {
      pipe = pipe.addMiddleware(middleware);
    }

    return pipe.addHandler(router);
  }
}
