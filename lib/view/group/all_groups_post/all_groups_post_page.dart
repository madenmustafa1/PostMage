// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '/util/app_util.dart';
import '/util/router.dart';
import '/widgets/list/group_post_list.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';
import '/widgets/appbar/basic_appbar.dart';

class AllGroupsPostPage extends StatelessWidget {
  AllGroupsPostPage({
    Key? key,
  }) : super(key: key);

  Constants constants = getIt<Constants>();
  //final GroupViewModel _groupViewModel = getIt<GroupViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: constants.groupsPostTitle,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        key: key,
        child: SizedBox(
          width: AppUtil.getWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CalcSizedBox(calc: 200),
              GroupPostListWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "tag-1",
            onPressed: () => Navigator.pushNamed(context, CRouter.GROUP_LIST),
            child: const Icon(Icons.groups),
          ),
          const CalcSizedBox(calc: 100),
          FloatingActionButton(
            heroTag: "tag-2",
            onPressed: () => Navigator.pushNamed(context, CRouter.CREATE_GROUP),
            child: const Icon(Icons.group_add),
          ),
        ],
      ),
    );
  }
}
