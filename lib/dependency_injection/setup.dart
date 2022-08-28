import 'package:get_it/get_it.dart';
import '/view/add_post/add_post_view_model.dart';
import '/util/constants.dart';
import '/view/login/login_viewmodel.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Constants>(() => Constants());
  getIt.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  getIt.registerLazySingleton<AddPostViewModel>(() => AddPostViewModel());
}
