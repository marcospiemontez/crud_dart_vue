import '../../apis/blog_api.dart';
import '../../apis/login_api.dart';
import '../../models/news_model.dart';
import '../../services/generic_service.dart';
import '../../services/news_service.dart';
import '../../utils/app_config.dart';
import '../../utils/environment_config.dart';
import '../database/db_configuration.dart';
import '../database/mysql_db_configuration.dart';
import '../security/security_service.dart';
import '../security/security_service_imp.dart';
import 'dependency_injector.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<DBConfiguration>(() => MySqlDBConfiguration());
    di.register<EnvironmentConfig>(() => AppConfig());

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginApi>(() => LoginApi(di.getInstance()));

    di.register<GenericService<NewsModel>>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di.getInstance()));

    return di;
  }
}
