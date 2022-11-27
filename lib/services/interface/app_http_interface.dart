import 'package:mdntls/model/group/remove_user_group_model.dart';

import '/model/group/get_my_group_list_info.dart';
import '/model/group/get_my_group_list_model.dart';
import '/model/group/add_user_to_group_model.dart';

import '/model/group/create_group_request_model.dart';
import '/model/group/create_group_response.dart';
import '/model/group/get_group_post_request_model.dart';
import '/model/profile/group_profile_info.dart';
import '/model/profile/put_follower_data.dart';
import '/model/posts/add_post_model.dart';
import '../data_layer.dart';
import '/model/posts/get_user_post_model.dart';

abstract class AppHttpInterface {
  Future<DataLayer<List<GetUserPostModel?>?>> getFollowedUsersPosts({
    int limit = 100,
  });

  Future<DataLayer<List<GetUserPostModel?>?>> getMyPosts();

  Future<DataLayer<bool>> addPost(AddPostModel model);

  Future<DataLayer<UserProfileInfoModel?>> getMyProfileInfo();

  Future<DataLayer<bool>> putMyProfileInfo(UserProfileInfoModel model);

  Future<DataLayer<bool>> putFollowerData(PutFollowerDataModel model);

  Future<DataLayer<CreateGroupResponseModel>> postCreateGroup(
    CreateGroupRequestModel model,
  );

  Future<DataLayer<bool>> putAddUserToGroup(AddUserToGroupModel model);

  Future<DataLayer<List<GetUserPostModel?>?>> getGroupPost(
      GetGroupPostRequestModel model);

  Future<DataLayer<List<GetMyGroupListModel?>?>> getMyGroupList();

  Future<DataLayer<List<MyGroupListInfo?>?>> getMyGroupListInfo(String groupId);

  Future<DataLayer<bool?>> putRemoveUserToGroup(UserGroupModel model);
}
