// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '/util/date_util.dart';
import '/model/posts/get_user_post_model.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '../text_and_button/simple_text.dart';

class CommentBottomRowWidget extends StatelessWidget {
  CommentBottomRowWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  Comment? model;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppUtil.getWidth(context) / 150,
        right: AppUtil.getWidth(context) / 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*
          Row(
            children: [
              IconButton(
                color: ColorUtil.BLACK,
                onPressed: () {},
                icon: IconsUtil.likeIcon(
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SimpleText(
                  text: "0 Like",
                  textIsNormal: true,
                  optionalTextSize: 15,
                ),
              ),
            ],
          ),
          */
          SimpleText(
            textColor: ColorUtil.BLACK,
            textIsNormal: true,
            optionalTextSize: 18,
            text: DateUtil.convertTimeMillisToDate(model?.creationTime),
          ),
        ],
      ),
    );
  }
}
