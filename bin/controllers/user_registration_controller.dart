import '../dto/user_dto.dart';
import 'controller.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserRegistrationController extends Controller {
  final UserService _userService;

  UserRegistrationController(this._userService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post('/create-user', (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);

      var userDTo = UserDTO.fromRequest(jsonDecode(body));
      var userModel = UserModel()
        ..name = userDTo.name
        ..email = userDTo.email
        ..password = userDTo.password;

      var result = await _userService.save(userModel);
      return result ? Response(201) : Response(500);
    });

    return createHandler(router: router, isSecurity: isSecurity, middlewares: middlewares);
  }
}
