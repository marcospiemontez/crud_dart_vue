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

    router.get('/news/findAll', (Request req) async {
      List<NewsModel> news = await _service.findAll();
      List<Map> newsMap = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(newsMap));
    });

    router.get('/news/findById', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      
      var news = await _service.findById(int.parse(id));

      if (news == null) return Response(400);

      return Response.ok(jsonEncode(news.toJson()));
    });

    router.post('/news', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.put('/news', (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(200) : Response(500);
    });

    router.delete('/news', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _service.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
