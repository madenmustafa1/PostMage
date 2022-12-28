import 'package:flutter/material.dart';
import '/util/app_util.dart';
import '/widgets/list/group_post_list.dart';
import '/widgets/widget_util/calc_sized_box.dart';
import '/dependency_injection/setup.dart';
import '/util/constants.dart';

class AllGroupsPostPage extends StatelessWidget {
  AllGroupsPostPage({
    Key? key,
  }) : super(key: key);

  final Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      key: key,
      child: SizedBox(
        width: AppUtil.getWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CalcSizedBox(calc: 200),
            GroupPostListWidget(),
          ],
        ),
      ),
    );
  }
}

