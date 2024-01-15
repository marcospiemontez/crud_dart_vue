import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import 'api.dart';

class UserApi extends Api {
  final UserService _userService;

  UserApi(this._userService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/user', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      var user = UserModel.fromRequest(jsonDecode(body));
      var result = await _userService.save(user);
      return result ? Response(201) : Response(500);
    });

    router.get('/users', (Request req) async {
      List<UserModel> news = await _userService.findAll();
      List<Map> newsMap = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(newsMap));
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
