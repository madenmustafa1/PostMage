// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '/model/posts/get_user_post_model.dart';
import '/util/color_util.dart';
import '../../text_and_button/simple_text.dart';

class LikeSizeText extends StatelessWidget {
  LikeSizeText({
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
          text: likeText(model),
          optionalTextSize: 16,
          textColor: ColorUtil.WHITE,
          textIsNormal: true,
        ),
      ),
    );
  }
    String likeText(GetUserPostModel? model) {
    if (model == null || model.likeUserId == null) return "0 Likes";
    return model.likeUserId!.length.toString() + " Likes";
  }

}
