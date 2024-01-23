import '../../controllers/login_controller.dart';
import '../../controllers/todos_controller.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/user_registration_controller.dart';
import '../../models/todos_model.dart';
import '../../repositories/todos_repository.dart';
import '../../repositories/user_repository.dart';
import '../../services/generic_service.dart';
import '../../services/login_service.dart';
import '../../services/todos_service.dart';
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

    di.register<TodosRepository>(() => TodosRepository(di.get<DBConfiguration>()));

    di.register<GenericService<TodosModel>>(() => TodosService(di.get<TodosRepository>()));

    di.register<TodosController>(() => TodosController(di.get<GenericService<TodosModel>>()));

    di.register<UserRepository>(() => UserRepository(di.get<DBConfiguration>()));

    di.register<UserService>(() => UserService(di.get<UserRepository>()));

    di.register<UserRegistrationController>(() => UserRegistrationController(di.get<UserService>()));

    di.register<UserController>(() => UserController(di.get<UserService>()));

    di.register<LoginService>(() => LoginService(di.get<UserService>()));

    di.register<LoginController>(() => LoginController(di.get<SecurityService>(), di.get<LoginService>()));

    return di;
  }
}
