import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mdntls/services/service_url.dart';
import 'package:mdntls/util/app_user.dart';
import 'package:mdntls/util/color_util.dart';
import 'package:mdntls/widgets/text_and_button/simple_text.dart';
import '/util/app_util.dart';

Widget showListImage({
  required BuildContext context,
  required String photoName,
  String? name,
  double? radius,
}) {
  return SizedBox(
    height: AppUtil.getHeight(context) / 2.8,
    width: AppUtil.getWidth(context),
    child: Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          child: CachedNetworkImage(
            imageUrl:
                ServiceUrl.BASE_URL + "image/download?photoName=$photoName",
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
  );
}
