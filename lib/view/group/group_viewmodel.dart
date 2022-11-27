import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:mdntls/util/constants.dart';
import '../../model/group/get_my_group_list_info.dart';
import '/model/group/get_my_group_list_model.dart';
import '/model/group/get_group_post_request_model.dart';
import '/model/group/create_group_request_model.dart';
import '/model/group/create_group_response.dart';
import '/model/posts/get_user_post_model.dart';
import '/model/profile/group_profile_info.dart';
import '/services/data_layer.dart';
import '/model/group/add_user_to_group_model.dart';
import '/services/repo/app_http_repository.dart';
import '/util/app_user.dart';
import '/dependency_injection/setup.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../model/group/remove_user_group_model.dart';

class GroupViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();
  final Constants _constants = getIt<Constants>();

  Future<DataLayer<CreateGroupResponseModel?>> createGroup(
      String text, XFile? pickedFile) async {
    if (pickedFile == null) {
      return DataLayer(
        errorData: ErrorData(
          reason: "Fotoğraf boş olamaz.",
          statusCode: DataStatus.FAILED,
        ),
        status: DataStatus.FAILED,
      );
    }
    File file = File(pickedFile.path);
    return _appHttpRepository
        .postCreateGroup(CreateGroupRequestModel(file: file, groupName: text));
  }

  Future<DataLayer<List<GetUserPostModel?>?>> getGroupPost(
    UserProfileInfoModel _userProfileModel,
  ) async {
    List<String> list = [];
    _userProfileModel.groups?.forEach((element) {
      if (element?.groupId != null) {
        list.add(element!.groupId!);
      }
    });

    return await _appHttpRepository
        .getGroupPost(GetGroupPostRequestModel(groupId: list));
  }

  void addUserToGroup() async {
    var model = AddUserToGroupModel(
      id: AppUser.LOGIN_TOKEN_MODEL!.userId!,
      groupId: "6351a835d35d134785c6720f",
    );
    var result = await _appHttpRepository.putAddUserToGroup(model);
    debugPrint(result.data.toString());
  }

  Future<DataLayer<List<GetMyGroupListModel?>?>> getMyGroupList() async {
    try {
      return await _appHttpRepository.getMyGroupList();
    } catch (e) {
      return DataLayer(
        errorData: ErrorData(
          reason: _constants.TR_GENERAL_ERROR,
          statusCode: DataStatus.ERROR,
        ),
        status: DataStatus.ERROR,
      );
    }
  }

  Future<DataLayer<Bool?>> makeUserAdmin() async {
    return DataLayer(
      errorData: ErrorData(
        reason: _constants.TR_GENERAL_ERROR,
        statusCode: DataStatus.ERROR,
      ),
      status: DataStatus.ERROR,
    );
  }

  Future<DataLayer<List<MyGroupListInfo?>?>> getMyGroupListInfo(
    String groupId,
  ) async {
    try {
      return await _appHttpRepository.getMyGroupListInfo(groupId);
    } catch (e) {
      return DataLayer(
        errorData: ErrorData(
          reason: _constants.TR_GENERAL_ERROR,
          statusCode: DataStatus.ERROR,
        ),
        status: DataStatus.ERROR,
      );
    }
  }

  Future<DataLayer<bool?>> putRemoveUserToGroup(UserGroupModel model) async {
    try {
      return await _appHttpRepository.putRemoveUserToGroup(model);
    } catch (e) {
      return DataLayer(
        errorData: ErrorData(
          reason: _constants.TR_GENERAL_ERROR,
          statusCode: DataStatus.ERROR,
        ),
        status: DataStatus.ERROR,
      );
    }
  }
}
