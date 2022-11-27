import 'package:flutter/material.dart';
import 'package:mdntls/model/group/remove_user_group_model.dart';
import 'package:mdntls/services/data_layer.dart';
import 'package:mdntls/widgets/appbar/drawer_menu.dart';
import 'package:mdntls/widgets/widget_util/show_toast.dart';

import '../../../util/constants.dart';
import '/dependency_injection/setup.dart';
import '../group_viewmodel.dart';
import '/model/group/get_my_group_list_model.dart';
import '/util/app_util.dart';
import '/widgets/image/customize_image_widget.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/widget_util/calc_sized_box.dart';

class GetGroupInfoModal {
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();
  final Constants _constants = getIt<Constants>();

  void showModalBottomSheets(
    BuildContext context,
    GetMyGroupListModel? model,
  ) async {
    if (model == null || model.groupId == null) {
      ShowToast.errorToast(_constants.TR_GENERAL_ERROR);
      return;
    }

    var result = await _groupViewModel.getMyGroupListInfo(model.groupId!);

    if (result.status != DataStatus.SUCCESS) {
      ShowToast.errorToast(
        result.errorData?.reason ?? _constants.TR_GENERAL_ERROR,
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            const CalcSizedBox(calc: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SimpleText(
                text: model.groupName ?? "",
                optionalTextSize: AppUtil.getHeight(context) / 20,
                textIsNormal: true,
              ),
            ),
            const CalcSizedBox(calc: 100),
            Expanded(
              child: ListView.builder(
                itemCount: result.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => makeUserAdmin(context),
                            child: const Icon(Icons.person),
                          ),
                          GestureDetector(
                            onTap: () => removeUser(
                              context,
                              UserGroupModel(
                                id: result.data![index]!.id,
                                groupId: model.groupId!,
                              ),
                            ),
                            child: const Icon(Icons.clear_rounded),
                          )
                        ],
                      ),
                    ),
                    leading: CustomizeImageWidget(
                      photoName: result.data?[index]?.profileUrl ?? "",
                      width: 50,
                      height: 50,
                    ),
                    title: SimpleText(
                      text: result.data?[index]?.name ?? "",
                      textIsNormal: true,
                      optionalTextSize: 20,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void removeUser(BuildContext context, UserGroupModel model) async {
    var futureResult = _groupViewModel.putRemoveUserToGroup(model);
    Navigator.pop(context);
    var result = await futureResult;
    if (result.status == DataStatus.SUCCESS) {
      ShowToast.successToast(constants.deleteUserToGroupSuccess);
    } else {
      ShowToast.errorToast(
          result.errorData?.reason ?? constants.TR_GENERAL_ERROR);
    }
  }

  void makeUserAdmin(BuildContext context) async {
    Navigator.pop(context);
  }
}
