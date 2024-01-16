import '../../controllers/login_controller.dart';
import '../../controllers/news_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/news_model.dart';
import '../../repositories/news_repository.dart';
import '../../repositories/user_repository.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
import '../../services/news_service.dart';
import '../../services/user_service.dart';
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

    di.register<NewsRepository>(() => NewsRepository(di.getInstance<DBConfiguration>()));

    di.register<GenericService<NewsModel>>(() => NewsService(di.getInstance<NewsRepository>()));

    di.register<NewsController>(() => NewsController(di.getInstance<GenericService<NewsModel>>()));

    di.register<UserRepository>(() => UserRepository(di.getInstance<DBConfiguration>()));

    di.register<UserService>(() => UserService(di.getInstance<UserRepository>()));

    di.register<UserController>(() => UserController(di.getInstance<UserService>()));

    di.register<LoginService>(() => LoginService(di.getInstance<UserService>()));

    di.register<LoginController>(
        () => LoginController(di.getInstance<SecurityService>(), di.getInstance<LoginService>()));

    return di;
  }
}
