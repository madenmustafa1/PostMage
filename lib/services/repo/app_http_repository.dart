import 'dart:io';

import 'package:mdntls/model/posts/update_post_model.dart';

import '../../model/group/remove_user_group_model.dart';
import '../../model/profile/get_follower_data.dart';
import '/model/group/get_my_group_list_info.dart';
import '/model/group/get_my_group_list_model.dart';
import '/model/group/get_group_post_request_model.dart';
import '/model/group/create_group_response.dart';
import '/model/group/create_group_request_model.dart';
import '/model/group/add_user_to_group_model.dart';
import '/model/profile/put_follower_data.dart';
import '/model/profile/group_profile_info.dart';
import '/model/posts/add_post_model.dart';
import '../data_layer.dart';
import '/dependency_injection/setup.dart';
import '../service/app_http_service.dart';
import '/model/posts/get_user_post_model.dart';
import '../interface/app_http_interface.dart';

class AppHttpRepository implements AppHttpInterface {
  final AppHttpService _appHttpService = getIt<AppHttpService>();

  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getFollowedUsersPosts({
    int limit = 100,
  }) async {
    return await _appHttpService.getFollowedUsersPosts(
      limit: limit,
    );
  }

  @override
  Future<DataLayer<bool>> addPost(AddPostModel model) async {
    return await _appHttpService.addPost(model);
  }

  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getMyPosts() async {
    return await _appHttpService.getMyPosts();
  }

  @override
  Future<DataLayer<UserProfileInfoModel?>> getMyProfileInfo() async {
    return await _appHttpService.getMyProfileInfo();
  }

  @override
  Future<DataLayer<bool>> putMyProfileInfo(UserProfileInfoModel model) async {
    return await _appHttpService.putMyProfileInfo(model);
  }

  @override
  Future<DataLayer<bool>> putFollowerData(PutFollowerDataModel model) async {
    return await _appHttpService.putFollowerData(model);
  }

  @override
  Future<DataLayer<bool>> putAddUserToGroup(AddUserToGroupModel model) async {
    return await _appHttpService.putAddUserToGroup(model);
  }

  @override
  Future<DataLayer<CreateGroupResponseModel>> postCreateGroup(
      CreateGroupRequestModel model) async {
    return await _appHttpService.postCreateGroup(model);
  }

  @override
  Future<DataLayer<List<GetUserPostModel?>?>> getGroupPost(
      GetGroupPostRequestModel model) async {
    return await _appHttpService.getGroupPost(model);
  }

  @override
  Future<DataLayer<List<GetMyGroupListModel?>?>> getMyGroupList() async {
    return await _appHttpService.getMyGroupList();
  }

  @override
  Future<DataLayer<List<MyGroupListInfo?>?>> getMyGroupListInfo(
    String groupId,
  ) async {
    return await _appHttpService.getMyGroupListInfo(groupId);
  }

  @override
  Future<DataLayer<bool?>> putRemoveUserToGroup(UserGroupModel model) async {
    return await _appHttpService.putRemoveUserToGroup(model);
  }

  @override
  Future<DataLayer<GetFollowerDataModel?>> getFollowerData() async {
    return await _appHttpService.getFollowerData();
  }

  @override
  Future<DataLayer<bool?>> putAddAdminToGroup(UserGroupModel model) async {
    return await _appHttpService.putAddAdminToGroup(model);
  }

  @override
  Future<DataLayer<GetUserPostModel?>> getPost(String postId) async {
    return await _appHttpService.getPost(postId);
  }

  @override
  Future<DataLayer<List<Comment>?>> getComments(String postId) async {
    return await _appHttpService.getComments(postId);
  }

  @override
  Future<DataLayer<bool>> putUpdatePost(UpdatePostModel model) async {
    return await _appHttpService.putUpdatePost(model);
  }

  @override
  Future<DataLayer<bool>> putMyProfilePhoto(File file) async {
    return await _appHttpService.putMyProfilePhoto(file);
  }

}
