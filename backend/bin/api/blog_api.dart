import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  Handler get handler {
    Router router = Router();

    router.get('/blog/news', (Request req) {
      return Response.ok('Rain Today');
    });

    router.post('/blog/news', (Request req) {
      return Response.ok('Rain Today');
    });

    router.put('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Rain Today');
    });

    return router;
  }
}
