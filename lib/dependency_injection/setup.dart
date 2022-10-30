import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mdntls/services/repo/app_http_repository.dart';
import 'package:mdntls/services/service/app_http_service.dart';
import 'package:mdntls/view/home/home_view_model.dart';
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
  getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel());


  getIt.registerFactory<PermissionUtil>(() => PermissionUtil());

  //Service
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepository());
  getIt.registerLazySingleton<LoginService>(() => LoginService());

  getIt.registerLazySingleton<AppHttpRepository>(() => AppHttpRepository());
  getIt.registerLazySingleton<AppHttpService>(() => AppHttpService());

  getIt.registerLazySingleton<Dio>(() => Dio());

  //Util
  getIt.registerFactory<SharedPreferencesUtil>(() => SharedPreferencesUtil());
}
