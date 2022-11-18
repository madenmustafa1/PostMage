import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdntls/provider/group/get_my_group_list_provider.dart';
import 'package:mdntls/services/data_layer.dart';
import 'package:mdntls/util/app_util.dart';
import 'package:mdntls/widgets/text_and_button/simple_text.dart';
import 'package:mdntls/widgets/widget_util/show_toast.dart';
import '../../../widgets/image/customize_image_widget.dart';
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
  Constants constants = getIt<Constants>();
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();
  List<GetMyGroupListModel?>? groupList;

  @override
  void initState() {
    super.initState();

    getGroupList();
  }

  @override
  Widget build(BuildContext context) {
    groupList = ref.watch(getMyGroupListProvider);
    return Scaffold(
      appBar: BasicAppBar(title: constants.groups),
      body: Column(
        children: [
          groupList != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: groupList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        trailing: const Icon(Icons.settings),
                        leading: Expanded(
                          child: CustomizeImageWidget(
                            photoName: groupList?[index]?.photoName ?? "",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: SimpleText(
                          text: groupList?[index]?.groupName ?? "",
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
        result.errorData?.reason ?? constants.TR_GENERAL_ERROR,
      );
    }
  }
}
