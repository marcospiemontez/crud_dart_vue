import 'controller.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserController extends Controller {
  final UserService _userService;

  UserController(this._userService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.get('/users', (Request req) async {
      List<UserModel> users = await _userService.findAll();
      List<Map> userMap = users.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(userMap));
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
