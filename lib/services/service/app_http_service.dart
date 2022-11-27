import 'package:dio/dio.dart';
import '/model/group/get_my_group_list_info.dart';
import '/model/group/remove_user_group_model.dart';
import '/model/group/get_group_post_request_model.dart';
import '/model/group/get_my_group_list_model.dart';
import '/model/group/create_group_response.dart';
import '/model/group/add_user_to_group_model.dart';
import '/model/group/create_group_request_model.dart';
import '/model/profile/put_follower_data.dart';
import '/model/profile/group_profile_info.dart';
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

  @override
  Future<DataLayer<UserProfileInfoModel?>> getMyProfileInfo() async {
    Response<dynamic> response = await dio.get(
      ServiceUrl.BASE_URL + ServiceUrl.PROFILE + ServiceUrl.MY_PROFILE,
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
      data: UserProfileInfoModel.fromJson(response.data),
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<bool>> putMyProfileInfo(UserProfileInfoModel model) async {
    throw UnimplementedError();
  }

  @override
  Future<DataLayer<bool>> putFollowerData(PutFollowerDataModel model) async {
    Response<dynamic> response = await dio.put(
      ServiceUrl.BASE_URL + ServiceUrl.PROFILE + ServiceUrl.FOLLOWER_DATA,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
      data: model,
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
      data: response.data,
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<bool>> putAddUserToGroup(AddUserToGroupModel model) async {
    Response<dynamic> response = await dio.put(
      ServiceUrl.BASE_URL + ServiceUrl.GROUP + ServiceUrl.ADD_USER_TO_GROUP,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
      data: model,
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
      data: response.data,
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<CreateGroupResponseModel>> postCreateGroup(
    CreateGroupRequestModel model,
  ) async {
    FormData formData = FormData.fromMap({
      "fileName": await MultipartFile.fromFile(
        model.file.path,
        filename: DateTime.now().millisecondsSinceEpoch.toString() + ".png",
      ),
      "groupName": model.groupName
    });

    Response<dynamic> response = await dio.post(
      ServiceUrl.BASE_URL + ServiceUrl.GROUP + ServiceUrl.CREATE_GROUP,
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
        data: null,
      );
    }

    return DataLayer(
      data: CreateGroupResponseModel.fromJson(response.data),
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getGroupPost(
      GetGroupPostRequestModel model) async {
    Response<dynamic> response = await dio.post(
      ServiceUrl.BASE_URL + ServiceUrl.USER_POSTS + ServiceUrl.GROUP_POSTS,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
      data: model.toMap(),
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
  Future<DataLayer<List<GetMyGroupListModel?>?>> getMyGroupList() async {
    Response<dynamic> response = await dio.get(
      ServiceUrl.BASE_URL + ServiceUrl.GROUP + ServiceUrl.MY_GROUP_LIST,
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
          .map((x) => GetMyGroupListModel.fromJson(x))
          .toList(),
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<List<MyGroupListInfo?>?>> getMyGroupListInfo(
      String groupId) async {
    Response<dynamic> response = await dio.get(
      ServiceUrl.BASE_URL + ServiceUrl.GROUP + ServiceUrl.MY_GROUP_LIST_INFO,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
      queryParameters: {
        "groupId": groupId,
      },
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
          .map((x) => MyGroupListInfo.fromJson(x))
          .toList(),
      status: DataStatus.SUCCESS,
    );
  }

  @override
  Future<DataLayer<bool?>> putRemoveUserToGroup(UserGroupModel model) async {
    Response<dynamic> response = await dio.put(
      ServiceUrl.BASE_URL + ServiceUrl.GROUP + ServiceUrl.REMOVE_USERS_TO_GROUP,
      options: Options(
        headers: {
          "authorization":
              "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
        },
        validateStatus: (status) => true,
      ),
      data: model.toJson(),
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
      data: response.data,
      status: DataStatus.SUCCESS,
    );
  }
}
