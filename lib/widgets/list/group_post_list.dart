// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget_util/show_toast.dart';
import '/model/profile/group_profile_info.dart';
import '/view/profile/profile_viewmodel.dart';
import '/view/group/group_viewmodel.dart';
import '/widgets/list/post_bottom_row.dart';
import '/dependency_injection/setup.dart';
import '/model/posts/get_user_post_model.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/util/constants.dart';
import '../image/show_list_image.dart';
import '../text_and_button/simple_text.dart';
import '../widget_util/box_decoration.dart';
import '../widget_util/box_decorations.dart';
import '../widget_util/calc_sized_box.dart';
import 'list_item/like_size_text.dart';
import 'list_item/user_image_description.dart';

class GroupPostListWidget extends ConsumerStatefulWidget {
  const GroupPostListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _GroupPostListWidget createState() => _GroupPostListWidget();
}

class _GroupPostListWidget extends ConsumerState<GroupPostListWidget> {
  final Constants _constants = getIt<Constants>();
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();
  List<GetUserPostModel?>? followedUsersPostModel;
  final ProfileViewModel _profileViewModel = getIt<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppUtil.getHeight(context) / 1.25,
          child: FutureBuilder(
            future: _observeGroupPost(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<GetUserPostModel?>?> snapshot,
            ) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapshot.hasError) {
                    ShowToast.errorToast(_constants.TR_GENERAL_ERROR);
                    return Container();
                  } else {
                    return ListView.builder(
                      itemCount:
                          snapshot.data != null ? snapshot.data!.length : 0,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, item) => listViewItem(
                        context,
                        item,
                        snapshot.data![item],
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ],
    );
  }

  Widget listViewItem(
    BuildContext context,
    int item,
    GetUserPostModel? model,
  ) {
    return Column(
      children: [
        const CalcSizedBox(calc: 100),
        SizedBox(
          child: Container(
            constraints: boxConstraintsList(context),
            decoration: BoxDecorationWidgetUtil.borderRadius(borderRadius: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showListImage(
                  context: context,
                  photoName: model?.photoName ?? "",
                  name: model?.groupName,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 15,
                  ),
                  child: SimpleText(
                    textColor: ColorUtil.WHITE,
                    optionalTextSize: 20,
                    text: model?.nameSurname ?? "",
                    textIsNormal: true,
                  ),
                ),
                UserImageDescription(model: model),
                const CalcSizedBox(calc: 50),
                PostBottomRowWidget(model: model),
                const CalcSizedBox(calc: 100),
                LikeSizeText(model: model)
              ],
            ),
          ),
        ),
        const CalcSizedBox(calc: 50),
      ],
    );
  }

  Future<List<GetUserPostModel?>?> _observeGroupPost() async {
    var userProfileModel = await _getMyProfileInfo();
    if (userProfileModel == null) return null;
    var model = await _groupViewModel.getGroupPost(userProfileModel);
    return model.data;
  }

  Future<UserProfileInfoModel?> _getMyProfileInfo() async {
    var model = await _profileViewModel.getMyProfileInfo();
    return model.data;
  }
}
