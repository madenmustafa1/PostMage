// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/model/profile/group_profile_info.dart';
import '/provider/profile/profile_page_provider.dart';
import '/view/profile/profile_viewmodel.dart';
import '/view/group/group_viewmodel.dart';
import '/provider/group/get_group_post_provider.dart';
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

class GroupPostListWidget extends ConsumerWidget {
  GroupPostListWidget({
    Key? key,
  }) : super(key: key);

  final Constants constants = getIt<Constants>();
  final GroupViewModel _groupViewModel = getIt<GroupViewModel>();
  List<GetUserPostModel?>? followedUsersPostModel;
  UserProfileInfoModel? _userProfileModel;
  final ProfileViewModel _profileViewModel = getIt<ProfileViewModel>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getMyProfileInfo(ref);
    return Column(
      children: [
        SizedBox(
          height: AppUtil.getHeight(context) / 1.25,
          child: ListView.builder(
            itemCount: followedUsersPostModel != null
                ? followedUsersPostModel!.length
                : 0,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, item) => listViewItem(
              context,
              item,
              followedUsersPostModel![item],
            ),
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
                  model: model,
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

  void getMyProfileInfo(WidgetRef ref) async {
    _userProfileModel = ref.watch(getProfileInfoProvider);
    followedUsersPostModel = ref.watch(getGroupPostsProvider);
    var model = await _profileViewModel.getMyProfileInfo();

    if (model.data != null && _userProfileModel == null) {
      _userProfileModel = model.data;
      ref.read(getProfileInfoProvider.notifier).update(model.data);

      observeGroupPost(ref);
    } else if (_userProfileModel != null) {
      observeGroupPost(ref);
    }
  }

  void observeGroupPost(WidgetRef ref) async {
    var model = await _groupViewModel.getGroupPost(_userProfileModel!);

    var getGroupPosts = ref.read(getGroupPostsProvider);
    if (model.data != null && getGroupPosts == null) {
      ref.read(getGroupPostsProvider.notifier).update(model.data!);
    }
  }
}
