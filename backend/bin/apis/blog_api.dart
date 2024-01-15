import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class BlogApi extends Api {
  final GenericService<NewsModel> _service;

  BlogApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/blog/news', (Request req) async {
      List<NewsModel> news = await _service.findAll();
      List<Map> newsMap = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(news));
    });

    router.post('/blog/news', (Request req) async {
      var body = await req.readAsString();
      _service.save(NewsModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    router.put('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save(value);
      return Response.ok('Rain Today');
    });

    router.delete('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.delete(1);
      return Response.ok('Rain Today');
    });

    return createHandler(router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
