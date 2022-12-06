// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdntls/view/viewmodels/post_viewmodel.dart';
import '/provider/profile/profile_page_provider.dart';
import '/widgets/list/list_item/like_size_text.dart';
import '/enum/list_type.dart';
import '/model/posts/get_user_post_model.dart';
import '/provider/home/home_page_provider.dart';
import '/view/home/home_view_model.dart';
import '/widgets/list/post_bottom_row.dart';
import '/widgets/image/show_list_image.dart';
import '/widgets/widget_util/box_decorations.dart';
import '/dependency_injection/setup.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '/util/constants.dart';
import '../widget_util/box_decoration.dart';
import '../widget_util/calc_sized_box.dart';
import '/widgets/text_and_button/simple_text.dart';
import 'list_item/user_image_description.dart';

class UserPostListWidget extends ConsumerWidget {
  UserPostListWidget({
    Key? key,
    required this.listType,
  }) : super(key: key);

  ListType listType;

  final Constants constants = getIt<Constants>();
  final HomeViewModel _homeViewModel = getIt<HomeViewModel>();
  List<GetUserPostModel?>? followedUsersPostModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    observeData(ref);
    return Column(
      children: [
        SizedBox(
          height: AppUtil.getHeight(context) / 1.27,
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

  void observeData(WidgetRef ref) async {
    if (listType == ListType.HOME) {
      observeDataFollowedUsers(ref);
    } else {
      observeMyPost(ref);
    }
  }

  void observeDataFollowedUsers(WidgetRef ref) async {
    followedUsersPostModel = ref.watch(getFollowedUsersPostsProvider);
    var model = await _homeViewModel.getUsersPosts(listType: listType);

    var usersPostsProvider = ref.read(getFollowedUsersPostsProvider);
    if (model != null && usersPostsProvider == null) {
      ref.read(getFollowedUsersPostsProvider.notifier).update(model);
    }
  }

  void observeMyPost(WidgetRef ref) async {
    followedUsersPostModel = ref.watch(getMyPostProvider);
    var model = await _homeViewModel.getUsersPosts(listType: listType);

    var usersPostsProvider = ref.read(getMyPostProvider);
    if (model != null && usersPostsProvider == null) {
      ref.read(getMyPostProvider.notifier).update(model);
    }
  }
}
