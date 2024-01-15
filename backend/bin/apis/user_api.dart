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
      String body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      UserModel user = UserModel.fromRequest(jsonDecode(body));
      bool result = await _userService.save(user);
      return result ? Response(200) : Response(500);
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
