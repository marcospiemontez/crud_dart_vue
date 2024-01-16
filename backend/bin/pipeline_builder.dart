import 'package:shelf/shelf.dart';
import 'cascade_handler.dart';
import 'infra/middleware_interception.dart';

class PipelineBuilder {
  Handler build() {
    final cascadeHandlerBuilder = CascadeHandler();
    final cascadeHandler = cascadeHandlerBuilder.build();

    return Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(MInterception.contentTypeJson)
        .addMiddleware(MInterception.cors)
        .addHandler(cascadeHandler);
  }
}
