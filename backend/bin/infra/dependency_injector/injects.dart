import '../../apis/news_api.dart';
import '../../apis/login_api.dart';
import '../../apis/user_api.dart';
import '../../dao/news_dao.dart';
import '../../dao/user_dao.dart';
import '../../models/news_model.dart';
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

    di.register<NewsDao>(() => NewsDao(di.getInstance<DBConfiguration>()));

    di.register<GenericService<NewsModel>>(() => NewsService(di.getInstance<NewsDao>()));

    di.register<NewsApi>(() => NewsApi(di.getInstance<GenericService<NewsModel>>()));

    di.register<UserDAO>(() => UserDAO(di.getInstance<DBConfiguration>()));

    di.register<UserService>(() => UserService(di.getInstance<UserDAO>()));

    di.register<UserApi>(() => UserApi(di.getInstance<UserService>()));

    di.register<LoginService>(() => LoginService(di.getInstance<UserService>()));

    di.register<LoginApi>(() => LoginApi(di.getInstance<SecurityService>(), di.getInstance<LoginService>()));

    return di;
  }
}
