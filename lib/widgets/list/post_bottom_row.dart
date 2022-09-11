import 'package:flutter/material.dart';

import '/util/app_util.dart';
import '/util/color_util.dart';
import '../other/icons_util.dart';
import '../text_and_button/simple_text.dart';

class PostBottomRowWidget extends StatelessWidget {
  const PostBottomRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: IconsUtil.likeIcon(
                    size: 25,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: IconsUtil.commentIcon(
                    size: 25,
                  ),
                )
              ],
            ),
            SimpleText(
              textColor: ColorUtil.WHITE,
              textIsNormal: true,
              optionalTextSize: 18,
              text: "04/09/2022",
            ),
          ],
        ),
      ),
    );
  }
}
