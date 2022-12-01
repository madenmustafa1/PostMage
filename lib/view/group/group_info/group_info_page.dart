// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/view/group/group_info/group_info_add_user_modal.dart';
import '/widgets/appbar/basic_appbar.dart';
import '/provider/group/get_my_group_list_info_provider.dart';
import '/dependency_injection/setup.dart';
import '/model/group/get_my_group_list_info.dart';
import '/model/group/get_my_group_list_model.dart';
import '/model/group/remove_user_group_model.dart';
import '/services/data_layer.dart';
import '/util/constants.dart';
import '/widgets/appbar/drawer_menu.dart';
import '/widgets/image/customize_image_widget.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/widgets/widget_util/show_toast.dart';
import '../group_viewmodel.dart';

class GroupInfoPage extends ConsumerStatefulWidget {
  GroupInfoPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();
  final Constants _constants = getIt<Constants>();
  GetMyGroupListModel model;

  final GroupInfoAddUserModal _addUserInfoModal = GroupInfoAddUserModal();

  @override
  _GroupInfoPageState createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends ConsumerState<GroupInfoPage> {
  DataLayer<List<MyGroupListInfo?>?> myGrouListModel =
      DataLayer(status: DataStatus.LOADING);

  @override
  void initState() {
    super.initState();
    getMyGroupListInfo();
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(getGroupListInfoProvider.notifier).update(
          DataLayer(status: DataStatus.LOADING),
        );
  }

  @override
  Widget build(BuildContext context) {
    myGrouListModel = ref.watch(getGroupListInfoProvider);
    return Scaffold(
      appBar: BasicAppBar(title: widget.model.groupName!),
      body: body(),
      floatingActionButton: myGrouListModel.status != DataStatus.SUCCESS
          ? Container()
          : FloatingActionButton(
              tooltip: constants.addUserToGroup,
              child: const Icon(Icons.person_add),
              onPressed: () {
                getFollowerData();
              },
            ),
    );
  }

  Widget body() {
    if (myGrouListModel.status == DataStatus.LOADING) {
      return const Center(child: CircularProgressIndicator());
    } else if (myGrouListModel.status == DataStatus.ERROR) {
      ShowToast.errorToast(
        myGrouListModel.errorData?.reason ?? widget._constants.TR_GENERAL_ERROR,
      );
      Navigator.pop(context);
      return Container();
    } else {
      return Column(
        children: [
          const CalcSizedBox(calc: 100),
          Expanded(
            child: ListView.builder(
              itemCount: myGrouListModel.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => makeUserAdmin(
                            UserGroupModel(
                              id: myGrouListModel.data![index]!.id,
                              groupId: widget.model.groupId!,
                            ),
                          ),
                          tooltip: constants.giveAdminPermission,
                          icon: const Icon(
                            Icons.person,
                          ),
                        ),
                        IconButton(
                          tooltip: constants.removeUserFromGroup,
                          onPressed: () => removeUser(
                            UserGroupModel(
                              id: myGrouListModel.data![index]!.id,
                              groupId: widget.model.groupId!,
                            ),
                          ),
                          icon: const Icon(
                            Icons.clear_rounded,
                          ),
                        )
                      ],
                    ),
                  ),
                  leading: CustomizeImageWidget(
                    photoName: myGrouListModel.data?[index]?.profileUrl ?? "",
                    width: 50,
                    height: 50,
                  ),
                  title: SimpleText(
                    text: myGrouListModel.data?[index]?.name ?? "",
                    textIsNormal: true,
                    optionalTextSize: 20,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  void getMyGroupListInfo() async {
    var result = await widget._groupViewModel.getMyGroupListInfo(
      widget.model.groupId!,
    );

    ref.read(getGroupListInfoProvider.notifier).update(result);
  }

  void removeUser(UserGroupModel model) async {
    var futureResult = widget._groupViewModel.putRemoveUserToGroup(model);
    Navigator.pop(context);
    var result = await futureResult;
    if (result.status == DataStatus.SUCCESS) {
      ShowToast.successToast(constants.deleteUserToGroupSuccess);
    } else {
      ShowToast.errorToast(
          result.errorData?.reason ?? constants.TR_GENERAL_ERROR);
    }
  }

  void makeUserAdmin(UserGroupModel model) async {
    var futureResult = widget._groupViewModel.putAddAdminToGroup(model);
    Navigator.pop(context);
    var result = await futureResult;
    if (result.status == DataStatus.SUCCESS) {
      ShowToast.successToast(constants.adminToGroupSuccess);
    } else {
      ShowToast.errorToast(
          result.errorData?.reason ?? constants.TR_GENERAL_ERROR);
    }
  }

  void getFollowerData() async {
    var result = await widget._groupViewModel.getFollowerData();

    if (result.status == DataStatus.SUCCESS && result.data != null) {
      widget._addUserInfoModal.showModalBottomSheets(
        context,
        result.data!,
        widget.model.groupId!,
        () {
          getMyGroupListInfo();
        },
      );
    } else {
      ShowToast.errorToast(
        result.errorData?.reason ?? constants.TR_GENERAL_ERROR,
      );
    }
  }
}