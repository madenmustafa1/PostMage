import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '/services/repo/login_repository.dart';
import '/services/service/login_service.dart';
import '/util/shared_preferences.dart';
import '/util/permission_util.dart';
import '/view/add_post/add_post_view_model.dart';
import '/util/constants.dart';
import '/view/login/login_viewmodel.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Constants>(() => Constants());
  getIt.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  getIt.registerLazySingleton<AddPostViewModel>(() => AddPostViewModel());

  getIt.registerFactory<PermissionUtil>(() => PermissionUtil());

  //Service
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<LoginService>(() => LoginService());
  getIt.registerLazySingleton<Dio>(() => Dio());

  //Util
  getIt.registerFactory<SharedPreferencesUtil>(() => SharedPreferencesUtil());
}
