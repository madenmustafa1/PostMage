import 'package:flutter/material.dart';
import '../../util/color_util.dart';
import '../../util/constants.dart';
import '../../dependency_injection/setup.dart';
import '../../util/app_util.dart';

class RichTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? hideText;
  final int? maxlines;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  const RichTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.hideText,
    this.maxlines,
    this.keyboardType,
    this.suffixIcon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<RichTextField> createState() => _RichTextFieldState();
}

class _RichTextFieldState extends State<RichTextField> {
  Constants constants = getIt<Constants>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        child: TextField(
          minLines: 1,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxlines ?? 1,
          obscureText: widget.hideText ?? false,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            border: InputBorder.none,
            labelText: widget.hintText,
            labelStyle: TextStyle(color: ColorUtil.MAIN_COLOR),
          ),
          style: TextStyle(
            fontSize: AppUtil.getHeight(context) / 50,
            color: ColorUtil.MAIN_COLOR,
            fontWeight: FontWeight.w900,
          ),
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 15,
        ),
      ),
    );
  }
}
