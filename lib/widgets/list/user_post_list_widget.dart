import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class UserPostListWidget extends ConsumerWidget {
  UserPostListWidget({Key? key}) : super(key: key);

  final Constants constants = getIt<Constants>();
  final HomeViewModel _homeViewModel = getIt<HomeViewModel>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followedUsersPostModel = ref.watch(getFollowedUsersPostsProvider);
    observeData(ref);
    return Column(
      children: [
        SizedBox(
          height: AppUtil.getHeight(context) / 1.2,
          child: ListView.builder(
            itemCount: followedUsersPostModel != null ? followedUsersPostModel.length : 0,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, item) =>
                listViewItem(context, item, followedUsersPostModel![item]),
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
                showListImage(context: context, item: item),
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
                userImageDescription(model),
                const CalcSizedBox(calc: 50),
                const PostBottomRowWidget(),
                const CalcSizedBox(calc: 100),
                likeSizeText()
              ],
            ),
          ),
        ),
        const CalcSizedBox(calc: 50),
      ],
    );
  }

  Flexible userImageDescription(
    GetUserPostModel? model,
  ) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: SimpleText(
          textColor: ColorUtil.WHITE,
          optionalTextSize: 20,
          text: model?.description ?? "",
          textIsNormal: true,
        ),
      ),
    );
  }

  Widget likeSizeText() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: SimpleText(
          text: "Liked by Mustafa Maden and 27 other",
          optionalTextSize: 16,
          textColor: ColorUtil.WHITE,
          textIsNormal: true,
        ),
      ),
    );
  }

  void observeData(WidgetRef ref) async {
    //if()

    var model = await _homeViewModel.getFollowedUsersPosts();

    var usersPostsProvider = ref.read(getFollowedUsersPostsProvider);
    if (model != null && usersPostsProvider == null) {
      ref.read(getFollowedUsersPostsProvider.notifier).update(model);
    }
  }
}
