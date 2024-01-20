import "package:shelf/shelf.dart";

class MInterception {
  static Middleware get contentTypeJson => createMiddleware(
        responseHandler: (Response res) => res.change(headers: {
          "content-type": "application/json",
        }),
      );

  static Middleware get cors {
    final allowedHeaders = {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Authorization, Content-Type",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
    };

    Response? headerOptions(Request req) {
      if (req.method == 'OPTIONS') {
        return Response(200, headers: allowedHeaders);
      } else {
        return null;
      }
    }

    Response addCorsHeaders(Response res) => res.change(headers: allowedHeaders);

    return createMiddleware(
      requestHandler: headerOptions,
      responseHandler: addCorsHeaders,
    );
  }
}
