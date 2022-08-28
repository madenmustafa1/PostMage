import 'dart:typed_data';

import 'package:flutter/material.dart';

import '/util/app_util.dart';
import '/util/color_util.dart';
import '/widgets/box_decoration.dart';

class AddPostImage extends StatelessWidget {
  AddPostImage({
    Key? key,
    required this.selectedImageBytes,
    required this.callback,
  }) : super(key: key);

  VoidCallback callback;
  Uint8List? selectedImageBytes;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Ink(
        height: AppUtil.getHeight(context) / 3.5,
        width: AppUtil.getWidth(context) / 2,
        child: selectedImageBytes == null
            ? Icon(
                Icons.add,
                color: ColorUtil.WHITE,
                size: 30,
              )
            : Image(
                image: Image.memory(selectedImageBytes!).image,
                fit: BoxFit.cover,
              ),
        decoration: BoxDecorationWidgetUtil.borderRadius(
          borderRadius: 10,
        ),
      ),
    );
  }
}
