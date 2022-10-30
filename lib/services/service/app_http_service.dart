import 'package:dio/dio.dart';
import 'package:mdntls/util/app_user.dart';

import '../data_layer.dart';
import '../service_url.dart';
import '/dependency_injection/setup.dart';
import '/util/shared_preferences.dart';
import '/model/posts/get_user_post_model.dart';
import '/services/interface/app_http_interface.dart';

class AppHttpService implements AppHttpInterface {
  final Dio dio = getIt<Dio>();
  final SharedPreferencesUtil preferencesUtil = getIt<SharedPreferencesUtil>();

  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getFollowedUsersPosts({
    int limit = 100,
  }) async {
    Response<dynamic> response = await dio.get(
      ServiceUrl.BASE_URL + ServiceUrl.USER_POSTS + ServiceUrl.MY_POSTS,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
    );

    if (response.statusCode != ServiceUrl.SUCCESS) {
      return DataLayer(
        errorData: ErrorData(
          reason: response.data.toString(),
          statusCode: DataStatus.FAILED,
        ),
        status: DataStatus.FAILED,
      );
    }

//GetUserPostModel.fromJson(response.data);
    return DataLayer(
      data: (response.data as List)
          .map((x) => GetUserPostModel.fromJson(x))
          .toList(),
      status: DataStatus.SUCCESS,
    );
  }
}
