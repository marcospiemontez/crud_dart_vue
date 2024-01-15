import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/news_model.dart';
import '../services/generic_service.dart';
import 'api.dart';

class NewsApi extends Api {
  final GenericService<NewsModel> _service;

  NewsApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get('/news', (Request req) async {
      List<NewsModel> news = await _service.findAll();
      List<Map> newsMap = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(newsMap));
    });

    router.post('/news', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.put('/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Rain Today');
    });

    router.delete('/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Rain Today');
    });

    return createHandler(router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
