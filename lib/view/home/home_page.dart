// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/enum/list_type.dart';
import '/provider/home/home_page_provider.dart';
import '/widgets/list/user_post_list_widget.dart';
import '/util/app_util.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/dependency_injection/setup.dart';
import 'home_view_model.dart';

class HomePage extends ConsumerWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final HomeViewModel _homeViewModel = getIt<HomeViewModel>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      key: key,
      child: SizedBox(
        width: AppUtil.getWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CalcSizedBox(calc: 65),
            UserPostListWidget(
              listType: ListType.HOME,
            ),
          ],
        ),
      ),
    );
  }

  void forceUpdatePostList(WidgetRef ref) async {
    var model = await _homeViewModel.getUsersPosts(
      listType: ListType.HOME,
    );
    if (model != null) {
      ref.read(getFollowedUsersPostsProvider.notifier).update(model);
    }
  }
}

  /*
 final Constants _constants = getIt<Constants>();

      resizeToAvoidBottomInset: false,
      backgroundColor: ColorUtil.GREY_PLATINUM,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.pushNamed(context, CRouter.ADD_POST);
          if (result != null) forceUpdatePostList(ref);
        },
        backgroundColor: ColorUtil.MAIN_COLOR,
      ),
      drawer: customDrawerMenu(context),
      appBar: BasicAppBar(title: _constants.homePageTitle),
  */