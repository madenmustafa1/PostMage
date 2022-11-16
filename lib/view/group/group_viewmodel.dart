import 'package:flutter/cupertino.dart';
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

class GroupViewModel {
  final AppHttpRepository _appHttpRepository = getIt<AppHttpRepository>();

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

  void addUserToGroup() async {
    var model = AddUserToGroupModel(
      id: AppUser.LOGIN_TOKEN_MODEL!.userId!,
      groupId: "6351a835d35d134785c6720f",
    );
    var result = await _appHttpRepository.putAddUserToGroup(model);
    debugPrint(result.data.toString());
  }

  Future<DataLayer<List<GetUserPostModel?>?>> getGroupPost(
    UserProfileInfoModel _userProfileModel,
  ) async {
    List<String> list = [];
    _userProfileModel.groups?.forEach((element) {
      if(element?.groupId != null) {
       list.add(element!.groupId!);
      }
    });

    return await _appHttpRepository
        .getGroupPost(GetGroupPostRequestModel(groupId: list));
  }
}
