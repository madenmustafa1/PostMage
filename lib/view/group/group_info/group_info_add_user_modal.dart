import 'package:flutter/material.dart';
import 'package:mdntls/dependency_injection/setup.dart';
import 'package:mdntls/services/data_layer.dart';
import 'package:mdntls/util/constants.dart';
import 'package:mdntls/widgets/widget_util/show_toast.dart';
import '../../../model/group/add_user_to_group_model.dart';
import '../group_viewmodel.dart';
import '/model/profile/get_follower_data.dart';
import '/widgets/image/customize_image_widget.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/widget_util/calc_sized_box.dart';

class GroupInfoAddUserModal {
  Constants constants = getIt<Constants>();
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();

  void showModalBottomSheets(
    BuildContext context,
    GetFollowerDataModel model,
    String groupId,
    VoidCallback callback
  ) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            const CalcSizedBox(calc: 90),
            SimpleText(text: constants.addUserToGroup, optionalTextSize: 26),
            const CalcSizedBox(calc: 90),
            Expanded(
              child: ListView.builder(
                itemCount: model.following.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: GestureDetector(
                      onTap: () => addUser(
                        AddUserToGroupModel(
                          id: model.following[index].userId,
                          groupId: groupId,
                        ),
                        context,
                        callback
                      ),
                      child: const Icon(Icons.add),
                    ),
                    leading: CustomizeImageWidget(
                      photoName: model.following[index].photoUrl ?? "",
                      width: 50,
                      height: 50,
                    ),
                    title: SimpleText(
                      text: model.following[index].nameSurname,
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

  void addUser(AddUserToGroupModel model, BuildContext context, VoidCallback callback) async {
    var result = await _groupViewModel.addUserToGroup(model);

    if (result.status == DataStatus.SUCCESS && result.data == true) {
      ShowToast.successToast(constants.addUserToGroupSuccess);
    } else {
      ShowToast.successToast(
        constants.addUserToGroupFail +
            (result.errorData?.reason ?? constants.addUserToGroupSuccess),
      );
    }
    Navigator.pop(context);
  }
}
