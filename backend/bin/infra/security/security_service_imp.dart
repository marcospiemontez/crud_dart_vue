import "package:shelf/shelf.dart";
import "package:shelf/src/middleware.dart";

import "../../utils/dot_env_service.dart";
import "security_service.dart";
import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";

class SecurityServiceImp implements SecurityService<JWT> {
  final service = DotEnvService.instance;

  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      "iat": DateTime.now().millisecondsSinceEpoch,
      "userID": userID,
      "roles": ["admin", "user"],
    });

    String key = service["jwt_key"] as String;
    String token = jwt.sign(SecretKey(key));

    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = service["jwt_key"] as String;
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException {
      return null;
    } on JWTExpiredException {
      return null;
    } on JWTNotActiveException {
      return null;
    } on JWTUndefinedException {
      return null;
    } catch (e) {
      print('Erro ao validar o token JWT: $e');
      return null;
    }
  }

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers["Authorization"];
        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith("Bearer ")) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }

          var request = req.change(context: {"jwt": jwt});
          return handler(request);
        }

        return Response.forbidden("Authorization header missing or invalid");
      };
    };
  }

  @override
  Middleware get verifyJwt => createMiddleware(requestHandler: (Request req) {
        if (req.context["jwt"] == null) {
          return Response.forbidden("Unauthorized");
        }
        return null;
      });
}
