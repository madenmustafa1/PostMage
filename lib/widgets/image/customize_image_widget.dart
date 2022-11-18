import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../util/app_user.dart';
import '../widget_util/box_decoration.dart';
import '/services/service_url.dart';
import '/util/app_util.dart';

class CustomizeImageWidget extends StatelessWidget {
  const CustomizeImageWidget({
    Key? key,
    required this.photoName,
    this.height,
    this.width,
    this.errorIcon,
    this.decoration,
  }) : super(key: key);

  final String photoName;
  final double? height;
  final double? width;
  final Icon? errorIcon;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppUtil.getHeight(context) / 4,
      width: width ?? AppUtil.getWidth(context) / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl: ServiceUrl.BASE_URL + "image/download?photoName=$photoName",
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) =>
              errorIcon ?? const Icon(Icons.error),
          fit: BoxFit.cover,
          httpHeaders: {
            "authorization":
                "Bearer " + AppUser.LOGIN_TOKEN_MODEL!.token.toString()
          },
        ),
      ),
      decoration: decoration ??
          BoxDecorationWidgetUtil.borderRadius(
            borderRadius: 10,
          ),
    );
  }
}
