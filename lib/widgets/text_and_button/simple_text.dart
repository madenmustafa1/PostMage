import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/app_util.dart';
import '../../util/color_util.dart';

// ignore: must_be_immutable
class SimpleText extends StatelessWidget {
  final String text;
  final double? optionalTextSize;
  final Color? textColor;
  final bool? textIsNormal;

  SimpleText(
      {Key? key,
      required this.text,
      this.optionalTextSize,
      this.textColor,
      this.textIsNormal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    defaultTextConfig(context);

    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.visible,
      style: GoogleFonts.oswald(
        textStyle: TextStyle(
          fontSize: optionalTextSize ?? textSize,
          fontWeight:
              textIsNormal == null ? FontWeight.bold : FontWeight.normal,
          color: textColor ?? ColorUtil.DEFAULT_TEXT_COLOR,
        ),
      ),
    );
  }

  //Default
  double textSize = 16;

  void defaultTextConfig(BuildContext context) {
    textSize = AppUtil.getHeight(context) / 18;
  }
}
