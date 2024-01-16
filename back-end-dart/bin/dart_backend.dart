import 'pipeline_builder.dart';
import 'utils/app_config.dart';
import 'infra/custom_server.dart';

void main() async {
  final envConfig = AppConfig();
  final pipelineBuilder = PipelineBuilder();

  var pipeline = pipelineBuilder.build();

  try {
    await CustomServer().initialize(
      handler: pipeline,
      address: envConfig.serverAddress,
      port: envConfig.serverPort,
    );
  } catch (e) {
    print('Error during server initialization: $e');
  }
}
