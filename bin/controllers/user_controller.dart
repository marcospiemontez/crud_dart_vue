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

    router.get('/users/findAll', (Request req) async {
      List<UserModel> users = await _userService.findAll();
      List<Map> userMap = users.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(userMap));
    });

    router.get('/user/findById', (Request req) async {
      String? userId = req.url.queryParameters['id'];
      if (userId == null) return Response(400);

      var user = await _userService.findById(int.parse(userId));

      if (user == null) return Response(400);

      return Response.ok(jsonEncode(user.toJson()));
    });

    router.get('/user', (Request req) async {
      String? userId = req.url.queryParameters['id'];
      String? userEmail = req.url.queryParameters['email'];
      if (userId == null || userEmail == null) return Response(404, body: "Id and email not found");

      var user = await _userService.findByIdAndEmail(int.parse(userId), userEmail);

      if (user == null) return Response(404, body: "User not found");

      return Response.ok(jsonEncode(user.toJson()));
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
