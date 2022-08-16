import 'package:flutter/material.dart';
import '/util/app_util.dart';
import '/util/color_util.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.buttonBackgroundColor,
    this.textColor,
    this.buttonStyle,
    this.customRadiusLeft,
    this.customRadiusRight,
    this.customWidgetAligmentLeft,
    this.customWidgetAligmentRight,
    this.customWidgetAligmentPadding,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String buttonText;
  final Color? buttonBackgroundColor;
  final Color? textColor;
  final ButtonStyle? buttonStyle;
  final bool? customRadiusLeft;
  final bool? customRadiusRight;
  final bool? customWidgetAligmentLeft;
  final bool? customWidgetAligmentRight;
  final double? customWidgetAligmentPadding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppUtil.getWidth(context) / 1.5,
        height: AppUtil.getHeight(context) / 15,
        child: ElevatedButton(
            style: buttonStyle ??
                ButtonStyle(
                  backgroundColor: buttonBackgroundColorControl(),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: customBorderRadius(context),
                    ),
                  ),
                ),
            onPressed: () => onPressed(),
            child: customTextWidget(context)),
      ),
    );
  }

  MaterialStateProperty<Color?>? buttonBackgroundColorControl() {
    if (buttonBackgroundColor == null) {
      return MaterialStateProperty.all(ColorUtil.MAIN_COLOR);
    }
    return MaterialStateProperty.all(buttonBackgroundColor);
  }

  BorderRadiusGeometry customBorderRadius(BuildContext context) {
    //Remove null check.
    if (customRadiusLeft == true) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(AppUtil.getWidth(context) / 5),
        topLeft: Radius.circular(AppUtil.getWidth(context) / 5),
      );
    }

    if (customRadiusRight == true) {
      return BorderRadius.only(
        bottomRight: Radius.circular(AppUtil.getWidth(context) / 5),
        topRight: Radius.circular(AppUtil.getWidth(context) / 5),
      );
    }

    return BorderRadius.circular(AppUtil.getWidth(context) / 5);
  }

  Widget customTextWidget(BuildContext context) {
    if (customWidgetAligmentLeft == null && customWidgetAligmentRight == null) {
      return Text(
        buttonText,
        style: TextStyle(
          fontSize: AppUtil.getHeight(context) / 30,
          fontWeight: FontWeight.bold,
          color: textColor ?? ColorUtil.WHITE,
        ),
      );
    }

    return Padding(
      padding: _returnEde(context),
      child: Align(
        alignment: _returnAlignment(),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: AppUtil.getHeight(context) / 30,
            fontWeight: FontWeight.bold,
            color: textColor ?? ColorUtil.WHITE,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Alignment _returnAlignment() {
    if (customWidgetAligmentLeft != null) {
      return Alignment.centerLeft;
    }

    if (customWidgetAligmentRight != null) {
      return Alignment.centerRight;
    }

    return Alignment.center;
  }

  EdgeInsetsGeometry _returnEde(BuildContext context) {
    if (customWidgetAligmentLeft != null) {
      return EdgeInsets.only(left: AppUtil.getHeight(context) / 15);
    }

    if (customWidgetAligmentRight != null) {
      return EdgeInsets.only(right: AppUtil.getHeight(context) / 15);
    }

    return const EdgeInsets.only();
  }
}
