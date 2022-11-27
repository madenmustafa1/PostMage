import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdntls/view/group/group_list/get_group_info_modal.dart';
import '/util/app_util.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/provider/group/get_my_group_list_provider.dart';
import '/services/data_layer.dart';
import '/widgets/text_and_button/simple_text.dart';
import '/widgets/widget_util/show_toast.dart';
import '/widgets/image/customize_image_widget.dart';
import '/model/group/get_my_group_list_model.dart';
import '../group_viewmodel.dart';
import '/widgets/appbar/basic_appbar.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class GroupListPage extends ConsumerStatefulWidget {
  const GroupListPage({Key? key}) : super(key: key);

  @override
  _GroupListPageState createState() => _GroupListPageState();
}

class _GroupListPageState extends ConsumerState<GroupListPage> {
  final Constants _constants = getIt<Constants>();
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();
  List<GetMyGroupListModel?>? _groupList;
  final GetGroupInfoModal _getGroupInfoModal = GetGroupInfoModal();

  @override
  void initState() {
    super.initState();
    getGroupList();
  }

  @override
  Widget build(BuildContext context) {
    _groupList = ref.watch(getMyGroupListProvider);
    return Scaffold(
      appBar: BasicAppBar(title: _constants.groups),
      body: Column(
        children: [
          _groupList != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _groupList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: GestureDetector(
                          onTap: () => _getGroupInfoModal.showModalBottomSheets(
                            context,
                            _groupList![index],
                          ),
                          child: const Icon(Icons.settings),
                        ),
                        leading: CustomizeImageWidget(
                          photoName: _groupList?[index]?.photoName ?? "",
                          width: 50,
                          height: 50,
                        ),
                        title: SimpleText(
                          text: _groupList?[index]?.groupName ?? "",
                          textIsNormal: true,
                          optionalTextSize: 20,
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void getGroupList() async {
    var result = await _groupViewModel.getMyGroupList();

    if (result.status == DataStatus.SUCCESS) {
      ref.read(getMyGroupListProvider.notifier).update(result.data);
    } else {
      ShowToast.errorToast(
        result.errorData?.reason ?? _constants.TR_GENERAL_ERROR,
      );
    }
  }

  void showModalBottomSheets(GetMyGroupListModel model) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            const CalcSizedBox(calc: 100),
            SimpleText(
              text: model.groupName ?? "",
              optionalTextSize: AppUtil.getHeight(context) / 20,
              textIsNormal: true,
            ),
            const CalcSizedBox(calc: 100),
            Expanded(
              child: ListView.builder(
                itemCount: _groupList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    trailing: SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => makeUserAdmin(),
                            child: const Icon(Icons.person),
                          ),
                          GestureDetector(
                            onTap: () => removeUser(),
                            child: const Icon(Icons.clear_rounded),
                          )
                        ],
                      ),
                    ),
                    leading: CustomizeImageWidget(
                      photoName: _groupList?[index]?.photoName ?? "",
                      width: 50,
                      height: 50,
                    ),
                    title: SimpleText(
                      text: _groupList?[index]?.groupName ?? "",
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

  void removeUser() async {
    Navigator.pop(context);
  }

  void makeUserAdmin() async {
    Navigator.pop(context);
  }
}
