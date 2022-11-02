import 'package:flutter/material.dart';

import '/model/posts/get_user_post_model.dart';
import '/util/color_util.dart';
import '../../text_and_button/simple_text.dart';

class UserImageDescription extends StatelessWidget {
  UserImageDescription({
    Key? key,
    required this.model,
  }) : super(key: key);

  GetUserPostModel? model;

  @override
  Widget build(BuildContext context) {
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
}
