// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mdntls/dependency_injection/setup.dart';
import 'package:mdntls/util/router.dart';
import 'package:mdntls/view/post/post_viewmodel.dart';
import '../../model/posts/update_post_model.dart';
import '../../util/app_user.dart';
import '/util/date_util.dart';
import '/model/posts/get_user_post_model.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';
import '../other/icons_util.dart';
import '../text_and_button/simple_text.dart';

class PostBottomRowWidget extends StatefulWidget {
  PostBottomRowWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  GetUserPostModel? model;

  final PostViewModel _postViewModel = getIt<PostViewModel>();

  @override
  State<PostBottomRowWidget> createState() => _PostBottomRowWidgetState();
}

class _PostBottomRowWidgetState extends State<PostBottomRowWidget> {
  bool isLikeIconFull = false;
  bool widgetIsDispose = false;

  @override
  void dispose() {
    widgetIsDispose = true;
    super.dispose();
  }

  @override
  void initState() {
    userLikedControl();
    super.initState();
  }

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
                  onPressed: () {
                    _updatePost();
                  },
                  icon: isLikeIconFull == false
                      ? IconsUtil.likeIcon(size: 25)
                      : IconsUtil.likeIconFull(size: 25),
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
              text:
                  DateUtil.convertTimeMillisToDate(widget.model?.creationTime),
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
      arguments: widget.model?.objectId,
    );
  }

  void _updatePost() {
    if (widget.model == null) return;
    var updatePostModel = UpdatePostModel(
      objectId: widget.model!.objectId,
      likeUserId: AppUser.LOGIN_TOKEN_MODEL?.userId.toString(),
    );
    widget._postViewModel.updatePost(model: updatePostModel);
    setState(() {
      isLikeIconFull = !isLikeIconFull;
    });
  }

  void userLikedControl() async {
    var result = await widget._postViewModel.userLikedThePost(widget.model);
    if (widgetIsDispose) return;
    if (result) {
      setState(() {
        isLikeIconFull = true;
      });
    }
  }
}
