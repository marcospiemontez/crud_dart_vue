import '../dto/news_dto.dart';
import 'controller.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/news_model.dart';
import '../services/generic_service.dart';

class NewsController extends Controller {
  final GenericService<NewsModel> _newsService;

  NewsController(this._newsService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post('/news', (Request req) async {
      var body = await req.readAsString();
      var dto = NewsDTO.fromRequest(jsonDecode(body));

      var newsModel = NewsModel()
        ..id = dto.id
        ..title = dto.title
        ..description = dto.description
        ..userId = dto.userId;

      var result = await _newsService.save(newsModel);
      return result ? Response(201) : Response(500);
    });

    router.get('/news/findAll', (Request req) async {
      List<NewsModel> news = await _newsService.findAll();
      List<Map> newsMap = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(newsMap));
    });

    router.get('/news/findById', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var news = await _newsService.findById(int.parse(id));

      if (news == null) return Response(400);

      return Response.ok(jsonEncode(news.toJson()));
    });

    router.put('/news', (Request req) async {
      var body = await req.readAsString();
      var dto = NewsDTO.fromRequest(jsonDecode(body));

      var newsModel = NewsModel()
        ..id = dto.id
        ..title = dto.title
        ..description = dto.description
        ..userId = dto.userId;

      var result = await _newsService.save(newsModel);
      return result ? Response(200) : Response(500);
    });

    router.delete('/news', (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);

      var result = await _newsService.delete(int.parse(id));
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(router: router, middlewares: middlewares);
  }
}
