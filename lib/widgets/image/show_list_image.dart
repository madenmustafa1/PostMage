import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mdntls/services/service_url.dart';
import 'package:mdntls/util/app_user.dart';
import 'package:mdntls/util/color_util.dart';
import 'package:mdntls/widgets/text_and_button/simple_text.dart';
import '/model/posts/get_user_post_model.dart';
import '/util/app_util.dart';
import '../widget_util/box_decoration.dart';

Widget showListImage({
  required BuildContext context,
  required GetUserPostModel? model,
  String? name,
}) {
  return Container(
    height: AppUtil.getHeight(context) / 2.8,
    width: AppUtil.getWidth(context),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl: ServiceUrl.BASE_URL +
                "image/download?photoName=${model!.photoName}&objectId=${model.objectId}",
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            httpHeaders: {
              "authorization":
                  "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
            },
          ),
        ),
        name == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 10,
                ),
                child: SimpleText(
                  text: name,
                  optionalTextSize: 25,
                  textColor: ColorUtil.WHITE,
                ),
              ),
      ],
    ),
    decoration: BoxDecorationWidgetUtil.borderRadius(
      borderRadius: 10,
    ),
  );
}
