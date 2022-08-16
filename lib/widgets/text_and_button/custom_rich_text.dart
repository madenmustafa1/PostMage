import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/app_util.dart';
import '../../util/color_util.dart';

// ignore: must_be_immutable
class CustomRichText extends StatelessWidget {
  final String firstText;
  final double? firstOptionalTextSize;
  final Color? firstTextColor;
  final bool? firstTextIsBold;

  final String secondText;
  final double? secondOptionalTextSize;
  final Color? secondTextColor;
  final bool? secondTextIsBold;

  final VoidCallback onPressed;

  CustomRichText({
    Key? key,
    required this.firstText,
    this.firstOptionalTextSize,
    this.firstTextColor,
    this.firstTextIsBold,
    required this.secondText,
    this.secondOptionalTextSize,
    this.secondTextColor,
    this.secondTextIsBold,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: RichText(
        text: TextSpan(
          text: firstText,
          style: returnStyle(
            isBold: firstTextIsBold,
            textColor: firstTextColor,
            fontSize: firstOptionalTextSize,
          ),
          children: [
            TextSpan(
              text: secondText,
              style: returnStyle(
                isBold: secondTextIsBold,
                textColor: secondTextColor,
                fontSize: secondOptionalTextSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Default
  double textSize = 16;

  void defaultTextConfig(BuildContext context) {
    textSize = AppUtil.getHeight(context) / 18;
  }

  TextStyle returnStyle({
    bool? isBold,
    Color? textColor,
    double? fontSize,
  }) {
    if (isBold == true) {
      return GoogleFonts.oswald(
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor ?? ColorUtil.DEFAULT_TEXT_COLOR,
          fontSize: fontSize ?? textSize,
        ),
      );
    } else {
      return GoogleFonts.oswald(
        textStyle: TextStyle(
          color: textColor ?? ColorUtil.DEFAULT_TEXT_COLOR,
          fontSize: fontSize ?? textSize,
        ),
      );
    }
  }
}
