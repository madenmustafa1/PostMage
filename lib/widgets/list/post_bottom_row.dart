// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mdntls/util/router.dart';
import '/util/date_util.dart';
import '/model/posts/get_user_post_model.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '../other/icons_util.dart';
import '../text_and_button/simple_text.dart';

class PostBottomRowWidget extends StatelessWidget {
  PostBottomRowWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  GetUserPostModel? model;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(
          left: AppUtil.getWidth(context) / 150,
          right: AppUtil.getWidth(context) / 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  color: ColorUtil.WHITE,
                  onPressed: () {},
                  icon: IconsUtil.likeIcon(
                    size: 25,
                  ),
                ),
                IconButton(
                  color: ColorUtil.WHITE,
                  onPressed: () => goToCommentsPage(context),
                  icon: IconsUtil.commentIcon(size: 25),
                )
              ],
            ),
            SimpleText(
              textColor: ColorUtil.WHITE,
              textIsNormal: true,
              optionalTextSize: 18,
              text: DateUtil.convertTimeMillisToDate(model?.creationTime),
            ),
          ],
        ),
      ),
    );
  }

  void goToCommentsPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      CRouter.COMMENTS,
      arguments: model?.objectId,
    );
  }
}
