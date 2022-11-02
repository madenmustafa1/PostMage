import 'package:dio/dio.dart';
import '/model/posts/add_post_model.dart';
import '/util/app_user.dart';
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
      ServiceUrl.BASE_URL +
          ServiceUrl.USER_POSTS +
          ServiceUrl.FOLLOWED_USERS_POSTS,
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

    return DataLayer(
      data: (response.data as List)
          .map((x) => GetUserPostModel.fromJson(x))
          .toList(),
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<bool>> addPost(AddPostModel model) async {
    FormData formData = FormData.fromMap({
      "fileName": await MultipartFile.fromFile(
        model.file.path,
        filename: DateTime.now().millisecondsSinceEpoch.toString() + ".png",
      ),
      "description": model.description,
      "groupId": model.groupId
    });

    Response<dynamic> response = await dio.post(
      ServiceUrl.BASE_URL + ServiceUrl.USER_POSTS + ServiceUrl.ADD_POSTS,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
      data: formData,
    );

    if (response.statusCode != ServiceUrl.SUCCESS) {
      return DataLayer(
        errorData: ErrorData(
          reason: response.data.toString(),
          statusCode: DataStatus.FAILED,
        ),
        status: DataStatus.FAILED,
        data: false,
      );
    }

    return DataLayer(
      data: true,
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getMyPosts() async {
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

    return DataLayer(
      data: (response.data as List)
          .map((x) => GetUserPostModel.fromJson(x))
          .toList(),
      status: DataStatus.SUCCESS,
    );
  }
}
